LandscapeInterpolant;
t_inc = repmat(linspace(1,100,7),4,1);
t_dec = repmat(linspace(100,1,7),4,1);
t_con = repmat(50.5*ones(1,7),4,1);
t_hat = repmat([17.5,34,50.5,67,50.5,34,17.5],4,1);

Q = [ [2 3 4 5 6 7 8]; % Increase
      [8 7 6 5 4 3 2]; % Decrease
      [5 5 5 5 5 5 5]; % Constant
      [2 3 4 5 4 3 2]  % Hat
     ];

scale = 100;
effort_inc = sum(t_inc.*Q,2);
effort_dec = sum(t_dec.*Q,2);
effort_con = sum(t_con.*Q,2);
effort_hat = sum(t_hat.*Q,2);
Q_inc = Q./effort_inc*scale;
Q_dec = Q./effort_dec*scale;
Q_con = Q./effort_con*scale;
Q_hat = Q./effort_hat*scale;

Q = Q_inc;
t = t_inc;

width=6;
height=2;
x0 = 5;
y0 = 5;
fontsize = 10;
f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');

subplot(1,3,1)
plot(t(1,:),'ks-','linewidth',1)
xlabel('Day','FontUnits','points','FontWeight','normal','FontSize',fontsize);
ylabel('Calling Time','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
set(gcf,'color','w');
xlim([1 7])
xticks([1 2 3 4 5 6 7])
% ylim([0 1])
title('A')

subplot(1,3,2)
plot(Q','s-','linewidth',1)
xlabel('Day','FontUnits','points','FontWeight','normal','FontSize',fontsize);
ylabel('Trap Size','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
set(gcf,'color','w');
xlim([1 7])
xticks([1 2 3 4 5 6 7])
ylim([0 1])
l = legend('Inc','Dec','Con','Hat','Location','northeast','fontsize',8,'NumColumns',1)
title('B')

% l.Position = [0.1472 0.9502 0.7552 0.0486];
% print(1,'Strategies.eps','-depsc')
% print(1,'Strategies.tif','-dtiff','-r600')

numDays = 7;
numStrat = size(Q,1);
D = logspace(-4,2,100);
P = zeros(length(D),numDays,numStrat);
for n = 1:numStrat
  for k = 1:numDays % loop over each day.
    for j = 1:length(D) % loop over each D
      P(j,k,n) = F(Q(n,k),log10(D(j)),t(n,k));
    end
  end
end

ptot = zeros(length(D),numStrat);
for n = 1:numStrat
  for j = 1:numDays
    if (j == 1)
      ptot(:,n) = P(:,j,n);
    else
      TempProd = ones(size(P(:,1,n)));
      for k = 1:j-1
        TempProd = TempProd.*(1-P(:,k,n));
      end
      ptot(:,n) = ptot(:,n) + P(:,j,n).*TempProd;
    end
  end
end

% f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
subplot(1,3,3)
plot(log10(D),ptot,'-','linewidth',1)
xlabel('Day','FontUnits','points','FontWeight','normal','FontSize',fontsize);
ylabel('Trap Size','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
set(gcf,'color','w');
xlabel('Diffusivity','FontUnits','points','FontWeight','normal','FontSize',fontsize);
xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});
ylabel('Mating Probability','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
set(gcf,'color','w');
title('C')


axes('Position',[.8 .4 .1 .3])
plot(log10(D),ptot,'-','linewidth',1)
xlim([-2 -1])
xticks([-2 -1])
ylim([0.85 1])
yticks([0.85 1])
xticklabels({'10^{-2}','10^{-1}'})
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',6)



% print(2,'MatingProbability.eps','-depsc')
% print(2,'MatingProbability.tif','-dtiff','-r600')

% prel = [ptot(:,1)./sum(ptot,2) ptot(:,2)./sum(ptot,2) ptot(:,3)./sum(ptot,2) ptot(:,4)./sum(ptot,2)];
%
% % prel = [ptot(:,1)./min(ptot,2) ptot(:,2)./min(ptot,2) ptot(:,3)./min(ptot,2) ptot(:,4)./min(ptot,2)]
% %
% ranking = zeros(length(D),numStrat);
% % r = 1:numStrat;
% for i = 1:length(D)
%   [~,~,I] = unique(ptot(i,:));
%   ranking(i,:) = I;
% end
%
%
% % f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
% subplot(2,2,3)
% plot(log10(D),ranking,'s','linewidth',1)
% xlabel('Day','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% ylabel('Trap Size','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
% set(gcf,'color','w');
% yticks([1,2,3,4])
% yticklabels({'4th','3rd','2nd','1st'})
% % set(gca,'Ydir','reverse')
% xlabel('Diffusivity','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});
% ylabel('Ranking','FontUnits','points','FontWeight','normal','FontSize',fontsize);
% set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
% set(gcf,'color','w');
% % legend('Increase','Decrease','Constant','Hat')
% % print(3,'RankedStrategy.eps','-depsc')
% % print(3,'RankedStrategy.tif','-dtiff','-r600')
%
% co = [ 0    0.4470    0.7410;
%     0.8500    0.3250    0.0980;
%     0.9290    0.6940    0.1250;
%     0.4940    0.1840    0.5560;
%     0.4660    0.6740    0.1880;
%     0.3010    0.7450    0.9330;
%     0.6350    0.0780    0.1840]
%
% subplot(2,2,4)
% % ranking = [r_inc];%r_dec;r_con;r_hat];
% score = mean(ranking)/4;
% b = bar(score);
% % text(1:length(score),score,num2str(score'),'vert','bottom','horiz','center','fontsize',8);
% b.FaceColor = 'flat';
% b.CData(1,:) = co(1,:);
% b.CData(2,:) = co(2,:);
% b.CData(3,:) = co(3,:);
% b.CData(4,:) = co(4,:);
% ylabel('Average Rank')
% xticklabels({'Increase','Decrease','Constant','Hat'})
% xtickangle(45)
%
%
% print(1,'StrategiesTIncrease.eps','-depsc')
% print(1,'StrategiesTIncrease.tif','-dtiff','-r600')

% f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
% imagesc(log10(D),[1,2,3,4],ranking')
% yticks([1,2,3,4])
% yticklabels({'Increase','Decrease','Constant','Hat'})
% xticks([-4,-3,-2,-1,0,1,2])
% xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});
% xlabel('Diffusivity')
% ylabel('Strategy')
% set(gcf,'color','w');
% colorbar('Ticks',[1,2,3,4],'TickLabels',{'4th','3rd','2nd','1st'})
%
% % sum(ranking)./(4*size(ranking,1))
% f = figure('Units','inches','Position',[x0 y0 2*width 2*height],'PaperPositionMode','auto');
% set(gcf,'color','w');
% colorbar('Ticks',[1,2,3,4],'TickLabels',{'4th','3rd','2nd','1st'})
% r_inc = ranking;
% h1=subplot(2,2,1)
% imagesc(log10(D),[1,2,3,4],ranking')
% yticks([1,2,3,4])
% yticklabels({'Increase','Decrease','Constant','Hat'})
% xticks([-4,-3,-2,-1,0,1,2])
% xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});
% % xlabel('Diffusivity')
% % ylabel('Strategy')
%
% Q = Q_dec;
% t = t_dec;
% numDays = 7
% numStrat = size(Q,1)
% D = logspace(-4,2,100)
% P = zeros(length(D),numDays,numStrat);
% for n = 1:numStrat
%   for k = 1:numDays % loop over each day.
%     for j = 1:length(D) % loop over each D
%       P(j,k,n) = F(Q(n,k),log10(D(j)),t(n,k));
%     end
%   end
% end
% ptot = zeros(length(D),numStrat);
% for n = 1:numStrat
%   for j = 1:numDays
%     if (j == 1)
%       ptot(:,n) = P(:,j,n);
%     else
%       TempProd = ones(size(P(:,1,n)));
%       for k = 1:j-1
%         TempProd = TempProd.*(1-P(:,k,n));
%       end
%       ptot(:,n) = ptot(:,n) + P(:,j,n).*TempProd;
%     end
%   end
% end
% ranking = zeros(length(D),numStrat);
% % r = 1:numStrat;
% for i = 1:length(D)
%   [~,~,I] = unique(ptot(i,:));
%   ranking(i,:) = I;
% end
% r_dec = ranking;
%
% h2=subplot(2,2,2)
% imagesc(log10(D),[1,2,3,4],ranking')
% yticks([1,2,3,4])
% yticklabels({'Increase','Decrease','Constant','Hat'})
% xticks([-4,-3,-2,-1,0,1,2])
% xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});
% % xlabel('Diffusivity')
% % ylabel('Strategy')
%
% Q = Q_con;
% t = t_con;
% numDays = 7
% numStrat = size(Q,1)
% D = logspace(-4,2,100)
% P = zeros(length(D),numDays,numStrat);
% for n = 1:numStrat
%   for k = 1:numDays % loop over each day.
%     for j = 1:length(D) % loop over each D
%       P(j,k,n) = F(Q(n,k),log10(D(j)),t(n,k));
%     end
%   end
% end
% ptot = zeros(length(D),numStrat);
% for n = 1:numStrat
%   for j = 1:numDays
%     if (j == 1)
%       ptot(:,n) = P(:,j,n);
%     else
%       TempProd = ones(size(P(:,1,n)));
%       for k = 1:j-1
%         TempProd = TempProd.*(1-P(:,k,n));
%       end
%       ptot(:,n) = ptot(:,n) + P(:,j,n).*TempProd;
%     end
%   end
% end
% ranking = zeros(length(D),numStrat);
% % r = 1:numStrat;
% for i = 1:length(D)
%   [~,~,I] = unique(ptot(i,:));
%   ranking(i,:) = I;
% end
% r_con = ranking;
%
% h3=subplot(2,2,3)
% imagesc(log10(D),[1,2,3,4],ranking')
% yticks([1,2,3,4])
% yticklabels({'Increase','Decrease','Constant','Hat'})
% xticks([-4,-3,-2,-1,0,1,2])
% xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});
% % xlabel('Diffusivity')
% % ylabel('Strategy')
%
% Q = Q_hat;
% t = t_hat;
% numDays = 7
% numStrat = size(Q,1)
% D = logspace(-4,2,100)
% P = zeros(length(D),numDays,numStrat);
% for n = 1:numStrat
%   for k = 1:numDays % loop over each day.
%     for j = 1:length(D) % loop over each D
%       P(j,k,n) = F(Q(n,k),log10(D(j)),t(n,k));
%     end
%   end
% end
% ptot = zeros(length(D),numStrat);
% for n = 1:numStrat
%   for j = 1:numDays
%     if (j == 1)
%       ptot(:,n) = P(:,j,n);
%     else
%       TempProd = ones(size(P(:,1,n)));
%       for k = 1:j-1
%         TempProd = TempProd.*(1-P(:,k,n));
%       end
%       ptot(:,n) = ptot(:,n) + P(:,j,n).*TempProd;
%     end
%   end
% end
% ranking = zeros(length(D),numStrat);
% % r = 1:numStrat;
% for i = 1:length(D)
%   [~,~,I] = unique(ptot(i,:));
%   ranking(i,:) = I;
% end
%
% r_hat = ranking;
%
% h4=subplot(2,2,4)
% imagesc(log10(D),[1,2,3,4],ranking')
% yticks([1,2,3,4])
% yticklabels({'Increase','Decrease','Constant','Hat'})
% xticks([-4,-3,-2,-1,0,1,2])
% xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});
% % xlabel('Diffusivity')
% % ylabel('Strategy')
%
%
%
% p1=get(h1,'position');
% p2=get(h2,'position');
% p3=get(h3,'position');
% p4=get(h4,'position');
% height=p1(2)+p1(4)-p4(2);
% width=p4(1)+p4(3)-p3(1);
% h5=axes('position',[p3(1) p3(2) width height],'visible','off');
% h5.XLabel.Visible='on'
% h5.YLabel.Visible='on'
% axes(h5)
% xlabel('Diffusivity')
% ylabel('Strategy')
