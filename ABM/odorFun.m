function c = odorFun(x,y)
%ODORFUN Summary of this function goes here
%   Detailed explanation goes here
u = 5;
Q = 1;
c = (x>0)*(Q/(2*pi*x)) * exp( -u*y^2 / (4*x) );
end

