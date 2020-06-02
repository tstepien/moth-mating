clear all
close all

n = 200;
z = 50+randn(1,n)+1i*(100*(rand(1,n)-0.5));
angles = rand(1,n)*2*pi;

speed = 1;
dt = 1;
tol = 1e-8;

t = 0;

L = 10;

hold on
cont = fcontour(@(x,y) odorFun(x,y),[0 50 -50 50],'LevelStep',0.001);
mothplot = plot(z,'.')




while (1 > 0)
  t=t+dt;
  angles = rand(1,n)*2*pi;

  c = odorFun(real(z),imag(z));

  z = z + dt*speed*(exp(1i*angles) + (c>tol).*exp(1i*pi));

  %plotting

  mothplot.XData = real(z);
  mothplot.YData = imag(z);


  % quiver(real(z),imag(z),cos(angles),sin(angles),0.5)

  ylim([-50,50])
  xlim([0,50])
  title(sprintf('t=%g',t))
  drawnow
end
