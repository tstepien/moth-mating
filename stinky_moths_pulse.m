clear all
close all

n = 2;
moths.z = 500+randn(1,n)+1i*(100*(rand(1,n)-0.5));
moths.state = ones(size(moths.z));
%%% 1 - diffusion
%%% 2 - surge
%%% 3 - cast
%%% 4 - made it to female
moths.timeinstate = zeros(size(moths.z));
moths.success = zeros(size(moths.z));
tol = 10^(-8);
moths.quality = tol*[10*ones(1,n/2), 1/10*ones(1,n/2)];

moths.angles = rand(1,n)*2*pi;
speed = 1;
interval = 60;
capThres = 5;
dt = 1;
t = 0;
L = 10;

hold on
% cont = fcontour(@(x,y) odorFun(x,y),[-50 1000 -500 500],'LevelStep',0.00001);
mothplot = plot(moths.z,'.r')
% mothplot = scatter(real(moths.z),imag(moths.z),[],moths.state,'.')
caxis([1,4])
colormap(jet)
axis equal

cont = fcontour(@(x,y) odorFunTime(x,y,t,interval),[-50 1000 -500 500],...
    'LevelStep',0.0001,'MeshDensity',200);

while (t < 500000)
t=t+dt;

%%% update angles
ind = find(moths.state==1);
moths.angles(ind) = moths.angles(ind) + (rand(1,length(ind))-0.5)*2*pi;

ind = find(moths.state==2);
moths.angles(ind) = pi; %take time to turn? add noise?

ind = find(moths.state==3);
moths.angles(ind) = 3*pi/2 - pi*(rand(1,length(ind))>=0.5);

%%% plume concentration
c = odorFunTime(real(moths.z),imag(moths.z) , t, interval);

moths.success = sqrt(real(moths.z).^2 + imag(moths.z).^2) < capThres;

%%% update states
moths.state(moths.state==1 & c>moths.quality) = 2;
moths.state(moths.state==2 & c<moths.quality) = 3;
moths.state(moths.state==3 & c>moths.quality) = 2;
moths.state(moths.success==1) = 4;

moths.z = moths.z + dt*speed*(exp(1i*moths.angles));% + (c>moths.quality).*exp(1i*pi));
moths.z = (1-moths.success).*moths.z;


%plotting
% quiver(real(moths.z),imag(moths.z),cos(moths.angles),sin(moths.angles),0.5)
ylim([-500,500])
xlim([-50,1000])
title( sprintf('t=%g,s1=%g,s2=%g,s3=%g,s4=%g',t,sum(moths.state==1),...
    sum(moths.state==2),sum(moths.state==3),sum(moths.state==4)))
    drawnow
% if ceil(t/100)==t/100
%     delete(cont)
%     cont = fcontour(@(x,y) odorFunTime(x,y,t,interval),[-50 1000 -500 500],...
%         'LevelStep',0.00001);
% end
% mothplot.XData = real(moths.z);
% mothplot.YData = imag(moths.z);
% mothplot.CData = moths.state;
mothplot = plot(moths.z,'.r')

end