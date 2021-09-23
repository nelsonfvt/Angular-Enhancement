function [variogram] = gen_variogram(cloud,k)
%GEN_VARIOGRAM Calculates experimental variogram
%Input:
%   cloud: struct, distances and raw points
%   k: group numer
%Retorna:
%   variogram: struct, distances and organized point

variogram.h=[];
variogram.points=[];
variogram.psd=[];

h_o=cloud.h;

d_min=min(h_o);
d_max=max(h_o);
delta_h=(d_max-d_min)/k;

linf=d_min;
lsup=d_min+delta_h;


h=zeros(1,k);
points=zeros(1,k);
psd=zeros(1,k);

for i=1:k
    t=find(h_o<lsup & h_o>=linf);
	nt=length(t);
    
    if nt>0
        dat=cloud.difs(:,t);
        [f,c]=size(dat);
        dat=reshape(dat,[1,f*c]);
        points(i)=mean(dat);
        psd(i)=std(dat);
        h(i)=mean([lsup linf]);
    end
    linf=lsup;
	lsup=lsup+delta_h;
end

%excluding ceros
ph=find(h);
variogram.h=h(ph);
variogram.points=points(ph);
variogram.psd=psd(ph);
end