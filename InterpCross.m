function I=InterpCross(V,c,t,n,b,isz,scale_factor)
% The function interp the normal planes along a curve c
% inputs:
% V:3d image volume
% c: curve after arclength parameterization
% t: unit tangent vectors along the curve
% n: principle normal vectors along the curve
% b: secondary normal vectors along the curve
% isz: cross section image size
% scale_factor: factor to resize output image
%
% Yechiel Lamash, 2017

lambda=linspace(-isz/2,isz/2,scale_factor*isz+1);
    
for i=1:size(t,1)
    [a1,b1]=meshgrid(lambda*n(i,1),lambda*b(i,1));
        nb_x(:,:,i)=a1+b1+c(i,1);
        [a1,b1]=meshgrid(lambda*n(i,2),lambda*b(i,2));
        nb_y(:,:,i)=a1+b1+c(i,2);
        [a1,b1]=meshgrid(lambda*n(i,3),lambda*b(i,3));
         nb_z(:,:,i)=a1+b1+c(i,3);
end
I=interp3(V,nb_x,nb_y,nb_z);