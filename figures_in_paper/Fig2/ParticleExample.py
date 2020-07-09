import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid.inset_locator import (inset_axes, InsetPosition, mark_inset)

plt.rc("text", usetex=False)
plt.rc("font", family="sans-serif", size=10)

def timestep(dist):
    t1 = 1e-5
    t2 = 1e-2
    k = 1
    timestep = (t2-t1)*np.tanh(k*dist)+t1
    return timestep

def random_walk(m,d,t,rt,k,num):
    time = 0
    #set up NICE ICs for plotting
    x = np.cos(2*k*np.pi/num)
    y = np.sin(2*k*np.pi/num)
    x0 = 5*np.array([x,y])
    #use RANDOM ICs for the real deal
    # x0 = np.random.randn(m)
    # norm_x0 = np.sqrt(np.sum(x0**2))
    # x0 = x0/norm_x0
    # print(x0)
    #####
    trajectory = []
    trajectory.append(x0)
    trapped = False

    dts = []
    #####
    while time < t:
        if trapped == False:
            dist = np.sqrt(np.sum(x0**2)) - rt
            if dist < 0:
                dist = 0
            dt = timestep(dist)
            dts.append(dt)
            s = np.sqrt(2*m*d*dt)*np.random.randn(1)
            dx = np.random.randn(m)
            norm_dx = np.sqrt(np.sum(dx**2))
            x = x0 + s*dx/norm_dx
            trajectory.append(x)
            time = time + dt
            # print(time)
            if np.sum(x**2) < rt**2:
                trapped = True
            x0 = x
        elif trapped == True:
            break
    return trapped, trajectory, dts

def FractionAbsorbed(d,num_particles,rt):
    m = 2 #spatial dimension, can be 2 or 3 but not set up for 1d
    # t = 1000 #28800.0 #total time
    t = 10
    #####
    trappeds = []
    trajs = []
    dts = []

    for k in range(num_particles):
        trapped, trajectory, dt = random_walk(m,d,t,rt,k,num_particles)
        trappeds.append(trapped)
        trajs.append(trajectory)
        dts.append(dt)

    return sum(trappeds)/num_particles, trajs, dts


fig = plt.figure(figsize=(2,2))
ax = plt.subplot(111)

linewidth = 1
ax.spines["left"].set_linewidth(linewidth)
ax.spines["top"].set_linewidth(linewidth)
ax.spines["right"].set_linewidth(linewidth)
ax.spines["bottom"].set_linewidth(linewidth)

ax.tick_params(axis="both", direction="in", which="both", right=True, top=True , width=linewidth)
# ax.set_xlabel('x')
# ax.set_ylabel('y')
ax.set_aspect('equal', 'box')

np.random.seed(42)
d = 1
num_particles = 6
rt = 1

prop, traj, dts = FractionAbsorbed(d,num_particles,rt)
for moth in range(0,num_particles):
    trajectory = np.asarray(traj[moth])
    if moth == 0:
        plt.plot(trajectory[:,0],trajectory[:,1],lw=1,label='Trajectories')
    else:
        plt.plot(trajectory[:,0],trajectory[:,1],lw=1)
plt.xlim([-6,6])
plt.ylim([-6,6])

angles = np.linspace(0,2*np.pi,100)
plt.plot(5*np.cos(angles),5*np.sin(angles),'k:',label='Initial Condition')
plt.plot(rt*np.cos(angles),rt*np.sin(angles),'k-',label='Circular Trap')
x = np.empty(num_particles)
y = np.empty(num_particles)
# for k in range(num_particles):
#     x[k] = np.cos(2*k*np.pi/num_particles)
#     y[k] = np.sin(2*k*np.pi/num_particles)
# plt.scatter(x,y,3,'k')
# plt.legend(ncol=1,prop={'size': 8},loc=1)
plt.tight_layout()
fig.savefig('BrownianParticles.png',format='png',dpi=600)
fig.savefig('BrownianParticles.eps',format='eps')

plt.show()
