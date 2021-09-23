function [y] = Sph_model(x,a,b)
%Sph_mode Modelo esférico
%   Detailed explanation goes here
y=ones(size(x)).*b;
if x<=a
    y=b.*( (3.*x./(2*a)) - (0.5.*(x./a).^2) );
end

end

