function P = getAbsProb(tend,Rout,Rin,D)

if nargin == 0
    tend = 100;
    Rout = 1;
    Rin = 0.5;
    D = 1e-2;
end

fun = @(w,R,t) -2./pi.*((bessely(0,w).*besselj(0,R.*w)-bessely(0,R.*w).*besselj(0,w))./((besselj(0,w)).^2+(bessely(0,w)).^2)).*w.*exp(-t.*w.^2);
rho = @(t,R) integral(@(w) fun(w,R,t),0,Inf,'AbsTol',1e-13,'RelTol',1e-13);

dt = 0.1;

R = Rout/Rin; % Ratio of start radius to trap radius.

% non dimensionalized time
nondim = D/(Rin^2);

tfin = tend * nondim;

dt2 = min(dt,tfin/5);

if (tfin<0)
    t = dt2:dt2:tfin;
else
    t = logspace(0,log10(tfin +1),50) - 1;
    t(1) = [];
end

Ptemp = zeros(size(t));

if ( Rin < 0.55 )
    for k = 1:length(t)
        Ptemp(k) = rho(t(k),R);
    end
    P = simps([0 t],[0 Ptemp]);
else
    P = 1-integral( @(w) fun(w,R,tfin)./(w.^2),0,Inf,'RelTol',5e-8,'AbsTol',5e-8);
end
