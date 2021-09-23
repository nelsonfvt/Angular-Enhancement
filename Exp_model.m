function [y] = Exp_model(x,a,b)
%Exp_model Modelo exponencial
%   Detailed explanation goes here
y= b.*( 1-exp( -(x./a) ) );
end

