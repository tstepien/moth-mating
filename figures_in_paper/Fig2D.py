import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid.inset_locator import (inset_axes, InsetPosition, mark_inset)

plt.rc("text", usetex=False)
plt.rc("font", family="sans-serif", size=10)

def timestep(dist):
    t1 = 1e-5
    t2 = 1e-2
    k = 1
    timestep = (t1*(-np.exp(-2*k)+np.exp(dist*-k)) + t2*(-np.exp(dist*-k)+1))/(1-np.exp(-2*k))
    return timestep

def random_walk(m,d,t,rt):
    time = 0
    #set up random IC on circle of radius R away from origin
    x0 = np.random.randn(m)
    norm_x0 = np.sqrt(np.sum(x0**2))
    x0 = x0/norm_x0
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

def FractionAbsorbed(d,num_particles):
    m = 2 #spatial dimension, can be 2 or 3 but not set up for 1d
    # t = 1000 #28800.0 #total time
    t = 100
    #####
    #need to find a bounding circle for plume
    rt = 0.2
    # print(R_bound)
    trappeds = []
    trajs = []
    dts = []

    for k in range(num_particles):
        trapped, trajectory, dt = random_walk(m,d,t,rt)
        trappeds.append(trapped)
        trajs.append(trajectory)
        dts.append(dt)

    return sum(trappeds)/num_particles, trajs, dts

# D = np.array([1e-1, 5e-2, 1e-2, 5e-3, 1e-3, 5e-4, 1e-4])
d = 0.1
# Q = np.arange(1,11)
# Ctol = np.logspace(-3,-1,3)

# alpha = 0.01
# R_bound, xbar, ybar = plume_bounding_radius(alpha)

fig = plt.figure(figsize=(6,3))
ax = plt.subplot(111)
linewidth = 1
ax.spines["left"].set_linewidth(linewidth)
ax.spines["top"].set_linewidth(linewidth)
ax.spines["right"].set_linewidth(linewidth)
ax.spines["bottom"].set_linewidth(linewidth)
# ax.grid(linewidth=linewidth)
# ax.grid(True)
ax.tick_params(axis="both", direction="in", which="both", right=True, top=True , width=linewidth)
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_aspect('equal', 'box')
# [x,y] = np.meshgrid(np.linspace(0,100,1000),np.linspace(-50,50,1000))
# M = plt.contour(x,y,f(x,y),[alpha])
# xc = M.allsegs[0][0][:,0]
# yc = M.allsegs[0][0][:,1]
#
# xbar = ((np.max(xc)) + (np.min(xc)))/2
# ybar = ((np.max(yc)) + (np.min(yc)))/2
# plt.plot(xc,yc,'k-',label='Plume Level Set')
# # plt.scatter(xbar,ybar)
angles = np.linspace(0,2*np.pi,100)
plt.plot(0.2*np.cos(angles),0.2*np.sin(angles),'k',label='Circular Trap')
plt.plot(1*np.cos(angles),1*np.sin(angles),'k--',label='Initial Position')

np.random.seed(42)
num_particles = 6
prop, traj, dts = FractionAbsorbed(d,num_particles)
for moth in range(0,num_particles):
    trajectory = np.asarray(traj[moth])
    if moth == 0:
        plt.plot(trajectory[:,0],trajectory[:,1],lw=1,label='Trajectories')
    elif moth == 2:
        print('hi')
        #do nothing
    else:
        plt.plot(trajectory[:,0],trajectory[:,1],lw=1)
plt.xlim([-1.5,1.5])
plt.ylim([-1.5,1.5])

# plt.xlim([-0.5,0.5])
# plt.ylim([-0.5,0.5])
# plt.plot(20,0,'ko',label='Starting Location')
# ax.set_xlim(-10,75)

# axins = ax.inset_axes([0.5,0.05,45/100,(3/2)*45/100])
# mark_inset(ax, axins, loc1=2, loc2=3, fc="none", ec='0.5')
#
# axins.spines["left"].set_linewidth(linewidth)
# axins.spines["top"].set_linewidth(linewidth)
# axins.spines["right"].set_linewidth(linewidth)
# axins.spines["bottom"].set_linewidth(linewidth)
# # axins.grid(linewidth=linewidth)
# # axins.grid(True)
# axins.tick_params(axis="both", direction="in", which="both", right=True, top=True , width=linewidth)
# for moth in range(0,num_particles):
#     trajectory = np.asarray(traj[moth])
#     if moth == 0:
#         axins.plot(trajectory[:,0],trajectory[:,1],lw=1,label='trajectories')
#     else:
#         axins.plot(trajectory[:,0],trajectory[:,1],lw=1)
# plt.xlim([-0.1,1.5])
# plt.ylim([-1,1])
# axins.plot(20,0,'ko',label='starting location')
# axins.set_xlim(-2,23)
# axins.set_ylim(-12.5,12.5)
# axins.set_xticklabels('')
# axins.set_yticklabels('')
# axins.plot(xc,yc,'k-',label='plume level set')
# plt.scatter(xbar,ybar)
# axins.plot(R_bound*np.cos(angles)+xbar,R_bound*np.sin(angles)+ybar,'k--',label='bounding circle')

plt.legend(ncol=1,prop={'size': 8},loc=1)

# plt.savefig('example.tif',dpi=600)
# plt.savefig('example.jpg',dpi=600)
# ax1 = plt.subplot(122)
# ax1.spines["left"].set_linewidth(linewidth)
# ax1.spines["top"].set_linewidth(linewidth)
# ax1.spines["right"].set_linewidth(linewidth)
# ax1.spines["bottom"].set_linewidth(linewidth)
# # ax.grid(linewidth=linewidth)
# # ax.grid(True)
# x = np.linspace(0,1,100)
# ax1.tick_params(axis="both", direction="in", which="both", right=True, top=True , width=linewidth)
# ax1.set_xlabel('Distance to Trap')
# ax1.set_ylabel('Time Step')
# ax1.plot(x,timestep(x))
# # ax1.set_aspect('box')
# # ax1.set_position(ax.get_position)
# ax1.set_xlim([0,1])
plt.tight_layout()

plt.savefig('BrownianParticles.eps')
plt.show()
