function [y] = Gau_model(x,a,b)
%Gau_model Modelo Gaussiano
%   Detailed explanation goes here
y=b.*( 1-exp(-(x.^2)./(a.^2)) );
end

