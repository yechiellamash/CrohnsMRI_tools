function curved_mpr(V,c)


c=arclength_param(c,1,[]);


doArcLengthInterp=1;
isz=130;
scale_factor=2;
interp_method='cubic';
fh=figure();
ind=round(size(c,2)/2);

c_smoothed(1,:) = sgolayfilt(c(1,:),3,41);
c_smoothed(2,:) = sgolayfilt(c(2,:),3,41);
c_smoothed(3,:) = sgolayfilt(c(3,:),3,41);

% calc plane using 3 points : c(:,1),c(:,end),c(:,ind)
 pln=plane_from_3_pts(c_smoothed(:,1),c_smoothed(:,ind),c_smoothed(:,end));
 v0=pln(1:3)';% use the plane normal

%%% project on plane
[pc,dst]=project_on_plane(c_smoothed,pln,v0);


if doArcLengthInterp
    [pc,dst]=arclength_param(pc,scale_factor,dst);
end

[I,xy]=curved_img(V,pc,v0,dst,scale_factor,isz,interp_method);
ih=imshow(I,[]);
hold on;
ph=plot(xy(:,1),xy(:,2),'r')

set(fh,'WindowScrollWheelFcn',@chage_view);

function chage_view(src,evnt)
    ind=max(min([ind+evnt.VerticalScrollCount,size(c,2)-1]),2);
    pln=plane_from_3_pts(c_smoothed(:,1),c_smoothed(:,ind),c_smoothed(:,end));
    v0=pln(1:3)';% use the plane normal
     %%% project on plane
    [pc,dst]=project_on_plane(c_smoothed,pln,v0);
%     figure(9);hold off;plot3(c_smoothed(1,:),c_smoothed(2,:),c_smoothed(3,:),'.');hold on;plot3(pc(1,:),pc(2,:),pc(3,:),'r.')
    if doArcLengthInterp
        [pc,dst]=arclength_param(pc,scale_factor,dst);
    end
    [I,xy]=curved_img(V,pc,v0,dst,scale_factor,isz,interp_method);
    set(ih,'Cdata',I)
    set(ph,'Xdata',xy(:,1));
    set(ph,'Ydata',xy(:,2));
end

end