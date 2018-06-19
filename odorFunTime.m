function c = odorFunTime(x,y,t, interval)

Q = 1;
u = 5;
c = 0;

pulse_count = roundn(t/interval,0);

r = x/u;

for i = 1:pulse_count
    t = t - interval;
    c = c+ Q./(4*pi.*r) .* exp( ( -( x-u*t).^2 - y.^2)./(4.*r) );
end

