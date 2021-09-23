function [cloud_str] = gen_cloud(Vmeds,bvec)
%GEN_CLOUD generates variogram cloud
%Input:
%   Vmeds: Vector, patch mean
%   bvec: Matrix, gradient directions
%Output:
%   cloud_str: struct, contains square diferences and distances (h)

cloud_str.difs = [];
cloud_str.h = [];

[npch,ngr]=size(Vmeds);
[~,ngrb]=size(bvec);

for i=1:ngr
    cloud_str.h=[cloud_str.h distan(bvec,i)'];
    cloud_str.difs=[cloud_str.difs diffs(Vmeds,i)];
end

end

