function V=gen_isotropic_volume(X,meta)
[dx,dy,dz]=parse_pixel_size(meta);
sz=size(X);
[x,y,z]=ndgrid(1:sz(2),1:sz(1),1:dx/dz:sz(3));
V=interp3(single(X),x,y,z);
V=permute(V,[2,1,3]);