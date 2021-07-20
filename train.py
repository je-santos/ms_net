import wandb
from ms_parser import parse_args

from network import MS_Net
from training_loops import train_multiscale


params = parse_args()
params.dataset_loc = '../xx'


wandb.init( project='test1', 
            notes= 'NA',
            tags = ['dataset_test1','first_test'],
            config=params )


ms_net = MS_Net( net_name     = params.net_name,
                 num_scales   = params.num_scales,    
                 num_filters  = params.num_filters,   
                 f_mult       = params.f_mult, 
                 num_features = 1 )



#if params.train:
if True:
    x = train_multiscale(ms_net, params)
