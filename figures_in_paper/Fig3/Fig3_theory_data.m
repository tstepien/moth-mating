%Fig3
% to make data
D = logspace(-4,-1,4);
rt = linspace(1e-4,0.99,20);
T = 100;
R0 = 1;

P = zeros(length(rt),length(D));
for i = 1:length(rt)
  parfor j = 1:length(D)
    P(i,j) = getAbsProb(T,R0,rt(i),D(j));
  end
end
save('Fig3_Theory_Data.mat','D','rt','T','P')
