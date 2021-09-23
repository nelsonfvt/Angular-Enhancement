function [stat_str]=ex_statvoxels(Nn,Arr)
%ex_statvoxels Generates statisitics about voxels
%Input:
%   Nn: Sampling factor (0:1]; Not used
%   Arr: 4D image
%Output:
%   stat_str: Struct with mean and std desv

stat_str.vox=[]; %voxels
stat_str.voxmean=[]; %mean of voxels across volumes
stat_str.voxstd=[]; %std of voxels across volumes
stat_str.post=[]; %positions of voxels

[~,~,~,nv]=size(Arr);

%finding mask voveles
[x,y,z,~]=findND(Arr(:,:,:,1));
N=length(x);

voxmean=zeros(N,1);
voxstd=zeros(N,1);
vox=zeros(N,nv);
voxoutl=zeros(N,1);
parfor n=1:N
    Ar=reshape(Arr(x(n),y(n),z(n),:),[1 nv]);
    [A,TF]=filloutliers(Ar,'clip');
    voxmean(n)=mean(A);
    voxstd(n)=std(A,0);
    vox(n,:)=A;
end
stat_str.voxmean=double(voxmean);
stat_str.voxstd=double(voxstd);
stat_str.vox=vox;
stat_str.post=[x,y,z];
stat_str.voxoutl=voxoutl;

end
