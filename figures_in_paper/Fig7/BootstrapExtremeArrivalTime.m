% function ExtremeArrivalTime

N = 10^3;
%p = -0.5;
p = 0.5;
gamma_e = -psi(1);

R0 = 2;

D_range = logspace(-3,0,50);
R_range = 0.01:0.01:1.99;

[Dr,Rr] = ndgrid(D_range,R_range);

for i = 1:length(D_range)
    for j = 1:length(R_range)

        R = Rr(i,j)/R0;
        D = Dr(i,j);
        %A = 1/sqrt(pi*R);
        A = 2/((R-1)*sqrt(pi*R));
        B = (R-1)^2 / 4;

        W = lambertw(0,(B/p) * (A*N)^(1/p));
        bn = B/(p*W);
        an = bn/( p*(1+W));

        mean(i,j) =  (R0^2 / D) * (bn - gamma_e *an);

        A2 = sqrt( (4*D)/( pi*R * R0^2 * (R-1)^2 ) );
        B2 = (R0^2 * (R-1)^2) / (4*D);
        W2 = lambertw(0,(B2/p) * (A2*N)^(1/p));

        bn2 = B2/(p*W2);
        an2 = bn2/( p*(1+W2));

        mean2(i,j) =  (bn2 - gamma_e *an2);

    end
end

width=6.5;
height=2;
x0 = 5;
y0 = 5;
fontsize = 10;

num = 10

f = figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
set(gcf,'color','w');
% figure(1);
subplot(1,3,1)
contourf(Rr/R0,log10(Dr),log10(mean),num);
axis([0.01 0.99 -3 0]);
yticks([-3,-2,-1,0]);
yticklabels({'10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}'});
% xticks([0.01,0.5,0.99]);
% xticklabels({'0.01','0.5','0.99'});
xticks([0.01,0.5,0.99]);
xticklabels({'0.01','0.5','0.99'});
title('A Min (Theory)')
ylabel('Diffusivity','FontUnits','points','FontWeight','normal','FontSize',12);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',10)
set(gcf,'color','w');
% colorbar
caxis manual
caxis([-4 2]);


subplot(1,3,2)
load('bootstrap_data.mat')

M = M(M(:,1)>=0.001,:)

rt = unique(M(:,2));
D = log10(unique(M(:,1)));
[x,y] = meshgrid(D,rt);
z = reshape(M(:,5),numel(rt),numel(D));
contourf(y,x,log10(z),num)
xlabel('Trap radius','FontUnits','points','FontWeight','normal','FontSize',10);
axis([0.01 0.99 -3 0]);
yticks([-3,-2,-1,0]);
yticklabels({'10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}'});
% xticks([0.01,0.5,0.99]);
% xticklabels({'0.01','0.5','0.99'});
xticks([0.01,0.5,0.99]);
xticklabels({'0.01','0.5','0.99'});
% colorbar
title('B Min (Stoch.)')
caxis manual
caxis([-4 2]);


subplot(1,3,3)
% load('mean_arrival_data.mat')
% M = M(M(:,1)>=0.001,:)

rt = unique(M(:,2));
D = log10(unique(M(:,1)));
[x,y] = meshgrid(D,rt);
z = reshape(M(:,4),numel(rt),numel(D));
p3 = contourf(y,x,log10(z),num)
axis([0.01 0.99 -3 0]);
yticks([-3,-2,-1,0]);
yticklabels({'10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}'});
% xticks([0.01,0.5,0.99]);
% xticklabels({'0.01','0.5','0.99'});
xticks([0.01,0.5,0.99]);
xticklabels({'0.01','0.5','0.99'});

caxis manual
caxis([-4 2]);


title('C Mean (Stoch.)')

% colorbar('Ticks',[-4,-2,0,2],...
        % 'TickLabels',{'10^{-4}','10^{-2}','10^{0}','10^{2}'})

colorbar('position', [0.92 0.2153 0.02 0.6684],'Ticks',[-4,-2,0,2],'TickLabels',{'10^{-4}','10^{-2}','10^{0}','10^{2}'})

print(1,'BootstrapFig5.eps','-depsc')
print(1,'BootstrapFig5.tif','-dtiff','-r600')

% print(1,'Fig5_axis2.eps','-depsc')
% print(1,'Fig5_axis2.tif','-dtiff','-r600')
