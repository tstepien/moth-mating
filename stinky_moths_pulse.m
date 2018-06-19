clear all
close all
n = 200;
z = 500+randn(1,n)+1i*(100*(rand(1,n)-0.5));
success = zeros(size(z));

angles = rand(1,n)*2*pi;
speed = 1;
interval = 15;
capThres = 5;
dt = 1;
tol = 10.^(-8+2*randn(1,n));
t = 0;
L = 10;

hold on
cont = fcontour(@(x,y) odorFun(x,y),[-50 6000 -500 500],'LevelStep',0.00001);
mothplot = plot(z,'.')
axis equal

while (t < 500000)
t=t+dt;
angles = angles + (rand(1,n)-0.5)*pi;

c = odorFunTime(real(z),imag(z) , t, interval);
z = z + dt*speed*(exp(1i*angles) + (c>tol).*exp(1i*pi));

success = sqrt(real(z).^2 + imag(z).^2) < capThres;
z = (1-success).*z;

%plotting
mothplot.XData = real(z);
mothplot.YData = imag(z);
% quiver(real(z),imag(z),cos(angles),sin(angles),0.5)
ylim([-500,500])
xlim([-50,6000])
title( sprintf('t=%g',t))
drawnow
end