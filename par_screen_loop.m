function par_screen_loop(n)

para = 1;
numCores = 1;

if (nargin == 0)
    n = 2;
    para = 0;

    local = 1;

    if (local)
      tic
      for j = 1:numCores
        par_screen_loop(j)
      end
      toc
      return;
    end

end

pause(rand()/n); rng('shuffle');

filename2 = ['./Results2/ResultsTime_',num2str(n,'%2.1d'),'.mat'];

if (para)
    c=parcluster();
    tmp=tempname();
    mkdir(tmp);
    c.JobStorageLocation=tmp;
end

numParamSets = 4;
MothNumbers = 1000;

for j = 1:numParamSets
    load(['./ParameterSets/parameter_struct_',num2str(j,'%2.1d'),'.mat']);
    pars.n = MothNumbers;
    %pars.runtime = 1e4;
    pars.x0 = 500;
    pars.y0 = 0;
    pars.QT = 1e-1;
    parsAll(j) = pars;

end

%chemoqual = logspace(-10,-6,20);
%anemoqual = linspace(pi/2,pi,40);

chemoqual = 10.^(-[10 7]);
anemoqual = [pi/2 pi];
casttime  = [10];

[ParamSets,chem,anemo,cast] = ndgrid(1:numParamSets,chemoqual,anemoqual,casttime);
ParamSets = ParamSets(:); chem = chem(:); anemo = anemo(:); cast = cast(:);

totalSims = numel(ParamSets);


% sims must be an integer!

sims = floor(totalSims/numCores);

k = ((n-1)*sims+1):(n*sims);

%percent_arrived = zeros(size(chem));
percent_arrived = cell(size(chem));

%tempresults = zeros(size(k));
tempresults = cell(size(k));

if (para)
    % c.NumWorkers = 2;  parpool(c);
    parapars = parallel.pool.Constant(parsAll);

    parfor i = 1:length(k)

        parstemp = parapars.Value(ParamSets(k(i)));
        parstemp.odor_threshold = chem(k(i));
        parstemp.wind_accuracy = anemo(k(i));
        parstemp.cast_time = cast(k(i));

        m = mothFunc(parstemp);
        tempresults{i} = m;
        %tempresults(i) = mean(m.success);
    end
    % delete(gcp('nocreate'));
else
    for i = 1:length(k)
        parstemp = parsAll(ParamSets(k(i)));
        parstemp.odor_threshold = chem(k(i));
        parstemp.wind_accuracy = anemo(k(i));
        parstemp.cast_time = cast(k(i));

        m = mothFunc(parstemp);
        tempresults{i} = m;
        %tempresults(i) = mean(m.success);
    end
end

%percent_arrived(k) = tempresults;

for i = 1:length(k)
    percent_arrived{k(i)} = tempresults{i};
end

%percent_arrived = reshape(percent_arrived,numParamSets,length(chemoqual),length(anemoqual),length(casttime));
save(filename2,'percent_arrived');
