import numpy as np

import torch

from network_tools import scale_tensor


def get_coarsened_list(x, scales):
    """
    X : 3D np array
    returns a list with the desired number of coarse-grained tensors
    """
    
    # converts to tensor and adds channel and batch dim
    x = torch.Tensor(add_dims(x, 1))
    
    ds_x = []
    ds_x.append(x)
    
    for i in range( scales-1 ): 
        ds_x.append( scale_tensor( ds_x[-1], scale_factor=1/2 ) )
    return ds_x[::-1] # returns the reversed list (small images first)




"""
Tensor operations
"""

def changepres(x, ttype=None):
    if ttype == 'f32':
        return x.float()
    elif ttype == 'f16':
        return x.half()

    
def torchpres(x, ttype=None):
    
    if isinstance(x,list) == True:
        x = [torchpres(xi, ttype) for xi in x]
    else:
        x = changepres(x, ttype)
    return x
    

def gpu2np(x):
    if type(x) == list:
        x = [gpu2np(xi) for xi in x]
    else:
        x = x.detach().cpu().numpy().squeeze()
    return x

def add_dims(x, num_dims):
    for dims in range(num_dims):
        x = x[np.newaxis]
    return x



def rnd_arrays(size, scales, device='cpu'):
    
    return get_coarsened_list( ((torch.rand(1,
                                            size,
                                            size,
                                            size)>0.5)*1.0).to(device),scales)
    
    