import numpy as np
import torch
import torch.nn as nn

from network_tools import scale_tensor

"""
The MS-Net 
A Computationally Efficient Multiscale Neural Network 


The code to generate each individual conv model was modified from:
https://github.com/tamarott/SinGAN

"""


def get_trainable_models(scales, features, filters, f_mult):
    
    """
    Returns an array with n-trainable models (ConvNets)
    """
    
    models   = []         # empty list to store the models
    nc_in    = features   # number of inputs on the first layer
    norm     = True       # use Norm
    last_act = 'CELU'     # activation function
    
    # list of number filters in each model (scale)
    num_filters = [ filters*f_mult**scale for scale in range(scales) ][::-1]
    print(f'Filters per model: {num_filters}')
   
    for it in range( scales ): # creates a model for each scale
        if it==1: nc_in+=1     # adds an additional input to the subsecuent models 
                               # to convolve the domain + previous(upscaled) result 
        models.append( get_model( nc_in    = nc_in,
                                  ncf      = num_filters[it],
                                  norm     = norm,
                                  last_act = last_act) )
    return models  


class get_model(nn.Module):
    def __init__(self, nc_in, ncf, norm, last_act):
        super(get_model, self).__init__()
        
        # default parameters
        nc_out     = 1   # number of output channels of the last layer
        ker_size   = 3   # kernel side-lenght
        padd_size  = 1   # padding size
        ncf_min    = ncf # min number of convolutional filters
        num_layers = 5   # number of conv layers
        
        # first block
        self.head = ConvBlock3D( in_channel  = nc_in,
                                 out_channel = ncf,
                                 ker_size    = ker_size,
                                 padd        = padd_size,
                                 stride      = 1,
                                 norm        = norm )
        
        # body of the model
        self.body = nn.Sequential()
        for i in range( num_layers-1 ):
            new_ncf = int( ncf/2**(i+1) )
            if i==num_layers-1: norm=False  # no norm in the penultimate block
          
            convblock = ConvBlock3D( in_channel  = max(2*new_ncf,ncf_min),
                                     out_channel = max(new_ncf,ncf_min),
                                     ker_size    = ker_size,
                                     padd        = padd_size,
                                     stride      = 1,
                                     norm        = norm)
            
            self.body.add_module( f'block{i+1}', convblock )
        
        if last_act == 'CELU':
            self.tail = nn.Sequential(
                                    nn.Conv3d( max(new_ncf,ncf_min), nc_out,
                                               kernel_size=1,stride=1, padding=0),
                                    nn.CELU()
                                 )
        else:
            self.tail = nn.Sequential(
                            nn.Conv3d( max(new_ncf,ncf_min), nc_out, kernel_size=1,
                                       stride=1, padding=0))
            
    def forward(self,x):
        x = self.head(x)
        x = self.body(x)
        x = self.tail(x)
        return x




class ConvBlock3D( nn.Sequential ):
    def __init__(self, in_channel, out_channel, ker_size, padd, stride, norm):
        super(ConvBlock3D,self).__init__()
        self.add_module( 'conv',
                         nn.Conv3d( in_channel, 
                                    out_channel,
                                    kernel_size=ker_size,
                                    stride=stride,
                                    padding=padd ) ),
        if norm == True:
            self.add_module( 'i_norm', nn.InstanceNorm3d( out_channel ) ),
        self.add_module( 'CeLU', nn.CELU( inplace=False ) )
        
        

class MS_Net(nn.Module):
    
    def __init__(
                 self, 
                 net_name     = 'test1', 
                 num_scales   =  4,
                 num_features =  1, 
                 num_filters  =  2, 
                 f_mult       =  4,  
                 device       =  'cpu'
                 ):
        
        super(MS_Net, self).__init__()
        
        self.net_name = net_name
        self.scales   = num_scales
        self.feats    = num_features
        self.feats    = num_features
        self.device   = device
        
        self.models   = nn.ModuleList( 
                                get_trainable_models( num_scales,
                                                      num_features,
                                                      num_filters,
                                                      f_mult ) )
        
        
        
    def forward(self, masks, x_list):
        assert x_list[0].shape[1] == self.feats, \
        f'The number of features provided {x_list[0].shape[1]} \
            does not match with the input size {self.feats}'
        # Carry-out the first prediction (pass through the coarsest model)
        y = [ self.models[0]( x_list[0] ) ]
        for scale,[ model,x ] in enumerate(zip( self.models[1:],x_list[1:] )):
            y_up = scale_tensor( y[scale], scale_factor=2 )*masks[scale]
            y.append( model( torch.cat((x,y_up),dim=1) ) + y_up )
        return y
        
        
    def scale_init(self):
        factor  = 0.3*np.e**(1.9*self.scales)/2
        for num, model in enumerate( self.models ):
            model.tail[0].weight = torch.nn.Parameter(model.tail[0].weight/factor)
            #model.tail[0].bias   = torch.nn.Parameter(model.tail[0].bias/factor)
            
            
    def test(self, masks, x1, x2):
        with torch.no_grad():
            y_up    = [0]*self.scales # upscaled prediction from coarser model
            x = [ torch.cat((xi1, xi2), dim=1) for xi1, xi2 in zip(x1,x2) ]
            del x1, x2
            for scale, model in enumerate( self.models ):
                if scale == 0:
                    y_up[scale] = model( x[scale] ) 
                else:
                    y_up = [scale_tensor(y,scale_factor=2)*masks[scale-1] if torch.is_tensor(y) else 0 for y in y_up]
                    y_scale = sum(y_up)
                    y_up[scale] = model(torch.cat((x[scale],y_scale), dim=1))+y_scale
                    del y_scale
            return y_up[-1]
    
    def save_model(self):
        torch.save(self.models, 
                   f'savedModels/{self.net_name}/{self.net_name}.pt')
        
    def save_as(self, name):
        torch.save(self.models, 
                   f'savedModels/{self.net_name}/{self.net_name}_{name}.pt')
        
    def load_model(self):
        try:
            self.models=torch.load(
                f'savedModels/{self.net_name}/{self.net_name}.pt',
                map_location=self.device)
            print('Model loaded succesfully')
            return True
        except FileNotFoundError:
            print('No pre-trained model found')
            return False

    def load_as(self, name):
        try:
            self.models=torch.load(
                f'savedModels/{self.net_name}/{self.net_name}_{name}.pt',
                map_location=self.device)
            print('Model loaded succesfully')
            return True
        except FileNotFoundError:
            print(f'No model called {name} found')
            return False
        
    def num_params(self):
        return sum(p.numel() for p in self.models.parameters() if p.requires_grad)
    
    def maxsize_singlescale(self):
        with torch.set_grad_enabled( False ):
            for cube_size in np.arange(256,1000,64):
                print(f'Trying out size {cube_size}')
                try:
                    y = self.models[-1](torch.ones([1,3,cube_size,cube_size,cube_size]).to('cuda'))
                    del y
                except RuntimeError:
                    return cube_size-64