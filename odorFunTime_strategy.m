function c = odorFunTime_strategy(x,y,t, interval,Q)

u = 5;
c = 0;
K  = 1;

ysig = 0;
% pulse_count = roundn(t/interval,0);

pulses = find(interval < t );
r = x./u;

 t = t - interval(pulses);
for i = 1:length(t)
   
%     t = t - interval(i);
                 c = c+ Q(i)./(4*pi.*K*r) .* exp( ( -( x-u*t(i)).^2 - y.^2)./(4.*K*r) );
       %     c = c+ Q(i)./(4*pi.*K*r) .* exp( ( -( x-u*t(i)).^2 - (y+sqrt(x).*ysig*randn(size(x) ) ).^2)./(4.*K*r) );

    end
end

