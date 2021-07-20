
import wandb 




from pore_utils import rnd_array
from network_tools import get_masks






def train_multiscale(model, params):
    
    x     = rnd_array( size=128, scales = 4 )
    masks = get_masks( x[-1],    scales = 4 )
    
    
    
    wandb.watch(model, log='all', log_freq=1)
    
    for epoch in range( 10000 ):
        
        y = model( x, masks )[-1] # final prediction
        loss = 100 - epoch
        tmp = loss*2
    
        if epoch % params.log_interval == 0:
            wandb.log({'loss': loss, 
                       'extra_stuff': tmp,
                       'epoch': epoch })