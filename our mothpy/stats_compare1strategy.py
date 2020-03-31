# -*- coding: utf-8 -*-
"""
an illustration of how a single navigator types stats 
"""

from __future__ import division
from avgtime_success_1strategy import get_data
import json
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

__authors__ = 'Noam Benelli and modified by Tracy Stepien'

def detect_change(job_list):
    for key in job_list[0]:
        if job_list[0][key] != job_list[1][key]:
           sig_key = key
           break
    value_list =[]
    for job in job_list:
        value_list.append(job[sig_key])
        
    return (sig_key, value_list)

def process_jobs(num_jobs,sim_name):
    job_list = []
    for i in range(num_jobs):
        file_name = 'sims/'+sim_name+'job'+str(i)+'.json'
        with open(file_name) as data_file1:  
            job = json.load(data_file1)
        job_list.append(job)
    return detect_change(job_list)

def calculate_stats(sim_name,num_jobs):
    (xlabel,values)=process_jobs(num_jobs,sim_name)
    legends = ('A')
    liberzonlist =[]
    for i in range(num_jobs):
        loop = str(i)
        data_list = get_data('sims/'+sim_name+'data'+loop+'.json',1)
        liberzonlist.append(data_list[0])
    lib_succ,lib_avg,lib_mintime,lib_efficiency = zip(*liberzonlist)



    ##### save statistics to file
    stats = {}

    stats['statistics'] = {'successpercentage': lib_succ, 'meanarrivaltime': lib_avg, 'minarrivaltime': lib_mintime}

    with open('sims/'+sim_name+'statistics.json', 'w') as outfile:
        json.dump(stats, outfile)


    
if __name__ == "__main__":
	calculate_stats()
