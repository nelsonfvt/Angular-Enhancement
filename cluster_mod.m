function [TM_model,stats]=cluster_mod(bvec,bxo,stats,ncl)
%cluster_mod creates clusters and fix the variogram model
%Input:
%   bvec: vector, gradient directions
%   bxo: gradient direction to predict
%   stats: Struct with statistical infor
%   ncl: number of clusters
%Output:
%   TM_model: struct with clusters, variogram models, weights

TM_model.C=[];
TM_model.range=[];
TM_model.ws=[];
TM_model.fits={};

%% GM clustering
Xo=[stats.voxmean stats.voxstd];
%kmeans
[GMidx,gmC]=kmeans(Xo,ncl,'MaxIter',1000,'Options',statset('UseParallel',1),'Start','cluster','Replicates',5);
TM_model.C=gmC;
TM_model.range=[min(Xo); max(Xo)];
cluster=GMidx;

%% Modeling each cluster
ws=zeros(length(bvec)+1,ncl);
fits=cell(ncl,1);
parfor i=1:ncl
    pos=find(GMidx==i);
    TM_nube=gen_cloud(stats.vox(pos,:),bvec);
    TM_var=gen_variogram(TM_nube,29);
    mods={};
    fs=zeros(1,4);
    
    options=fitoptions('Method','NonlinearLeastSquares'); 
    options.Lower      = [min(TM_var.h)*0.01 min(TM_var.points)*0.01];
    options.StartPoint = [mean(TM_var.h) mean(TM_var.points)];
    options.Upper      = [max(TM_var.h)*5 max(TM_var.points)*5];
    options.MaxIter    = 2000;
    
    sph=fittype('Sph_model(x,a,b)');
    [mods{1},sphf]=fit(TM_var.h',TM_var.points',sph,options);
    fs(1)=sphf.adjrsquare;
    
    exp=fittype('Exp_model(x,a,b)');
    [mods{2},expf]=fit(TM_var.h',TM_var.points',exp,options);
    fs(2)=expf.adjrsquare;
    
    gau=fittype('Gau_model(x,a,b)');
    [mods{3},gauf]=fit(TM_var.h',TM_var.points',gau,options);
    fs(3)=gauf.adjrsquare;
    
    options.Lower      = [options.Lower 0.0001];
    options.StartPoint = [options.StartPoint 0.1];
    options.Upper      = [options.Upper 20];
    
    mat=fittype('Mat_model(x,a,b,n)');
    [mods{4},matf]=fit(TM_var.h',TM_var.points',mat,options);
    fs(4)=matf.adjrsquare;
    
    [rsq,I]=max(fs);
    
    fits{i}=mods{I};
    ws(:,i)=get_ws(bvec,bxo,mods{I});
end
TM_model.fits=fits;
TM_model.ws=ws;
[~,indm]=sortrows(TM_model.C);

TM_model.C=TM_model.C(indm,:); %center ordering
TM_model.ws=TM_model.ws(:,indm); %weight ordering
TM_model.fits=TM_model.fits(indm); %model ordering
stats.cluster=zeros(size(cluster));
for c=1:ncl
    nc_idx=find(indm==c); % finding clster index
    n_pos=find(cluster==c); % finding points
    stats.cluster(n_pos)=nc_idx;
end

end
