import matplotlib.pyplot as plt
import matplotlib.colors as colors
import numpy as np
import pandas as pd
import seaborn as sns
from matplotlib import ticker, cm


plt.rc("text", usetex=False)
plt.rc("font", **{'family':'sans-serif','sans-serif':['Helvetica'],'size':12})
plt.rcParams['ps.usedistiller'] = 'xpdf'


d0 = np.load('data0.npy')
d1 = np.load('data1.npy')
d2 = np.load('data2.npy')
d3 = np.load('data3.npy')
d4 = np.load('data4.npy')
d5 = np.load('data5.npy')
d6 = np.load('data6.npy')
d7 = np.load('data7.npy')
d8 = np.load('data8.npy')
d9 = np.load('data9.npy')

data = np.r_[d0,d1,d2,d3,d4,d5,d6,d7,d8,d9]

D = data[:,0]
rt = data[:,1]
trapped = data[:,2]
arrival_time = data[:,3]

#%%



df = pd.DataFrame({'D':D,'rt':rt,'trapped':trapped,'arrival_time':arrival_time})
#%%
# df.head()
# df

#%%

d = df[(df.trapped==1)]
d

m = d.groupby(['D','rt'],as_index=False)['arrival_time'].mean()
n = d.groupby(['D','rt'],as_index=False)['arrival_time'].count()
o = d.groupby(['D','rt'],as_index=False)['arrival_time'].min()

print(m.to_string())
print(n.to_string())
print(o.to_string())
import scipy.io

#%%
M = m.to_numpy()
N = n.to_numpy()
O = o.to_numpy()

filename = 'mean_arrival_data.mat'
scipy.io.savemat(filename,dict(M=M))
filename = 'count_arrival_data.mat'
scipy.io.savemat(filename,dict(N=N))
filename = 'min_arrival_data.mat'
scipy.io.savemat(filename,dict(O=O))


fig = plt.figure(figsize=(3,3*0.8125))
ax = plt.subplot(111)
ax.tick_params(axis="both", direction="in", which="both", right=True, top=True, labelsize=10, width=1)
c = ax.tricontourf(M[:,1],np.log10(M[:,0]),np.log10(M[:,2]),levels=np.linspace(-4,2,13),cmap=cm.viridis)
cb = plt.colorbar(c)
cb.outline.set_linewidth(1)
cb.ax.tick_params(width=1)
ax.spines["left"].set_linewidth(1)
ax.spines["top"].set_linewidth(1)
ax.spines["right"].set_linewidth(1)
ax.spines["bottom"].set_linewidth(1)
# ax.set_aspect('auto')
ax.set_xlabel('Trap Radius')
# ax.set_xticks([0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9])
# ax.set_xticklabels([0.1,'','','',0.5,'','','',0.9])
# ax.set_yticklabels([r'$10^{-3}$','',r'$10^{-2}$','',r'$10^{-1}$','',r'$10^{0}$','',r'$10^{1}$'])
ax.set_ylabel('Diffusivity')
ax.set_title('Mean (Stoch.)')
plt.tight_layout()
plt.savefig('arrival_times.tiff',dpi=1200)
plt.savefig('arrival_times.jpg',dpi=1200)
plt.show()

fig = plt.figure(figsize=(3,3*0.8125))
ax = plt.subplot(111)
ax.tick_params(axis="both", direction="in", which="both", right=True, top=True, labelsize=10, width=1)
# c = ax.tricontourf(t100[:,1],np.log10(t100[:,0]),t100[:,2], norm=colors.LogNorm(vmin=t100[:,2].min(), vmax=t100[:,2].max()),cmap=cm.viridis)
c = ax.tricontourf(N[:,1],np.log10(N[:,0]),N[:,2]/5000,levels=np.linspace(0,1,11),cmap=cm.viridis)
cb = plt.colorbar(c)
cb.outline.set_linewidth(1)
cb.ax.tick_params(width=1)
ax.spines["left"].set_linewidth(1)
ax.spines["top"].set_linewidth(1)
ax.spines["right"].set_linewidth(1)
ax.spines["bottom"].set_linewidth(1)
# ax.set_aspect('auto')
ax.set_xlabel('Trap Radius')
# ax.set_xticks([0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9])
# ax.set_xticklabels([0.1,'','','',0.5,'','','',0.9])
# ax.set_yticklabels([r'$10^{-3}$','',r'$10^{-2}$','',r'$10^{-1}$','',r'$10^{0}$','',r'$10^{1}$'])
ax.set_title('Mating Prob.')
ax.set_ylabel('Diffusivity')
plt.tight_layout()
plt.savefig('probability_arrival_times.tiff',dpi=1200)
plt.savefig('probability_arrival_times.jpg',dpi=1200)
plt.show()


fig = plt.figure(figsize=(3,3*0.8125))
ax = plt.subplot(111)
ax.tick_params(axis="both", direction="in", which="both", right=True, top=True, labelsize=10, width=1)
c = ax.tricontourf(O[:,1],np.log10(O[:,0]),np.log10(O[:,2]),levels=np.linspace(-4,2,13),cmap=cm.viridis)
# c.set_clim(-4,2)
cb = plt.colorbar(c)
cb.outline.set_linewidth(1)
cb.ax.tick_params(width=1)
ax.spines["left"].set_linewidth(1)
ax.spines["top"].set_linewidth(1)
ax.spines["right"].set_linewidth(1)
ax.spines["bottom"].set_linewidth(1)
# ax.set_aspect('auto')
ax.set_xlabel('Trap Radius')
ax.set_title('Min (Stoch.)')
# ax.set_xticks([0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9])
# ax.set_xticklabels([0.1,'','','',0.5,'','','',0.9])
# ax.set_yticklabels([r'$10^{-3}$','',r'$10^{-2}$','',r'$10^{-1}$','',r'$10^{0}$','',r'$10^{1}$'])
ax.set_ylabel('Diffusivity')
plt.tight_layout()
plt.savefig('min_arrival_times.tiff',dpi=1200)
plt.savefig('min_arrival_times.jpg',dpi=1200)
plt.show()
