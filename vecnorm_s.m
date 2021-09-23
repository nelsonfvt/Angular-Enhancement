function [vn]=vecnorm_s(vec,d)
%Norm of vectors into an array
%Input:
%   vec: array of vectors
%   d: dimension along array 
%       (1 vectors per row)
%       (2 vectors per column)
%Retorna:
%   vn: norm of vectors

[f,c]=size(vec);
vn=[];
if d==1
%norm for each row
	vn=zeros(f,1);
	for i=1:f
		vn(i)=norm(vec(i,:));
	end
elseif d==2
%norm for each column
	vn=zeros(1,c);
	for i=1:c
		vn(i)=norm(vec(:,i));
	end	
end
