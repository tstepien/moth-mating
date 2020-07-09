%Fig3
% % to make data
% D = logspace(-4,-1,4);
% rt = linspace(1e-4,0.99,20);
% T = 100;
% R0 = 1;
%
% P = zeros(length(rt),length(D));
% for i = 1:length(rt)
%   parfor j = 1:length(D)
%     P(i,j) = getAbsProb(T,R0,rt(i),D(j));
%   end
% end
% save('Fig3_Theory_Data.mat','D','rt','T','P')

load('Fig3_Theory_Data.mat')
sim1 = readtable('ACCRE/C(100)_10-1.csv')
sim2 = readtable('ACCRE/C(100)_10-2.csv')
sim3 = readtable('ACCRE/C(100)_10-3.csv')
sim4 = readtable('ACCRE/C(100)_10-4.csv')

close all
width=6.5;
height=2;
x0 = 5;
y0 = 5;
fontsize = 10;

f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
subplot(121)
hold on
for i=1:length(D)
  p = plot(rt,P(:,5-i),'-','linewidth',1)
  stochplot = plot(sim1.Var2,sim1.Var3,'kx','linewidth',1)
  stochplot = plot(sim2.Var2,sim2.Var3,'kx','linewidth',1)
  stochplot = plot(sim3.Var2,sim3.Var3,'kx','linewidth',1)
  stochplot = plot(sim4.Var2,sim4.Var3,'kx','linewidth',1)
end
set(gca,'box','on')
set(gca,'XColor','k')
set(gca,'YColor','k')
xlabel('$R$','Interpreter','latex','fontsize',fontsize)
ylabel('$C(t)$','Interpreter','latex','fontsize',fontsize)
set(gca,'fontsize',fontsize)
% text('x Particle Sims')
% legend()

load('Fig3_Theory_Landscape_Data.mat')
subplot(122)
[X,Y] = ndgrid(rt,log10(D));
contourf(X,Y,P)
set(gca,'box','on')
set(gca,'XColor','k')
set(gca,'YColor','k')
xlabel('$R$','Interpreter','latex','fontsize',fontsize)
ylabel('$D$','Interpreter','latex','fontsize',fontsize)
xlim([0 1])
yticks([-4,-3,-2,-1])
yticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}'});
colorbar()
caxis([0 1])
set(gca,'fontsize',fontsize)

print(1,'Fig3.eps','-depsc')
