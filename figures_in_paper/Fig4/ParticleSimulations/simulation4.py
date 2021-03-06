import numpy as np
import time
import csv
import multiprocessing
import os
from numba import njit

@njit()
def timestep(dist):
    t1 = 1e-5
    t2 = 1e-2
    k = 1
    timestep = (t2-t1)*np.tanh(k*dist)+t1
    return timestep

@njit()
def random_walk(m,d,t,R,rt):
    time = 0
    #set up random IC on circle of radius R away from origin
    x0 = np.random.randn(m)
    norm_x0 = np.sqrt(np.sum(x0**2))
    x0 = R*x0/norm_x0 #x0/||x_0|| is random on the unit sphere
    #####
    # trajectory = []
    # trajectory.append(x0)
    trapped = False
    #####
    while time < t:
        if trapped == False:
            dist = np.sqrt(np.sum(x0**2)) - rt
            if dist < 0:
                dist = 0
            dt = timestep(dist)
            s = np.sqrt(2*m*d*dt)*np.random.randn(1)
            dx = np.random.randn(m)
            norm_dx = np.sqrt(np.sum(dx**2))
            x = x0 + s*dx/norm_dx
            # trajectory.append(x)
            time = time + dt
            if np.sum(x**2) < rt**2:
                trapped = True
            x0 = x
        elif trapped == True:
            break
    return trapped, time

def FractionAbsorbed(d,rt):
    m = 2 #spatial dimension, can be 2 or 3 but not set up for 1d
    t = 1800.0 #total time
    R = 1 #circle radius

    # num_particles = 5000
    trappeds = []
    times = []
    k = 0
    # for k in range(num_particles):
    maxnum = 60000
    N = 1000
    while (len(trappeds) < N) & (k < maxnum):
        trapped,time = random_walk(m,d,t,R,rt)
        if trapped == True:
            trappeds.append(trapped)
            times.append(time)
        k = k+1
    return times

def parallel_fun(fn,input_args,num_threads):
    #need to make list of pairs of d rt to pass to function...
    with multiprocessing.Pool(num_threads) as pool:
        out = pool.starmap(fn,input_args)

        return np.array(out)

def get_cpus_per_task():
  """ Returns the SLURM environment variable if set else throws
  KeyError """
  try:
    return os.environ["SLURM_CPUS_PER_TASK"]
  except KeyError:
    print("SLURM environment variable unset: \
        use salloc or sbatch to launch job")
    raise

# CPUS_PER_TASK = int(get_cpus_per_task())
CPUS_PER_TASK = 4

#%%
begin = time.time()

D = np.logspace(-4,-1,15)
rt = np.linspace(1e-2,0.99,15)

input_args = [(x,y) for x in D for y in rt]
input_args = input_args[4::15]

prop = parallel_fun(FractionAbsorbed,input_args,CPUS_PER_TASK)

data = []
for i in range(len(prop)):
    D = input_args[i][0]
    rt = input_args[i][1]
    print(len(prop[i]))
    for j in range(len(prop[i])):
        traptime = prop[i][j]
        data.append([D,rt,traptime])

np.save('data4.npy', data)

end = time.time()
print(end-begin)
