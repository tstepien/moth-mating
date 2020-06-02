function c = odorFunTime_noise(x,y,t, interval)

Q = 1;
u = 5;
c = 0;
K = .01;
ysig = 2;
r = K*x./u;

pulse_count = roundn(t/interval,0);
t = t-(pulse_count+1)*interval;
if pulse_count > 500;
    pulse_count = 500;
end

for i = 1:pulse_count
    t = t + interval;
    if u*t < 1000
    c = c+ Q./(4*pi.*r) .* exp( ( -( x-u*t).^2 - (y+sqrt(x).*ysig.*randn(1,length(x))).^2)./(4.*r) );
    end
end

