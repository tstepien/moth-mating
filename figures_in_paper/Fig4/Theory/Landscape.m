close all;

D = logspace(-4,2,19);
rt = linspace(1e-4,0.99,20);
T  = [1,10,20,30,40,50,60,70,80,90,100];
R0 = 1;

P = zeros(length(rt),length(D),length(T));

for i = 1:length(rt)
  for j = 1:length(D)
    parfor k = 1:length(T)
      P(i,j,k) = getAbsProb(T(k),R0,rt(i),D(j));
    end
  end
end

save('CircleTrapTheoryData.mat','P','D','rt','T','R0')
