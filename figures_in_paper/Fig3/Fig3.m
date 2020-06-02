function PlotCDF

D = 1; % Diffusion constant
R0 = 5; % Initial Radius
Rt = 1; % Trap radius

R = R0/Rt;
tmin = 1e-2;
tend = 1e10; % in physical.

fun = @(w,R,t) (2/pi)*((bessely(0,R*w).*besselj(0,w)-bessely(0,w).*besselj(0,R*w))./((besselj(0,w)).^2+(bessely(0,w)).^2)).*w.*exp(-t.*w.^2);

S_time = @(t) integral(@(w) fun(w,R,t),0,Inf,'AbsTol',1e-14,'RelTol',1e-14);
P_surv = @(t) integral(@(w) fun(w,R,t)./(w.^2),0,Inf,'AbsTol',1e-13,'RelTol',1e-13);

%close all;
%
nondim = D/(Rt^2);

t = logspace(log10(nondim*tmin),log10(nondim*tend),240);

figure(1);
hold on;

P = zeros(size(t));
C = zeros(size(t));
S = zeros(size(t));

for j = 1:length(t)

%     P(j) = P_surv(t(j));
%     C(j) = 1 - P(j);
     S(j) = S_time(t(j));
     P(j) = 1 - simps([0 t(1:j)],[0 S(1:j)]);
     C(j) = 1 - P(j);
%
%  P2(j) = 1 - getAbsProb(t(j),R0,Rt,D);
%  P3(j) = P_surv(t(j));
  %C(j) = 1 - P(j);
end
%
% figure(1);
%
% plot(log10(t/nondim),P,'ks','linewidth',2); hold on;
% %plot(log10(t),P2,'b','linewidth',2)
% %plot(log10(t),P3,'g','linewidth',2)
% plot(log10(t/nondim),S/max(S),'r','linewidth',2)
% % St = -[0 diff(P2)./diff(t)];
% % plot(log10(t),St/max(St),':r','linewidth',2)
% % St = -[0 diff(P2)./diff(t)];
% % plot(log10(t),St/max(St),':g','linewidth',2)
% %
% % figure(2);
% return

width=12;
height=6;
x0 = 5;
y0 = 5;
fontsize = 16;

%figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
box on;

hold on;
yyaxis left;
ylim([-0.005 1.005])
plot(log10(t/nondim),C,'linewidth',3,'DisplayName','Capture Probability')

plot(log10(t/nondim),P,'linewidth',3,'DisplayName','Survival Probability')

ytickformat('%2.1f')
yticks([0 0.2 0.4 0.6 0.8 1.0]);
ylabel('Probability','FontUnits','points','FontWeight','normal','FontSize',fontsize)

%plot(log10(t),P2,'linewidth',2,'DisplayName','Survival Probability')

str = 'C(t)';
text(6,0.9,str,'FontUnits','points','FontWeight','normal','FontSize',fontsize,'color',[0, 0.4470, 0.7410]);

str = 'S(t)';
text(-0.8,0.5,str,'FontUnits','points','FontWeight','normal','FontSize',fontsize,'color',[0.8500, 0.3250, 0.0980]);

str = 'P(t)';
text(6,0.1,str,'FontUnits','points','FontWeight','normal','FontSize',fontsize,'color',[0, 0.4470, 0.7410]);

yyaxis right;
plot(log10(t/nondim),S,'linewidth',3,'DisplayName','Capture distribution')

set(gcf,'color','w')
xticks([-2 0 2 4 6 8 10]);
%yticks([0 0.01 0.02 0.03]);
xticklabels({'10^{-2}','10^{0}','10^{2}','10^{4}','10^{6}','10^{8}','10^{10}'});

ytickformat('%3.2f')

xlabel('time','FontUnits','points','FontWeight','normal','FontSize',fontsize);
%ylabel('Diffusivity','FontUnits','points','FontWeight','normal','FontSize',fontsize);
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
set(gcf,'color','w');

xlim([-2,10])
ylim([0 .03])

%legend;
%ylim([0 1]);

hold off;

%print(2,'ThreeCurves.eps','-depsc')
%print(2,'ThreeCurves.eps','-dtiff','-r600')

%
% figure(2);
% plot(log10(t),S,'linewidth',2,'DisplayName','Capture distribution')
% hold on;
%
% hold off;
% set(gcf,'color','w')

%ylim([-0.2 1]);
