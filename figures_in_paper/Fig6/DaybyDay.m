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

width=6.5;
height=1.75;
x0 = 5;
y0 = 5;
fontsize = 10;
% f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');


numDays = 7;
numStrat = size(Q,1);
D = logspace(-4,2,50);
P = zeros(length(D),numDays,numStrat);
for n = 1:numStrat
    for k = 1:numDays % loop over each day.
        for j = 1:length(D) % loop over each D
            P(j,k,n) = F(Q(n,k),log10(D(j)),t(n,k));
        end
    end
end
titlelist = {'A Increase','B Decrease','C Constant','D Hat'};
% numStrat = 1
figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
set(gcf,'color','w');

ptot = zeros(length(D),numStrat);
for n = 1:numStrat
    subplot(1,4,n)
    if n == 1 %| n == 3
        ylabel('Mating Probability','FontUnits','points','FontWeight','normal','FontSize',fontsize);
    end
    if n == 3 %| n == 4
        xlabel('Diffusivity','FontUnits','points','FontWeight','normal','FontSize',fontsize);
    end

    set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
    title(titlelist{n})

    for j = 1:numDays
        if (j == 1)
            ptot(:,n) = P(:,j,n);

            % figure(n);
            hold on;
            plot(log10(D),P(:,j,n),'-','linewidth',2)
            hold off;

        else
            TempProd = ones(size(P(:,1,n)));
            for k = 1:j-1
                TempProd = TempProd.*(1-P(:,k,n));
            end
            ptot(:,n) = ptot(:,n) + P(:,j,n).*TempProd;

            % figure(n);
            hold on;
            plot(log10(D),P(:,j,n).*TempProd,'-','linewidth',2)
            hold off;
        end
    end
    if n == 4
        legend({'P_1','P_2','P_3','P_4','P_5','P_6','P_7'},'location','northwestoutside','NumColumns',1,'FontSize',8)
    end
    xticks([-4 -3 -2 -1 0 1 2])
    xticklabels({'10^{-4}','','10^{-2}','','10^{0}','','10^{2}'})
    ylim([0 1])
    set(gca,'Box','on')
    grid()
    % return
end
print(1,'daybyday.eps','-depsc','-painters')
% legend({'$\mathcal{P}_1$','$\mathcal{P}_2$','$\mathcal{p}_3$','$\mathcal{p}_4$','$\mathcal{P}_5$','$\mathcal{P}_6$','$\mathcal{P}_7$'},'Interpreter','latex')
