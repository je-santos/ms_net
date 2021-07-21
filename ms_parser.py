import argparse
import torch

code_version = 0.001


def parse_args():

    # function to parse boolean args
    def str2bool(v):
        if isinstance(v, bool):
            return v
        if v.lower() in ("yes", "true", "t", "y", "1"):
            return True
        elif v.lower() in ("no", "false", "f", "n", "0"):
            return False
        else:
            raise argparse.ArgumentTypeError("Boolean value expected.")

    # Command-line argument parser
    parser = argparse.ArgumentParser(description="MS-Net properties.")

    parser.add_argument("--net_name",    default="test_4", type=str)
    parser.add_argument("--num_scales",  default=4,        type=int)
    parser.add_argument("--num_filters", default=2,        type=int)
    parser.add_argument("--f_mult",      default=4,        type=int)
    parser.add_argument("--LR",          default=1e-4,     type=float)
    parser.add_argument("--batch_size",  default=5,        type=int)
    parser.add_argument("--epochs",      default=99999,    type=int)
    
    parser.add_argument("--log_interval", default=20, type=int)
    
    parser.add_argument("--data_aug", type=str2bool, default=False)
    parser.add_argument("--train",    type=str2bool, default=False)
    
    parser.add_argument("-gpu", default="0", type=str,
             help="GPU to train on 0-3 (if a cluster is available)")
    
    args = parser.parse_args()
    
    args.torch_version = torch.__version__
    args.code_version  = code_version
    print(args)
    return args # returns a namespace


