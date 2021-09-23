function [y] = Mat_model(x,a,b,n)
%MAT_model Matern model
%   Detailed explanation goes here
ft=1./(2.^(n-1).*gamma(n)).*(x./a).^n;
st=besselk(n,(x./a));
y=b.*( 1-ft.*st );
end

