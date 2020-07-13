load('pars.mat');

pars.n = 10000; % Note this will take a while to run at N = 10,000

% Define pheromone titers (Qs) and times (hourly)
Qs = [1:10];
times = 3600*[1:8];

% Run sims
z = mothFunc_rand(pars);
for i = 1:length(Qs)
pars.QT = Qs(i);
tic;z(i) = mothFunc_rand(pars);toc;
end

% Compute fraction successful, mean successful velocity, and mean
% successful sensitivity
for i = 1:length(Qs)
    for j = 1:length(times)
        fract_successful(i,j) = sum(z(i).timetocapture<times(j) ) / pars.n;
        sens_s = z(i).quality(z(i).success);
        speed_s = z(i).speed(z(i).success);
        mean_sens_s(i,j) = mean(  sens_s(z(i).timetocapture<times(j))   );
        mean_speed_s(i,j) = mean(  speed_s(z(i).timetocapture<times(j))   );
    end
end


% Plot
figure
subplot(1,3,1)
imagesc(fract_successful)
set(gca,'YDir','reverse','XDir','normal','XTick',[2:2:8], 'YTick',2:2:10, 'XTickLabel',2:2:8, 'YTickLabel',2:2:10)
colorbar
title('Mating Probability')
ylabel('m_p (pg)')
xlabel('t_{call} (hrs)')

subplot(1,3,2)
imagesc(mean_speed_s)
set(gca,'YDir','reverse','XDir','normal','XTick',[2:2:8], 'YTick',2:2:10, 'XTickLabel',2:2:8, 'YTickLabel',2:2:10)
colorbar
title('Mean speed upon arrival')
ylabel('m_p (pg)')
xlabel('t_{call} (hrs)')

subplot(1,3,3)
imagesc(mean_sens_s)
set(gca,'YDir','reverse','XDir','normal','XTick',[2:2:8], 'YTick',2:2:10, 'XTickLabel',2:2:8, 'YTickLabel',2:2:10)
colorbar
title('Mean sensitivity upon arrival')
ylabel('m_p (pg)')
xlabel('t_{call} (hrs)')