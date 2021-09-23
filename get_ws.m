function [ws] = get_ws(vecs,vecx,model)
%GET_WS: calculates weights from model and directions
%Input:
%   vecs: orientations of samples
%   vecx: orientation to estimate
%   model: model
%Output:
%   ws: weight vector

%% Calculating Mx semivariances
ns=size(vecs,1);
C=ones(ns+1);
Ct=zeros(ns);
parfor i=1:ns
    cp=zeros(1,ns);
   for j=1:ns
       h=distan([vecs(i,:);vecs(j,:)]);
       v=model(h);
       if isnan(v)
           v=0;
       end
       cp(j)=v;
   end
   Ct(i,:)=cp;
end
C(1:ns,1:ns)=Ct;
C(ns+1,ns+1)=0;

%% Calculating covariances B
B=ones(ns+1,1);
for i=1:ns
    h=distan([vecs(i,:);vecx]);
    B(i)= model(h);
end

%% Calculating Weights
ws=C\B;

end

