clear all
close all
clc

doplot = 0;

n = 10000;
% moths.z = 500+randn(1,n)+1i*(100*(rand(1,n)-0.5));
moths.z = complex(500*ones(1,n),0*ones(1,n));
moths.state = ones(size(moths.z));
%%% 1 - diffusion
%%% 2 - surge
%%% 3 - cast
%%% 4 - made it to female
moths.timeinstate = zeros(size(moths.z));
moths.success = zeros(size(moths.z));
tol = 10^(-8);
moths.quality = tol*[10*ones(1,n/2), 1/10*ones(1,n/2)];
moths.windsense = pi/6*[1/2*ones(1,n/2) , 2*ones(1,n/2)];

moths.angles = rand(1,n)*2*pi;
speed = 1;
interval = 60;
capThres = 5;
dt = 1;
t = 0;
L = 10;

if doplot==1
hold on
% cont = fcontour(@(x,y) odorFun(x,y),[-50 1000 -500 500],'LevelStep',0.00001);
mothplot = plot(moths.z,'.r');
% mothplot = scatter(real(moths.z),imag(moths.z),[],moths.state,'.')
caxis([1,4])
colormap(jet)
axis equal
end

% cont = fcontour(@(x,y) odorFunTime_tues3pm(x,y,t,interval),[-50 1000 -500 500],...
%     'LevelList',[min(moths.quality),max(moths.quality)]);

while (t < 3600*2)
t=t+dt;
moths.timeinstate = moths.timeinstate + dt;

%%% update angles
ind = find(moths.state==1);
moths.angles(ind) = moths.angles(ind) + (rand(1,length(ind))-0.5)*2*pi;

ind = find(moths.state==2);
moths.angles(ind) = pi + (rand(1,length(ind))-0.5).*moths.windsense(ind); %take time to turn? add noise?

ind = find(moths.state==3);
moths.angles(ind) = 3*pi/2 + (rand(1,length(ind))-0.5).*moths.windsense(ind)...
    - pi*(rand(1,length(ind))>=0.5);

%%% plume concentration
c = odorFunTime_tues3pm(real(moths.z),imag(moths.z) , t, interval);

moths.success = sqrt(real(moths.z).^2 + imag(moths.z).^2) < capThres;

moths.old = moths.state;

%%% update states
moths.state(moths.state==1 & c>moths.quality) = 2; %%% 1->2
moths.state(moths.state==2 & c<moths.quality) = 3; %%% 2->3
moths.state(moths.state==3 & c>moths.quality) = 2; %%% 3->2
moths.state(moths.state==3 & moths.timeinstate>10) = 1; %%% 3->1
moths.state(moths.success==1) = 4; %%% ->4

moths.timeinstate(moths.old~=moths.state) = 0;

moths.z = moths.z + dt*speed*(exp(1i*moths.angles));% + (c>moths.quality).*exp(1i*pi));
moths.z = (1-moths.success).*moths.z;


%plotting
if doplot==1
% quiver(real(moths.z),imag(moths.z),cos(moths.angles),sin(moths.angles),0.5)
ylim([-500,500])
xlim([-50,1000])
title( sprintf('t=%g,s1=%g,s2=%g,s3=%g,s4=%g',t,sum(moths.state==1),...
    sum(moths.state==2),sum(moths.state==3),sum(moths.state==4)))
    drawnow
% if ceil(t/20)==t/20
%     delete(cont)
%     cont = fcontour(@(x,y) odorFunTime_tues3pm(x,y,t,interval),[-50 1000 -500 500],...
%         'LevelList',[min(moths.quality),max(moths.quality)]);
% end
% mothplot.XData = real(moths.z);
% mothplot.YData = imag(moths.z);
% mothplot.CData = moths.state;
mothplot = plot(moths.z,'.r');
end

end

badmoths = moths.state(1:n/2);
goodmoths = moths.state(n/2+1:end);

disp(['number of bad moths that made it =',num2str(sum(badmoths==4))])
disp(['number of good moths that made it =',num2str(sum(goodmoths==4))])
disp(['number of all moths that made it =',num2str(sum(moths.state==4))])

disp(['number in state 1 = ',num2str(sum(moths.state==1))])
disp(['number in state 2 = ',num2str(sum(moths.state==2))])
disp(['number in state 3 = ',num2str(sum(moths.state==3))])