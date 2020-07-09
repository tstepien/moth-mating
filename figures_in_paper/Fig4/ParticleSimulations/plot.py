import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
import matplotlib.tri as tri
from scipy.special import lambertw
from scipy.special import psi

import pandas as pd
import seaborn as sns

plt.rc("text", usetex=False)
plt.rc('font',**{'family':'sans-serif','sans-serif':['Arial'],'size':8 })
#
data0 = np.load('data0.npy')
data1 = np.load('data1.npy')
data2 = np.load('data2.npy')
data3 = np.load('data3.npy')
data4 = np.load('data4.npy')
data5 = np.load('data5.npy')
data6 = np.load('data6.npy')
data7 = np.load('data7.npy')
data8 = np.load('data8.npy')
data9 = np.load('data9.npy')
data10 = np.load('data10.npy')
data11 = np.load('data11.npy')
data12 = np.load('data12.npy')
data13 = np.load('data13.npy')
data14 = np.load('data14.npy')

data = np.r_[data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14]
# data = np.r_[data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14]


D = data[:,0]
rt = data[:,1]
arrival_time = data[:,2]



df = pd.DataFrame({'D':D,'rt':rt,'arrival_time':arrival_time})
df
m = df.groupby(['D','rt'],as_index=False)['arrival_time'].mean()
n = df.groupby(['D','rt'],as_index=False)['arrival_time'].count()
o = df.groupby(['D','rt'],as_index=False)['arrival_time'].min()
M = m.to_numpy()
N = n.to_numpy()
O = o.to_numpy()

import scipy.io
filename = 'ArrivalData.mat'
scipy.io.savemat(filename,dict(M=M,N=N,O=O))


fig,axs = plt.subplots(1,1,figsize=(3,3),constrained_layout=True)
# axs = axs.ravel()
ax = axs
ax.tick_params(axis="both", direction="in", which="both", right=True, top=True,  width=1)
#levels=np.linspace(-4,2,13)
# c = ax.tricontourf(M[:,1],M[:,0],np.log10(M[:,2]),cmap=cm.viridis)
c = ax.tricontourf(N[:,1],np.log10(N[:,0]),N[:,2],levels=np.linspace(0,1100,12),cmap=cm.viridis)
# c = ax.tricontourf(O[:,1],O[:,0],np.log10(O[:,2]),cmap=cm.viridis)
cb = fig.colorbar(c,ax=ax,shrink=0.5)
cb.outline.set_linewidth(1)
cb.ax.tick_params(width=1)
ax.spines["left"].set_linewidth(1)
ax.spines["top"].set_linewidth(1)
ax.spines["right"].set_linewidth(1)
ax.spines["bottom"].set_linewidth(1)
ax.set_ylim([-4,-1])
ax.set_xlim([0,1])
ax.set_xlabel('$R$')
ax.set_ylabel('$D$')
# ax.set_yscale('log')
ax.set_title('Count')
ax.set_aspect(1.0/ax.get_data_ratio(), adjustable='box')
# plt.tight_layout()
fig.savefig('Fig4_count.png',format='png',dpi=600)



fig, axs = plt.subplots(1,3,figsize=(6,2),constrained_layout=True)
# g = sns.pointplot(x=rt,y=arrival_time,data=df,hue=D,estimator=np.mean,ci=False,ax=ax)
# l = ax.get_legend()
# l.set_visible(False)

ax = axs[2]
ax.tick_params(axis="both", direction="in", which="both", right=True, top=True,  width=1)
#levels=np.linspace(-4,2,13)
c = ax.tricontourf(M[:,1],np.log10(M[:,0]),np.log10(M[:,2]),levels=np.linspace(-5,4,19),cmap=cm.viridis,vmin=-4,vmax=4)
# c = ax.tricontourf(N[:,1],N[:,0],N[:,2],cmap=cm.viridis)
# c = ax.tricontourf(O[:,1],O[:,0],np.log10(O[:,2]),cmap=cm.viridis)
# cb = fig.colorbar(c,ax=ax,shrink=1)
# cb.outline.set_linewidth(1)
# cb.ax.tick_params(width=1)
ax.spines["left"].set_linewidth(1)
ax.spines["top"].set_linewidth(1)
ax.spines["right"].set_linewidth(1)
ax.spines["bottom"].set_linewidth(1)
ax.set_ylim([-4,-1])
ax.set_xlim([0,1])
ax.set_xlabel('$R$')
ax.set_ylabel('$D$')
# ax.set_yscale('log')
ax.set_title('$E[t]$ numerical')
ax.set_yticklabels(['$10^{-4}$','$10^{-3}$','$10^{-2}$','$10^{-1}$'])
ax.set_xticklabels(['$0$','$0.5$','$1$'])
ax.set_aspect(1.0/ax.get_data_ratio(), adjustable='box')
# ax.triplot(triang, lw=0.5, color='white')
# ax.tricontour(M[:,1],np.log10(M[:,0]),np.log10(M[:,2]))

ax = axs[1]
ax.tick_params(axis="both", direction="in", which="both", right=True, top=True,  width=1)
#levels=np.linspace(-4,2,13)
# c = ax.tricontourf(M[:,1],M[:,0],np.log10(M[:,2]),cmap=cm.viridis)
# c = ax.tricontourf(N[:,1],N[:,0],N[:,2],cmap=cm.viridis)
c = ax.tricontourf(O[:,1],np.log10(O[:,0]),np.log10(O[:,2]),levels=np.linspace(-5,4,19),cmap=cm.viridis,vmin=-4,vmax=4)
# cb = fig.colorbar(c,ax=ax,shrink=1)
# cb.outline.set_linewidth(1)
# cb.ax.tick_params(width=1)
ax.spines["left"].set_linewidth(1)
ax.spines["top"].set_linewidth(1)
ax.spines["right"].set_linewidth(1)
ax.spines["bottom"].set_linewidth(1)
ax.set_ylim([-4,-1])
ax.set_xlim([0,1])
ax.set_xlabel('$R$')
ax.set_ylabel('$D$')
# ax.set_yscale('log')
ax.set_title('$E[t_{a}]$ numerical')
ax.set_yticklabels(['$10^{-4}$','$10^{-3}$','$10^{-2}$','$10^{-1}$'])
ax.set_xticklabels(['$0$','$0.5$','$1$'])
ax.set_aspect(1.0/ax.get_data_ratio(), adjustable='box')


ax = axs[0]
ax.tick_params(axis="both", direction="in", which="both", right=True, top=True,width=1)

Num = 10**3
p = 0.5
gamma_e = -psi(1)
R0 = 2
D_range = np.logspace(-4,-1,50)
R_range = np.linspace(0.01,1.99,199)
mean = np.zeros((50,199))
for i in range(len(D_range)):
    for j in range(len(R_range)):
        D = D_range[i]
        R = R_range[j]/R0
        A = 2/((R-1)*np.sqrt(np.pi*R))
        B = (R-1)**2 / 4
        W = lambertw((B/p) * (A*Num)**(1/p),k=0)
        bn = B/(p*W)
        an = bn/(p*(1+W))
        mean[i,j] =  (R0**2 / D) * (bn - gamma_e * an);
c = ax.contourf(R_range/R0,np.log10(D_range),np.log10(mean),levels=np.linspace(-5,4,19),cmap=cm.viridis,vmin=-4,vmax=4)
# ax.contour(R_range/R0,D_range,np.log10(mean),levels=np.linspace(-5,4,19),colors='k',vmin=-5,vmax=4)
ax.spines["left"].set_linewidth(1)
ax.spines["top"].set_linewidth(1)
ax.spines["right"].set_linewidth(1)
ax.spines["bottom"].set_linewidth(1)
ax.set_ylim([-4,-1])
ax.set_xlim([0,1])
ax.set_xlabel('$R$')
ax.set_ylabel('$D$')
ax.set_yticklabels(['$10^{-4}$','$10^{-3}$','$10^{-2}$','$10^{-1}$'])
ax.set_xticklabels(['$0$','$0.5$','$1$'])
# ax.set_yscale('log')
ax.set_title('$E[t_{a}]$ theory')
ax.set_aspect(1.0/ax.get_data_ratio(), adjustable='box')

cb = fig.colorbar(c,ax=axs,shrink=0.75)
cb.outline.set_linewidth(1)
cb.ax.tick_params(width=1)
# cb.ax.set_ylim([-4,4])
cb.ax.set_yticklabels(['$10^{-5}$','$10^{-4}$','$10^{-3}$','$10^{-2}$','$10^{-1}$','$10^0$','$10^{1}$','$10^{2}$','$10^{3}$','$10^{4}$'])

# plt.axis('square')
# plt.tight_layout()
fig.savefig('Fig4.png',format='png',dpi=600)
plt.show()
