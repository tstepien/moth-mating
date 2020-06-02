from __future__ import division

__authors__ = 'Noam Benelli and modified by Tracy Stepien'


from job_generator import generate_job
from casting_strategyA import create_trajectory_data
from stats_compare1strategy import calculate_stats
from pathlib import Path

"""
generates several job files containing the conditions of the simulations
calls upon "casting competition" to create trajectory data
(each call simulates strategy A navigator type in one plume simulation)

"""

if __name__ == "__main__":
    num_jobs = 10
    for i in range(num_jobs):
        detectthresh = 1640
        speed = 50
        molamount = 41.28
        timesimulated = 20

        sim_name = 'detectthresh-'+str(detectthresh)+'_speed-'+str(speed)+'_molamount-'+str(molamount)+'_timesimulated-'+str(timesimulated)+'/'
        Path('sims/'+sim_name).mkdir(parents=True, exist_ok=True)

        job_file_name = 'sims/'+sim_name+'job'+ str(i)+ '.json'
        data_file_name = 'sims/'+sim_name+'data'+ str(i)+ '.json'

        generate_job(char_time = 7, amplitude = 0.1, job_file = job_file_name,
                     t_max = timesimulated, dt = 0.01, num_it = 1, puff_spread_rate = 0.0001, 
                     puff_release_rate = 50+i*(200-50)/(num_jobs-1), detect_threshold = detectthresh,
                     flight_speed = speed, puff_mol_amount = molamount
                     )
        navigator_titles = create_trajectory_data(job_file_name,data_file_name)
        print ('finished simulation number ' + str(i+1))

# run the plots right after running the simulation
#exec(open("stats_compare1strategy.py").read())

# run stats right after running the simulation
calculate_stats(sim_name,num_jobs)
