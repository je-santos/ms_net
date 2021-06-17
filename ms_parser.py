import argparse


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

    parser.add_argument("--net_name", default="test_4", type=str)
    parser.add_argument("--scales", default=4, type=int)
    parser.add_argument("--filters", default=2, type=int)
    parser.add_argument("--LR", default=1e-4, type=float)
    
    parser.add_argument("--data_aug", type=str2bool, default=0)
    parser.add_argument("--train", type=str2bool, default=0)
    
    
    parser.add_argument(
        "-gpu",
        default="0",
        type=str,
        help="GPU to train on 0-3 (if a cluster is available)",
    )
    args = parser.parse_args()

   
    print(args)

    return args


