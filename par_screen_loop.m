load('parameter_struct.mat')

pars.puffinterval = 60;
pars.n = 10000;

chemoqual = 10.^[-10:-1];
anemoqual = pi./[10:-1:1];
% chemoqual = 10.^[-10];
% anemoqual = pi./[10];
casttime  = 10;

percent_arrived = nan(length(chemoqual) , length(anemoqual) , length(casttime));


for i = 1:length(chemoqual)
    
    for j = 1:length(anemoqual)
        
        for k = 1:length(casttime)
        tic;
        pars.odor_threshold = chemoqual(i);
        pars.wind_accuracy = anemoqual(j);
        pars.cast_time = casttime(k);
        
        m = mothFunc(pars);
        percent_arrived(i,j,k) = mean(m.success);
        toc
        disp([ 'Completed loop ' num2str([i j k]) ' of ' num2str([ length(chemoqual)  length(anemoqual) length(casttime) ]) '.' ])
        end
    end
end