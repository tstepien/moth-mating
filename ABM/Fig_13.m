load('pars.mat')

pars.n = 10000;

% Define pheromone male speeds (speeds) and Ctols (thresholds)
runtimes = 3600*8;
speeds = linspace(0.5, 2,10);
thresholds = 10.^[-10:-7];

successes = nan(length(runtimes), length(speeds),length(thresholds));
mean_time = nan(length(runtimes), length(speeds),length(thresholds));
min_time = nan(length(runtimes), length(speeds),length(thresholds));

% Run sims and compute mean and min arrival times
for i = 1:length(runtimes)
    for j = 1:length(speeds)
        for k = 1:length(thresholds)
            pars.runtime = runtimes(i);
            pars.speed = speeds(j);
            pars.odor_threshold = thresholds(k);
            tic;z = mothFunc(pars);toc
            successes(i,j,k) = mean(z.success);
            mean_time(i,j,k) = nanmean(z.timetocapture);
            min_time(i,j,k) = nanmin(z.timetocapture);
        end
    end
end

% Plot results
figure
subplot(1,2,1)

imagesc(squeeze(min_time./3600))
set(gca,'YDir','normal','XDir','reverse','XTick',[1:4], 'YTick',linspace(1,10,4), 'XTickLabel',{'10^{-10}' '10^{-9}' '10^{-8}' '10^{-7}'}, 'YTickLabel',linspace(0.5,2,4))
colorbar
title('Mean t_a numerical')
xlabel('C_{tol} (pg/m^2')
ylabel('v (m/s)')

subplot(1,2,2)

imagesc(squeeze(mean_time./3600))
set(gca,'YDir','normal','XDir','reverse','XTick',[1:4], 'YTick',linspace(1,10,4), 'XTickLabel',{'10^{-10}' '10^{-9}' '10^{-8}' '10^{-7}'}, 'YTickLabel',linspace(0.5,2,4))
colorbar
title('Mean t numerical')
xlabel('C_{tol} (pg/m^2')
ylabel('v (m/s)')