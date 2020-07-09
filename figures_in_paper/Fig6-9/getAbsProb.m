function P = getAbsProb(tend,Rout,Rin,D)

if nargin == 0
    tend = 8*60*60;
    D = 1e-2;
    Rin = 0.95;
    Rout = 1;
end

fun = @(w,R,t) (2/pi)*((bessely(0,R.*w).*besselj(0,w) - bessely(0,w).*besselj(0,R.*w))./((besselj(0,w)).^2+(bessely(0,w)).^2)).*w.*exp(-t.*w.^2);
rho = @(t,R) quadgk(@(w) fun(w,R,t),0,Inf,'AbsTol',1e-13,'RelTol',1e-13,'MaxIntervalCount',15000);

R = Rout/Rin; % Ratio of start radius to trap radius.

% non dimensionalized time
nondim = D/(Rin^2);

tfin = tend * nondim;
num_ints = 400;

t = logspace(-1,log10(tfin),num_ints);

% Check whether mass is missing near t = 0;

repeat = 1;
k = -2;

while repeat
    Ptest = 0.5*t(1)*rho(t(1),R); % Rough estimate of missing mass around t = 0.
    if (Ptest > 1e-5)
        t = logspace(k,log10(tfin),num_ints);
        k = k-1;
    else
        repeat = 0;
    end
end

Ptemp = zeros(size(t));

for k = 1:length(t)
    Ptemp(k) = rho(t(k),R);
end
P = simps([0 t],[0 Ptemp]);

% if ( Rin < 1.95 )
%     for k = 1:length(t)
%         Ptemp(k) = rho(t(k),R);
%     end
%     P = simps([0 t],[0 Ptemp]);
%
%     plot(t,Ptemp)
%
%     %P2 = 1-integral( @(w) fun(w,R,tfin)./(w.^2),0,Inf,'RelTol',5e-8,'AbsTol',5e-8)
%     P2 = 1 - quadgk( @(w) fun(w,R,tfin)./(w.^2),0,Inf,'RelTol',5e-8,'AbsTol',5e-8,'MaxIntervalCount',15000)
% else
%
%     P = 1-integral( @(w) fun(w,R,tfin)./(w.^2),0,Inf,'RelTol',5e-8,'AbsTol',5e-8);
% end

% P = 1-integral( @(w) fun(w,R,tfin)./(w.^2),0,Inf,'RelTol',5e-8,'AbsTol',5e-8);
%
% if ( P < 0.2 )
%      for k = 1:length(t)
%          Ptemp(k) = rho(t(k),R);
%      end
%      P = simps([0 t],[0 Ptemp]);
% end

