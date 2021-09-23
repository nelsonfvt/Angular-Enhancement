%% Loading data
%addpath('/usr/local/MATLAB/matlab_comm/NIfTI_tools/');

%loading DWI images
dwi=load_untouch_nii([gen_path, 'dwi.nii']);

%loading bval
bval=load([gen_path, 'dwi.bval']);
Mimg=lenght(bval);
g_idx=find(bval>0);
Ndwi=lenght(g_idx); % number of DWI images
Nbos=Mimg-Ndwi;% number of b0s

%loading bvec
bvec=load([gen_path, 'dwi.bvec']);
bvec=bvec(g_idx,:);

%excluding b0s
bs=dwi.img(:,:,:,g_idx);

% Organizing data
bvect=bvec;
bst=bs;
%o is the index to be predicted
xo=bvect(o,:); % gradient direction to be predicted
zxo=bst(:,:,:,o); % image to be predicted

bvect(o,:)=[]; %taking apart gradient direction to be predicted
bst(:,:,:,o)=[]; %taking apart image to be predicted

%% Organizing gradients from closer to farthest
ns=size(bvect,1);
dists=zeros(ns,1);
for i=1:ns
    dists(i)=distan([bvect(i,:);xo]);
end
[B,I]=sort(dists);
I=I(1:ns-Nret);
bs_o=bst(:,:,:,I);
bv_o=bvect(I,:);

%% Clustering
stats=ex_statvoxels(1,bs_o);
[Df_mod,stats]=cluster_mod(bv_o,xo,stats,Nc);

%% Reconstruction
IR=Reconstruction(bs_o,xo,bv_o,Df_mod,stats);

clear Df_mod stats
%% Saving result
% IR_nii=b0_brmask;
% IR_nii.img=IR;
% filename=[gen_path, 'bet/res/Tst_v' num2str(o) '_' num2str(Nret) '.nii'];
% IR_nii.fileprefix=filename;
% save_untouch_nii(IR_nii,filename);