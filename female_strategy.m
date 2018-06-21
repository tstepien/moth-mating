function [Q,Qpart,releaseTime,releaseQ] = female_strategy(numpuffs,totalQ,gap,...
    constincdec,dt,tend)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
% constincdec = 'constant','increase','decrease'

% clear variables
% 
% tend = 10;
% 
% numpuffs = 2;
% totalQ = 10;
% gap = tend/2;
% constincdec = 'constant';
% dt = 0.00001;
% interval = 0.01;


%%%%%%%

%%% time vector
t = 0:dt:tend;

%%% set heaviside at origin to be 1 instead of MATLAB's default 1/2
sympref('HeavisideAtOrigin', 1);

%%% set the width of releases
width = (tend - (numpuffs-1)*gap)/numpuffs;

%%% set the heights (Q) of release
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
end

%%% function of Q releases
Qpart = zeros(numpuffs,length(t));
for i = 1:numpuffs
    if i==1
        if numpuffs==1
            Qpart(i,:) = height(i)*(heaviside(t) - heaviside(t - tend));
        else
            Qpart(i,:) = height(i)*(heaviside(t) ...
                - heaviside(t - (i*tend/numpuffs - gap/2)));
        end
    elseif i==numpuffs
        Qpart(i,:) = height(i)*(heaviside(t - ((i-1)*tend/numpuffs + gap/2)) ...
            - heaviside(t - tend));
    else
        Qpart(i,:) = height(i)*(heaviside(t - ((i-1)*tend/numpuffs + gap/2)) ...
            - heaviside(t - (i*tend/numpuffs - gap/2)));
    end
end
if size(Qpart,1)>1
    Q = sum(Qpart);
else
    Q = Qpart;
end

%%% vectors of release times and Q's
releaseTime = t(Q>0);
releaseQ = Q(Q>0);