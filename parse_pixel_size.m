function [dx,dy,dz]=parse_pixel_size(meta)
t1_pix_str=meta.spacedirections;
ind11=find(t1_pix_str=='(',1,'first');
ind12=find(t1_pix_str==')',1,'first');
dx=sqrt(sum(str2num(t1_pix_str(ind11+1:ind12-1)).^2));
ind31=find(t1_pix_str=='(');
dy=sqrt(sum(str2num(t1_pix_str(ind12+3:ind31(3)-3)).^2));
dz=sqrt(sum(str2num(t1_pix_str(ind31(3)+1:end-1)).^2));