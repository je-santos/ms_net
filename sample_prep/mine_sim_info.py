import numpy as np
from hdf5storage import loadmat

import glob
import os

import matplotlib.pyplot as plt    
    
import pandas as pd


# check if they are multiple files

results = {}
folder = 'domains_real/'
o_files = [os.path.basename(x) for x in glob.glob(folder + '/*.o*')]

for file in o_files:
    sim_name = file.split('.',1)[0]
    try:
        results[sim_name]
        results[sim_name]['num_sims'] += 1
    except KeyError:
        results[sim_name] = {}
        results[sim_name]['num_sims'] = 1 
        
    num_sim = results[sim_name]['num_sims']
    results[sim_name][f'convergence_{num_sim}'] = False

    text = open(folder + file)
    conv = None
    for line in text:
        if line.find('Velocity convergence')>-1:
            conv = float(line.split()[2])
        if line.find('simulation has reached velocity convergence')>-1:
            results[sim_name][f'convergence_{num_sim}'] = True
            count = 0
        if results[sim_name][f'convergence_{num_sim}'] == True:
            count += 1
            if count == 3: 
                it = [int(i) for i in line.split() if i.isdigit()][0]
                results[sim_name][f'it_{num_sim}'] = it
                #it = line
            if count == 4: #sim time
                #print(line)
                simtime = float(line.split()[3])/3600
                results[sim_name][f'time_{num_sim}'] = simtime 
    results[sim_name][f'conv_{num_sim}'] = conv
    