function [moths] = mothFunc(pars)

%%% Parameter structure:

% pars.n = 200
% pars.x0 = 500
% pars.y0 = 50
% pars.speed = 1
% pars.odor_threshold = 1e-7
% pars.cast_time = 10
% pars.wind_accuracy = pi/6
% pars.capture_threshold = 5
% pars.puffinterval = 15
% pars.runtime = 3600
% pars.doplot = 0

%Read in par struct
n = pars.n;
x0 = pars.x0;
y0 = pars.y0;
speed = pars.speed ;
quality = pars.odor_threshold;
castTime = pars.cast_time;
windsense = pars.wind_accuracy;
interval = pars.puffinterval;
capThres = pars.capture_threshold;
runTime = pars.runtime;
doplot = pars.doplot;
dovideo = pars.doplot;


if dovideo == 1
v = VideoWriter('phaseplanesnoise.avi');
open(v);
end


moths.z = complex(x0*ones(1,n),y0*ones(1,n));   % Initialize coord vector for moths
moths.state = ones(size(moths.z));              % Initialize state vector for moths; states:
%%% 1 - diffusion
%%% 2 - surge
%%% 3 - cast
%%% 4 - made it to female

moths.timeinstate = zeros(size(moths.z));      
moths.success = zeros(size(moths.z));


moths.quality = quality*ones(1,n);
moths.windsense = windsense*ones(1,n);

moths.angles = rand(1,n)*2*pi;                  % Initialize heading vector for moths

dt = 1;
t = 0;
   
    fact = 2; 
  width = 4*fact;
  height = 3*fact;
  x0 = 5;
  y0 = 5;
  fontsize = 18;

  figure('Units','inches','Position',[x0 y0 width height],'PaperPositionMode','auto','Color',[1,1,1]);

if doplot==1
    hold on
    cont = fcontour(@(x,y) odorFunTime_noise(x,y,t,interval),[-50 600 -500 500],'LevelList',[min(moths.quality),max(moths.quality)] , 'MeshDensity',200);
    % mothplot = plot(moths.z,'.r');
    mothplot = scatter(real(moths.z),imag(moths.z),[],moths.state,'.')
    caxis([1,4])
    colormap(jet)

  xlabel({'$x$'},'FontUnits','points','Interpreter','latex','FontWeight','normal','FontSize',fontsize,'FontName','Times')
  ylabel({'$y$'},'FontUnits','points','Interpreter','latex','FontWeight','normal','FontSize',fontsize,'FontName','Times')
  set(gca,'Units','normalized','FontUnits','points','FontWeight','normal','FontSize',fontsize,'FontName','Times')

end

% cont = fcontour(@(x,y) odorFunTimce_tues3pm(x,y,t,interval),[-50 1000 -500 500],...
%     'LevelList',[min(moths.quality),max(moths.quality)]);



while (t < runTime)
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
%     c = odorFunTime_tues3pm(real(moths.z),imag(moths.z) , t, interval);
    % c = odorFun(real(moths.z),imag(moths.z));
   c = odorFunTime_noise(real(moths.z),imag(moths.z) , t, interval);
    
    
    moths.success = sqrt(real(moths.z).^2 + imag(moths.z).^2) < capThres;
    
    moths.old = moths.state;
    
    %%% update states
    % castTime = 0;
    moths.state(moths.state==1 & c>moths.quality) = 2; %%% 1->2
    moths.state(moths.state==2 & c<moths.quality) = 3; %%% 2->3
    moths.state(moths.state==3 & c>moths.quality) = 2; %%% 3->2
    moths.state(moths.state==3 & moths.timeinstate>castTime) = 1; %%% 3->1
    moths.state(moths.success==1) = 4; %%% ->4
    
    moths.timeinstate(moths.old~=moths.state) = 0;
    
    moths.z = moths.z + dt*speed*(exp(1i*moths.angles));% + (c>moths.quality).*exp(1i*pi));
    moths.z = (1-moths.success).*moths.z;
    
    
    %plotting
    if doplot==1
        % quiver(real(moths.z),imag(moths.z),cos(moths.angles),sin(moths.angles),0.5)
        ylim([-100,100])
        xlim([-50,600])
        title( sprintf('time = %g random walkers = %g \n surging = %g casting = %g mating = %g',t,sum(moths.state==1),...
            sum(moths.state==2),sum(moths.state==3),sum(moths.state==4)))
        drawnow
        
        if ceil(t/10)==t/10
            delete(cont)
% cont = fcontour(@(x,y) odorFunTime_noise(x,y,t,interval),[-50 1000 -500 500],...
%                  'LevelList',[min(moths.quality),max(moths.quality)],'MeshDensity',100);
            
            cont = fcontour(@(x,y) odorFunTime_noise(x,y,t,interval),[-50 600 -500 500],...
               'LevelList',[min(moths.quality),max(moths.quality)],'MeshDensity',200);
        end
        
        mothplot.XData = real(moths.z);
        mothplot.YData = imag(moths.z);
        mothplot.CData = moths.state;
        % mothplot = plot(moths.z,'.r');
        if dovideo == 1
          frame = getframe(gcf);
          writeVideo(v,frame);
        end

    end
    
end

moths.timetocapture = t - moths.timeinstate(moths.state ==4 );
if dovideo == 1
close(v)
end
end