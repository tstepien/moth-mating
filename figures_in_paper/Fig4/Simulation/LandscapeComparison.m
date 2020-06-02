T1 = readtable('T1.csv');
T20 = readtable('T20.csv');
T40 = readtable('T40.csv');
T60 = readtable('T60.csv');
T80 = readtable('T80.csv');
T100 = readtable('T100.csv');
T10 = readtable('T10.csv');
T30 = readtable('T30.csv');
T50 = readtable('T50.csv');
T70 = readtable('T70.csv');
T90 = readtable('T90.csv');
num = size(T1,1);
T1.Var4 = ones(num,1);
T20.Var4 = 20*ones(num,1);
T40.Var4 = 40*ones(num,1);
T60.Var4 = 60*ones(num,1);
T80.Var4 = 80*ones(num,1);
T100.Var4 = 100*ones(num,1);
T10.Var4 = 10*ones(num,1);
T30.Var4 = 30*ones(num,1);
T50.Var4 = 50*ones(num,1);
T70.Var4 = 70*ones(num,1);
T90.Var4 = 90*ones(num,1);

% vert cat tables
Tab = [T1;T10;T20;T30;T40;T50;T60;T70;T80;T90;T100];
% build data structure
S.d = Tab.Var1;
S.rt = Tab.Var2;
S.p = Tab.Var3;
S.t = Tab.Var4;

load('CircleTrapTheoryData.mat')
close all
[X,Y,Z] = ndgrid(rt,log10(D),T);

width=4*0.8125;
height=3*0.8125;
x0 = 5;
y0 = 5;
fontsize = 10;

f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
box on;
scatter3(S.rt,log10(S.d),S.t,36,abs(P(:)-S.p),'filled')
xlabel('Trap Radius','FontUnits','points','FontWeight','normal','FontSize',fontsize);
ylabel('Diffusivity','FontUnits','points','FontWeight','normal','FontSize',fontsize);
zlabel('Total Time','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
set(gcf,'color','w');
colorbar()
caxis([0 max(max(abs(P(:)-S.p)))])
yticklabels({'10^{-4}','10^{-2}','10^{0}','10^{2}'});
print(1,'CompareData.eps','-depsc')
print(1,'CompareData.tif','-dtiff','-r1200')


%reshape data

Pstoch = reshape(S.p,length(rt),length(D),length(T))

f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
box on;
hold on
p = {};
for i=1:3:length(D(1:end-9))
  p{i} = plot(rt,P(:,11-i,end),'s-','linewidth',1.5)
  stoch = plot(rt,Pstoch(:,11-i,end),'kx','linewidth',1.5)
end
xlabel('Dimensionless Trap Radius R_0/X_0','FontUnits','points','FontWeight','normal','FontSize',fontsize);
ylabel('Mating Probability','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
set(gcf,'color','w');
legend([p{1:3:end},stoch],{'D = 10^{-1}','D = 10^{-2}','D = 10^{-3}','D = 10^{-4}','Simulation'},'location','northwest')%
print(2,'Comparison.eps','-depsc')
print(2,'Comparison.tif','-dtiff','-r1200')
