load('Increase_Time.mat')
close all

width=4;
height=2;
x0 = 5;
y0 = 5;
fontsize = 10;
f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
hold on

%cumulative mating probability over all D and R
CMP = zeros(1,7)
CMP_best = zeros(1,7)
TotTime = zeros(1,7)
X = C
CMP(1) = sum(sum(X(:,:,1)))
CMP_best(1) = sum(sum(X(16:20,9:10,1)))
TotTime(1) = T(1)
for k = 2:7
  % prob for night k over all D,R:  P(:,:,k) %
  CMP(k) = CMP(k-1) + sum(sum(X(:,:,k)))
  CMP_best(k) = CMP_best(k-1) + sum(sum(X(16:20,9:10,k)))
  TotTime(k) = TotTime(k-1) + T(k)
end
TotTime = TotTime/3600
plot(TotTime,CMP./TotTime,'o-','LineWidth',1)
% plot(TotTime,CMP_best./TotTime,'o--','LineWidth',1)
% plot(TotTime,CMP,'k','LineWidth',1)
% plot(TotTime,CMP_best,'k--','LineWidth',1)

load('Decrease_Time.mat')
close 2
%cumulative mating probability over all D and R
CMP = zeros(1,7)
CMP_best = zeros(1,7)
TotTime = zeros(1,7)
X = C
CMP(1) = sum(sum(X(:,:,1)))
CMP_best(1) = sum(sum(X(16:20,9:10,1)))
TotTime(1) = T(1)
for k = 2:7
  % prob for night k over all D,R:  P(:,:,k) %
  CMP(k) = CMP(k-1) + sum(sum(X(:,:,k)))
  CMP_best(k) = CMP_best(k-1) + sum(sum(X(16:20,9:10,k)))
  TotTime(k) = TotTime(k-1) + T(k)
end
TotTime = TotTime/3600
plot(TotTime,CMP./TotTime,'o-','LineWidth',1)
% plot(TotTime,CMP_best./TotTime,'o--','LineWidth',1)
% plot(TotTime,CMP,'b','LineWidth',1)
% plot(TotTime,CMP_best,'b--','LineWidth',1)


load('Constant_Time.mat')
close 2
%cumulative mating probability over all D and R
CMP = zeros(1,7)
CMP_best = zeros(1,7)
TotTime = zeros(1,7)
X = C
CMP(1) = sum(sum(X(:,:,1)))
CMP_best(1) = sum(sum(X(16:20,9:10,1)))
TotTime(1) = T(1)
for k = 2:7
  % prob for night k over all D,R:  P(:,:,k) %
  CMP(k) = CMP(k-1) + sum(sum(X(:,:,k)))
  CMP_best(k) = CMP_best(k-1) + sum(sum(X(16:20,9:10,k)))
  TotTime(k) = TotTime(k-1) + T(k)
end
TotTime = TotTime/3600
plot(TotTime,CMP./TotTime,'o-','LineWidth',1)
% plot(TotTime,CMP_best./TotTime,'o--','LineWidth',1)
% plot(TotTime,CMP,'r','LineWidth',1)
% plot(TotTime,CMP_best,'r--','LineWidth',1)


load('Hat_Time.mat')
close 2
%cumulative mating probability over all D and R
CMP = zeros(1,7)
CMP_best = zeros(1,7)
TotTime = zeros(1,7)
X = C
CMP(1) = sum(sum(X(:,:,1)))
CMP_best(1) = sum(sum(X(16:20,9:10,1)))
TotTime(1) = T(1)
for k = 2:7
  % prob for night k over all D,R:  P(:,:,k) %
  CMP(k) = CMP(k-1) + sum(sum(X(:,:,k)))
  CMP_best(k) = CMP_best(k-1) + sum(sum(X(16:20,9:10,k)))
  TotTime(k) = TotTime(k-1) + T(k)
end
TotTime = TotTime/3600
plot(TotTime,CMP./TotTime,'o-','LineWidth',1)
% plot(TotTime,CMP_best./TotTime,'o--','LineWidth',1)
% plot(TotTime,CMP,'m','LineWidth',1)
% plot(TotTime,CMP_best,'m--','LineWidth',1)

legend({'Increase','Decrease','Constant','Hat'},'fontsize',fontsize)
xlabel('Total Time Spent Calling (hours)','fontsize',fontsize)
ylabel('$E_k$','Interpreter','latex','fontsize',fontsize)
set(gca,'YColor','k')
set(gca,'XColor','k')
set(gca,'Box','on')
print(1,'EffortPlot.png','-dpng','-r600')
print(1,'EffortPlot.eps','-depsc')

% set(gca,'yscale','log')
% set(gca,'xscale','log')

% for k = 1:length(T)
%   subplot(2,4,k)
%   contourf(X,Y,P(:,:,k))
%   title(titles{k},'FontWeight','normal','fontsize',fontsize,'Interpreter','latex')
%   xlim([0 1])
%   xticks([0,0.5,1])
%   xlabel('$R$','fontsize',fontsize,'Interpreter','latex')
%   ylabel('$D$','fontsize',fontsize,'Interpreter','latex')
%   yticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}'})
%   colorbar
%   % axis square
%   % caxis([0 1])
%   % print(k,sprintf('P(day = %d)_increase.png',k),'-dpng','-r600')
% end

% close all
% TotalProb = sum(P,3)
% subplot(2,4,8)
% contourf(X,Y,TotalProb)
% title(titles{8},'FontWeight','normal','fontsize',fontsize,'Interpreter','Latex')
% xlim([0 1])
% xticks([0,0.5,1])
% xlabel('$R$','fontsize',fontsize,'Interpreter','latex')
% ylabel('$D$','fontsize',fontsize,'Interpreter','latex')
% yticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}'})
% colorbar

% print(1,'Fig6.png','-dpng','-r600')
% print(1,'Fig6.eps','-depsc')
