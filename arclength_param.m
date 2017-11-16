function [xyz3,signal,length_pixels]=arclength_param(xyz3,factor,signal,interp_method)
% perform arclength parameterization for the curve xyz3
% if the curve has signal on it, interpolate it as well.
if nargin<4
interp_method='cubic';
end
if nargin<3
signal=[];
end
if nargin<2
factor=1;
end
len=size(xyz3,2);
dc=[[0;0;0],diff(xyz3,[],2)];
ds=sqrt(sum(dc.^2,1));
s=cumsum(ds);
n=len*factor;
length_pixels=s(end);
length_pix=round(s(end));
s_LUT=linspace(0,s(end),n);
s=interp1(s,linspace(0,size(s,2),100*size(s,2)),'spline');

 for i=1:n
 [mi,inv_s(i)]=min(abs(s-s_LUT(i)));
 end
 inv_s=inv_s/100;
 
 s=interp1(inv_s,linspace(1,n,factor*length_pix));% sample the arc-length par
  
tmp(1,:)=interp1([1:len],xyz3(1,:),s,interp_method);
tmp(2,:)=interp1([1:len],xyz3(2,:),s,interp_method);
tmp(3,:)=interp1([1:len],xyz3(3,:),s,interp_method);
xyz3=tmp;clear tmp;
if size(signal,2)>0 
    signal=interp1([1:len],signal,s,interp_method);
end