function c = odorFunTime_strategy(x,y,t, interval,Q,l_max)

u = 5;
c = 0;
K  = 1;
A = 1/10;

ysig = 0;
% pulse_count = roundn(t/interval,0);

pulses = find(interval < t );
r = x./u;

t = t - interval(pulses);
t = t(u*t<1.5*l_max);
for i = 1:length(t)
    
    %     c = c+ Q(i)./(4*pi.*K*r) .* exp( ( -( x-u*t(i)).^2 - y.^2)./(4.*K*r) );

    c = c + Q(i)./( 2*pi.*(A.*t(i)).^2 ) .* exp( -((x-u*t(i)).^2 + y.^2) ./ (2.*(A.*t(i)).^2) );
    
    
end
end

