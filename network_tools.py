import numpy as np

import torch
import torch.nn as nn







def calc_loss(y_pred, y, loss_f, logs):
    
    loss = 0
    y_var = y[-1].var()
    
    for scale, [y_hat,yi] in enumerate(zip(y_pred, y)):
        loss_scale = loss_f(y_hat,yi)/y_var 
        loss += loss_scale
                
        logs.setdefault(f'loss_scale_{scale}',0)
        logs[f'loss_scale_{scale}'] += loss_scale.item()
    logs.setdefault('loss',0)
    logs['loss'] += loss.item()
    
    return loss, logs




def mean_vel(y_pred):
    means = []
    for pred in y_pred:
        means.append(pred.mean().item())
    return means




def scale_tensor(x, scale_factor=1, mode='nearest'):
    
    
    if mode == 'nearest':
        if scale_factor<1:
            return nn.AvgPool3d(kernel_size = int(1/scale_factor))(x)
        
        elif scale_factor>1:
            for repeat in range (0, int(np.log2(scale_factor)) ):  #number of repeatsx2
                for ax in range(2,5):
                    x=x.repeat_interleave(repeats=2, axis=ax)
            return x
        
        elif scale_factor==1:
            return x
        
        else: raise ValueError(f"Scale factor not understood: {scale_factor}")
        
    else:
        NotImplemented

def get_masks(x, scales):
    """
    x: euclidean distance 3D array at the finest scale
    Returns array with masks
    
    Notes:
        for n scales we need n masks (the last one is binary)
    """    
    masks    = [None]*(scales)
    pooled   = [None]*(scales)
    
    pooled[0] = (x>0).float() # 0s at the solids, 1s at the empty space
    masks[0]  = pooled[0].squeeze(0)
    
    for scale in range(1,scales):
        pooled[scale] = nn.AvgPool3d(kernel_size = 2)(pooled[scale-1])
        denom = pooled[scale].clone()   # calculate the denominator for the mask
        denom[denom==0] = 1e8  # regularize to avoid divide by zero
        for ax in range(2,5):   # repeat along 3 axis
            denom=denom.repeat_interleave( repeats=2, axis=ax )
        masks[ scale ] = torch.div( pooled[scale-1], denom ).squeeze(0)
    return masks[::-1] # returns a list with masks. smallest size first
        