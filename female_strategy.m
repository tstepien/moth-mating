function [releaseTime,releaseQ] = female_strategy(numpuffs,totalQ,gap,...
    constincdec,dt,tend)
% [releaseTime,releaseQ] = female_strategy(numpuffs,totalQ,gap,...
%     constincdec,dt,tend)
%
% female moth pheromone release strategy
%
% inputs:
%   numpuffs    = number of continuous puffs of pheromone release
%   totalQ      = total amount of pheromone released
%   gap         = time gap between puffs released
%   constincdec = options are: 'constant', 'increase', 'decrease', or 'hat'
%                 this is the relation between concentrations of the
%                 individual puffs and time
%   dt          = time step of the simulation
%   tend        = ending time of the pheromone release/simulation
%
% outputs:
%   releaseTime = vector of times at which pheromone is released
%   releaseQ = vector of concentrations released at corresponding releaseTime

%%% time vector
t = 0:dt:tend;

%%% set Heaviside at origin to be 1 instead of MATLAB's default 1/2
sympref('HeavisideAtOrigin', 1);

%%% set the width of pheromone releases
width = (tend - (numpuffs-1)*gap)/numpuffs;

%%% set the heights (Q) of pheromone releases
height = zeros(1,numpuffs);
if strcmp(constincdec,'constant')==1
    height = (totalQ/numpuffs)/width * ones(1,numpuffs);
elseif strcmp(constincdec,'increase')==1
    spacing = linspace(0,1,numpuffs+1);
    for i=1:numpuffs
        height(i) = spacing(i+1) * totalQ/(sum(spacing(2:end))*width);
    end
elseif strcmp(constincdec,'decrease')==1
    spacing = flip(linspace(0,1,numpuffs+1));
    for i=1:numpuffs
        height(i) = spacing(i) * totalQ/(sum(spacing(2:end))*width);
    end
elseif strcmp(constincdec,'hat')==1
    if numpuffs/2==ceil(numpuffs/2)
        spacing = [linspace(0,1,ceil((numpuffs+1)/2)) , ...
            flip(linspace(0,1,ceil((numpuffs+1)/2)))];
    else
        spacing = [linspace(0,1,(numpuffs+1)/2+1) , ...
            flip(linspace(0,1,(numpuffs+1)/2+1))];
        spacing = spacing([1:(numpuffs+1)/2,(numpuffs+1)/2+2:end]);
    end
    for i=1:numpuffs
        height(i) = spacing(i+1) * totalQ/(sum(spacing(2:end))*width);
    end
end

%%% concentration of pheromone releases
Q = 0;
for i = 1:numpuffs
    Q = Q + height(i)*(heaviside(t - (i-1)*(width+gap)) ...
        - heaviside(t - (i*width+(i-1)*gap)));
end

% plot(t,Q)

%%% vectors of pheromone release times and concentrations
releaseTime = t(Q>0);
releaseQ = Q(Q>0);