r = [0.25,0.75];
D = [10^(-3.5),10^(-1.5)];

T_inc = linspace(0.5,8,7)*60*60; %in seconds
T_dec = linspace(8,0.5,7)*60*60; %in seconds
T_con = 4.25*ones(1,7)*60*60; %in seconds
T = [2 3 4 5 4 3 2];
tot = sum(T);
T_hat = 29.75*T/tot*60*60;

T = [T_inc;T_dec;T_con;T_hat]
% figure
% hold on
% plot(T_inc)
% plot(T_dec)
% plot(T_con)
% plot(T_hat)

%TO MAKE DATA:
% C = zeros(2,2,7,4);
%
% R0 = 1
% for i = 1:length(r)
%   for j = 1:length(D)
%     for k = 1:length(T)
%       for n = 1:4
%         C(i,j,k,n) = getAbsProb(T(n,k),R0,r(i),D(j));
%       end
%     end
%   end
% end
load('Fig5_data.mat')

% figure
% subplot(221)
% i = 1
% j = 2
% hold on
% for n = 1:4
%   plot(1:7,squeeze(C(i,j,:,n)))
% end
% xlim([1,7])
% ylim([0,1])
%
% subplot(222)
% i = 2
% j = 2
% hold on
% for n = 1:4
%   plot(1:7,squeeze(C(i,j,:,n)))
% end
% xlim([1,7])
% ylim([0,1])
%
% subplot(223)
% i = 1
% j = 1
% hold on
% for n = 1:4
%   plot(1:7,squeeze(C(i,j,:,n)))
% end
% xlim([1,7])
% ylim([0,1])
%
% subplot(224)
% i = 2
% j = 1
% hold on
% for n = 1:4
%   plot(1:7,squeeze(C(i,j,:,n)))
%   legend('increase','decrease','constant','hat','Location','southeast')
% end
% xlim([1,7])
% ylim([0,1])

%-----------------------------%

width=6;
height=2;
x0 = 5;
y0 = 5;
fontsize = 10;
f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
% co = [0,0,0;0,0,0.25;0,0,0.5;0,0,0.75]
co = [[0.4940 0.1840 0.5560];[0.9290 0.6940 0.1250];[0.8500 0.3250 0.0980];[0 0.4470 0.7410]];
subplot(141)
n=1
hold on
set(gca,'colororder',co)
for i = 1:length(r)
  for j = 1:length(D)
    plot(1:7,squeeze(C(i,j,:,n)),'-','linewidth',2)
  end
end
xlim([1,7])
ylim([0.2,1])
xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
ylabel('$C(t)$','Interpreter','latex','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
set(gcf,'color','w');
xticks([1 2 3 4 5 6 7])
title('Increase','fontsize',fontsize)


subplot(142)
n=2
hold on
set(gca,'colororder',co)

for i = 1:length(r)
  for j = 1:length(D)
    plot(1:7,squeeze(C(i,j,:,n)),'-','linewidth',2)
  end
end
xlim([1,7])
ylim([0.2,1])
xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
set(gcf,'color','w');
xticks([1 2 3 4 5 6 7])
title('Decrease','fontsize',fontsize)

subplot(143)
n=3
hold on
set(gca,'colororder',co)

for i = 1:length(r)
  for j = 1:length(D)
    plot(1:7,squeeze(C(i,j,:,n)),'-','linewidth',2)
  end
end
xlim([1,7])
ylim([0.2,1])
xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
set(gcf,'color','w');
xticks([1 2 3 4 5 6 7])
title('Constant','fontsize',fontsize)

subplot(144)
n=4
hold on
set(gca,'colororder',co)

for i = 1:length(r)
  for j = 1:length(D)
    plot(1:7,squeeze(C(i,j,:,n)),'-','linewidth',2)
  end
end
xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
set(gcf,'color','w');
xticks([1 2 3 4 5 6 7])
title('Hat','fontsize',fontsize)
% r = [0.25,0.75];
% D = [10^(-3.5),10^(-1.5)];
% legend('small r, small D','small r, large D','large r, small D','large r, large D','Location','southeast')

xlim([1,7])
ylim([0.2,1])

print(1,'Fig5.eps','-depsc')

% %--------------------%
% P = zeros(size(C));
% TempProd = ones(size(C(:,:,1,:)));
% for ell = 1:7
%   if ell == 1
%     P(:,:,ell,:) = C(:,:,ell,:);
%   else
%     for k = 1:ell-1
%       TempProd = TempProd.*(1-P(:,:,k,:));
%     end
%     P(:,:,ell,:) = C(:,:,ell,:).*TempProd;
%   end
% end
%
% figure
% subplot(221)
% i = 1
% j = 2
% hold on
% for n = 1:4
%   plot(1:7,squeeze(P(i,j,:,n)))
% end
% xlim([1,7])
% ylim([0,1])
%
% subplot(222)
% i = 2
% j = 2
% hold on
% for n = 1:4
%   plot(1:7,squeeze(P(i,j,:,n)))
% end
% xlim([1,7])
% ylim([0,1])
%
% subplot(223)
% i = 1
% j = 1
% hold on
% for n = 1:4
%   plot(1:7,squeeze(P(i,j,:,n)))
% end
% xlim([1,7])
% ylim([0,1])
%
% subplot(224)
% i = 2
% j = 1
% hold on
% for n = 1:4
%   plot(1:7,squeeze(P(i,j,:,n)))
%   legend('increase','decrease','Ponstant','hat','Location','southeast')
% end
% xlim([1,7])
% ylim([0,1])
%
% %-----------------------------%
% width=6;
% height=2;
% x0 = 5;
% y0 = 5;
% fontsize = 10;
% f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
% co = [0,0,0;0.25,0.25,0.25;0.5,0.5,0.5;0.75,0.75,0.75]
%
% subplot(141)
% n=1
% hold on
% set(gca,'colororder',co)
% for i = 1:length(r)
%   for j = 1:length(D)
%     plot(1:7,squeeze(P(i,j,:,n)),'-','linewidth',2)
%   end
% end
% xlim([1,7])
% ylim([0,1])
% xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% ylabel('M_l','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
% set(gcf,'color','w');
% xticks([1 2 3 4 5 6 7])
% title('A    Increase ')
%
%
% subplot(142)
% n=2
% hold on
% set(gca,'colororder',co)
%
% for i = 1:length(r)
%   for j = 1:length(D)
%     plot(1:7,squeeze(P(i,j,:,n)),'-','linewidth',2)
%   end
% end
% xlim([1,7])
% ylim([0,1])
% xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% % ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
% set(gcf,'color','w');
% xticks([1 2 3 4 5 6 7])
% title('B    Decrease ')
%
% subplot(143)
% n=3
% hold on
% set(gca,'colororder',co)
%
% for i = 1:length(r)
%   for j = 1:length(D)
%     plot(1:7,squeeze(P(i,j,:,n)),'-','linewidth',2)
%   end
% end
% xlim([1,7])
% ylim([0,1])
% xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% % ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
% set(gcf,'color','w');
% xticks([1 2 3 4 5 6 7])
% title('C    Constant ')
%
% subplot(144)
% n=4
% hold on
% set(gca,'colororder',co)
%
% for i = 1:length(r)
%   for j = 1:length(D)
%     plot(1:7,squeeze(P(i,j,:,n)),'-','linewidth',2)
%   end
% end
% xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% % ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
% set(gcf,'color','w');
% xticks([1 2 3 4 5 6 7])
% title('D      Hat        ')
% % r = [0.25,0.75];
% % D = [10^(-3.5),10^(-1.5)];
% % legend('small r, small D','small r, large D','large r, small D','large r, large D','Location','southeast')
% xlim([1,7])
% ylim([0,1])







%
%
%
% width=6;
% height=2;
% x0 = 5;
% y0 = 5;
% fontsize = 10;
% f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
% co = [0,0,0;0.25,0.25,0.25;0.5,0.5,0.5;0.75,0.75,0.75]
%
% subplot(141)
% n=1
% hold on
% set(gca,'colororder',co)
% for i = 1:length(r)
%   for j = 1:length(D)
%     plot(1:7,squeeze(P(i,j,:,n)),'-','linewidth',2)
%   end
% end
% xlim([1,7])
% ylim([0,1])
% xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
% set(gcf,'color','w');
% xticks([1 2 3 4 5 6 7])
% title('A    Increase ')
% set(gca,'YScale','log')
%
% axes('Position',[.05 .05 .5 .5])
% box on
% set(gca,'colororder',co)
% for i = 1:length(r)
%   for j = 1:length(D)
%     plot(1:7,squeeze(P(i,j,:,n)),'-','linewidth',2)
%   end
% end
% xlim([1,3])
% % ylim([0,1])
% set(gca,'YScale','log')
%
% subplot(142)
% n=2
% hold on
% set(gca,'colororder',co)
%
% for i = 1:length(r)
%   for j = 1:length(D)
%     plot(1:7,squeeze(P(i,j,:,n)),'-','linewidth',2)
%   end
% end
% xlim([1,7])
% ylim([0,1])
% xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% % ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
% set(gcf,'color','w');
% xticks([1 2 3 4 5 6 7])
% title('B    Decrease ')
% set(gca,'YScale','log')
%
% subplot(143)
% n=3
% hold on
% set(gca,'colororder',co)
%
% for i = 1:length(r)
%   for j = 1:length(D)
%     plot(1:7,squeeze(P(i,j,:,n)),'-','linewidth',2)
%   end
% end
% xlim([1,7])
% ylim([0,1])
% xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% % ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
% set(gcf,'color','w');
% xticks([1 2 3 4 5 6 7])
% title('C    Constant ')
% set(gca,'YScale','log')
%
% subplot(144)
% n=4
% hold on
% set(gca,'colororder',co)
%
% for i = 1:length(r)
%   for j = 1:length(D)
%     plot(1:7,squeeze(P(i,j,:,n)),'-','linewidth',2)
%   end
% end
% xlabel('Night','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% % ylabel('Mating Probability C(t)','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'Box','on','XColor','k','YColor','k')
% set(gcf,'color','w');
% xticks([1 2 3 4 5 6 7])
% title('D      Hat        ')
% % r = [0.25,0.75];
% % D = [10^(-3.5),10^(-1.5)];
% % legend('small r, small D','small r, large D','large r, small D','large r, large D','Location','southeast')
% xlim([1,7])
% ylim([0,1])
% set(gca,'YScale','log')
