function out = plottime

close all;

chemoqual = 10.^(-[10 7]);
anemoqual = [pi/2 pi];

[chem, anem] = ndgrid(chemoqual,anemoqual);

for j = 1:1
    filename = ['./Results2/ResultsTime_',num2str(j,'%2.1d'),'.mat'];
    load(filename);

    if (j == 1)
        X = percent_arrived;
    else
        for k = 1:length(X)
            if ~isempty(percent_arrived{k})
                X{k}  = percent_arrived{k};

            end
        end
    end
end

%X = reshape(X,4,length(chemoqual),length(anemoqual));

out = X;

strats = {'const','decrease','hat','increase'};

figure('color','w')
bins = 30;
count = 1;
for i = 1:length(chemoqual)
    for j = 1:length(anemoqual)
        for n = 1:4
            subplot(4,4,count), histogram(log10(1+X{count}.timetocapture),bins,'normalization','probability');
            title(['c = ', num2str(log10(chemoqual(i)),'%d'),', ang = ',num2str(anemoqual(j),'%2.1f'),', strat = ', strats{n},', ',num2str(sum(X{count}.state==4)/5000,'%2.2f')],...
                'interpreter','latex','fontsize',14);

            count = count+1;
        end
    end
end
