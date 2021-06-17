# MS-Net: Computationally Efficient Multiscale Neural Network 

Implementation of <a href="https://link.springer.com/article/10.1007/s11242-021-01617-y">The MS-Net</a> in Pytorch. This model provides an easy and effcient way to train neural networks with computationally large 3D arrays. The application shown in the paper considered simulations of flow thorugh porous materials, but the method is general and should be applicable to any other application involving 3D arrays.


## Usage

```python
import torch

from network import MS_Net
from pore_utils import rnd_array
from network_tools import get_masks

net = MS_Net( 
              num_scales   := 4,   # num of trainable convNets
              num_features  = 1,   # input features (Euclidean distance, etc)
              num_filters   = 2,   # num of kernels on each layer of the finest model (most expensive)
              summary       = True # print the model summary
)

x     = rnd_array( size=128, scales = num_scales )
masks = get_masks( x[-1],    scales = num_scales )
y     = net( x, masks )
