function [I,xy]=curved_img(V,pc,v0,dst,scale_factor,isz,interp_method)
%input:
% V: 3d image
% pc: projection of curve on plane
% v0: vector of interest
% dst: distances from projected curve to curve at 3d
% scale_factor: image scale factor
% isz: curved mpr image width
% interp_method: interpolation method
%output:
% I: curved mpr image
% xy: curve on curved mpr image
%
% Yechiel Lamash, 2017

nn=scale_factor*isz+1;
lambda=linspace(-isz/2,isz/2,nn);
X=zeros(size(pc,2)*nn,3);
for i=1:size(pc,2) 
    x=pc(1,i)-lambda*v0(1);
    y=pc(2,i)-lambda*v0(2);
    z=pc(3,i)-lambda*v0(3); 
    X((i-1)*nn+1:i*nn,:)=[x(:),y(:),z(:)];
    xy(i,:)=[isz+scale_factor*dst(i),i];
end
     
try% faster interpolation (in case exist on path)
  I=ba_interp3B(V,X(:,1)+1,X(:,2)+1,X(:,3)+1,interp_method);
catch
  I=interp3(V,X(:,1)+1,X(:,2)+1,X(:,3)+1,interp_method);
end

I=reshape(I,nn,[])';