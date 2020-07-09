close all
clear all

D = 0.5; % Diffusion constant
R0 = 5; % Initial Radius
Rt = 1; % Trap radius

R = R0/Rt;
tmin = 1e-2;
tend = 1e10; % in physical.

fun = @(w,R,t) (2/pi)*((bessely(0,R*w).*besselj(0,w)-bessely(0,w).*besselj(0,R*w))./((besselj(0,w)).^2+(bessely(0,w)).^2)).*w.*exp(-t.*w.^2);

S_time = @(t) integral(@(w) fun(w,R,t),0,Inf,'AbsTol',1e-14,'RelTol',1e-14);
P_surv = @(t) integral(@(w) fun(w,R,t)./(w.^2),0,Inf,'AbsTol',1e-13,'RelTol',1e-13);

nondim = D/(Rt^2);

t = logspace(log10(nondim*tmin),log10(nondim*tend),240);

P = zeros(size(t));
C = zeros(size(t));
S = zeros(size(t));

for j = 1:length(t)
     S(j) = S_time(t(j));
     P(j) = 1 - simps([0 t(1:j)],[0 S(1:j)]);
     C(j) = 1 - P(j);
end

width=4;
height=2;
x0 = 5;
y0 = 5;
fontsize = 10;

figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto');
box on;

hold on;
yyaxis left;
ylim([-0.005 1.005])
plot(log10(t/nondim),C,'linewidth',2,'DisplayName','Capture Probability')

plot(log10(t/nondim),P,'linewidth',2,'DisplayName','Survival Probability')

ytickformat('%2.1f')
yticks([0 0.2 0.4 0.6 0.8 1.0]);
ylabel('Probability','FontUnits','points','FontWeight','normal','FontSize',fontsize)

%plot(log10(t),P2,'linewidth',2,'DisplayName','Survival Probability')

str = '$C(t)$';
text(6,0.9,str,'FontUnits','points','FontWeight','normal','FontSize',fontsize,'color',[0, 0.4470, 0.7410],'Interpreter','latex');

str = '$S(t)$';
text(-0.8,0.5,str,'FontUnits','points','FontWeight','normal','FontSize',fontsize,'color',[0.8500, 0.3250, 0.0980],'Interpreter','latex');

str = '$P(t)$';
text(6,0.1,str,'FontUnits','points','FontWeight','normal','FontSize',fontsize,'color',[0, 0.4470, 0.7410],'Interpreter','latex');

yyaxis right;
plot(log10(t/nondim),S,'linewidth',2,'DisplayName','Capture distribution')
ylabel('$S(t)$','interpreter','latex','fontsize',fontsize)
set(gcf,'color','w')
xticks([-2 0 2 4 6 8 10]);
xticklabels({'10^{-2}','10^{0}','10^{2}','10^{4}','10^{6}','10^{8}','10^{10}'});

ytickformat('%3.2f')

xlabel('$t$','FontUnits','points','FontWeight','normal','FontSize',fontsize,'interpreter','latex');
set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize)
set(gcf,'color','w');

xlim([-2,10])
ylim([0 .03])

hold off;

print(1,'Fig2.eps','-depsc')
