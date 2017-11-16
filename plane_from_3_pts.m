function pln=plane_from_3_pts(c1,c2,c3)
v1=c3-c1;
v2=c2-c1;
nor=cross(v1,v2);
nor=nor./sqrt(sum(nor.^2));
d=-dot(nor,c1);
pln=[nor',d];