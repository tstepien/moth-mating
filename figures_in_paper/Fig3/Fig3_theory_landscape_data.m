%Fig3
% to make data
D = logspace(-4,-1,15);
rt = linspace(1e-2,0.99,15);
T = 100;
R0 = 1;

P = zeros(length(rt),length(D));
for i = 1:length(rt)
  parfor j = 1:length(D)
    P(i,j) = getAbsProb(T,R0,rt(i),D(j));
  end
end
save('Fig3_Theory_Landscape_Data.mat','D','rt','T','P')
