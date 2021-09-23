function [Rec] = Reconstruction(bst,vect,bvect,Df_mod,stats)
%Reconstruction of a DWI
%   bst: DWIs
%   vect: direction to predict (un-used for compatibility)
%   bvect: directions of the DWIs
%   Df_mod: struct with covariance models
%   stats: group statistics

[nf,nc,np,nv]=size(bst);
Rec=single(zeros(nf,nc,np));

% organizing slice reconstruction
C=unique(stats.post(:,3));
ini=min(C);
fin=max(C);
zVal=ini:fin;
Rc=single(zeros(nf,nc,numel(zVal)));
% Reconstruction for each slice
parfor p=1:numel(zVal)
    z=zVal(p);
    ps=find(stats.post(:,3)==z);
    xn=stats.post(ps,1);
    yn=stats.post(ps,2);
    R=zeros(nf,nc);
    N=length(xn);
    for n=1:N
        bv=bvect;
        x=xn(n);
        y=yn(n);
        data=stats.vox(ps(n),:);
        st=stats.voxstd(ps(n));
        mx_data=max(data);
        mn_data=min(data);
        I=stats.cluster(ps(n));
        vox=data*Df_mod.ws(1:nv,I);        
         R(x,y)=vox;
     end
    Rc(:,:,p)=R;
    
end
Rec(:,:,ini:fin)=Rc(:,:,:);
end
