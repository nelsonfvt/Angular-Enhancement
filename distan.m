function [h]=distan(bvec,varargin)
%calculates distances (half circunference)
%Input:
%   bvec: vectors, gradient directions (rows)
%   i: (optional) positiin as x
%Output:
%   h: vector with distances


if nargin==1
    xi=bvec(1,:);
    xj=bvec(2,:);
else
    i=varargin{1};
    xi=bvec(i,:);
    bvec(i,:)=[];
    xj=bvec;
end

h=abs(xi*xj')';
h=h./( norm(xi) .* vecnorm_s(xj,1));
h=real(acos(h))./pi;

end