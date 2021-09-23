function [dif] = diffs(points,i)
%DIFFS calculates square differences
%Input:
%   points: vector, row(s) with points
%   i: position as Z(x)
%Retorna:
%   dif: vector row(s) of square differences

zxi=points(:,i);
points(:,i)=[];
zxj=points;

dif = ((zxj-zxi).^2)./2;
end

