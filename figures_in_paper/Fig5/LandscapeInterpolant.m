load('CircleTrapTheoryData.mat')
close all
[X,Y,Z] = ndgrid(rt,log10(D),T);
F = griddedInterpolant(X,Y,Z,P);
