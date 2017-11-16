function straight_mpr(V,c)

isz=70;
scale_factor=2;
fh1=figure();
ind=round(size(c,2)/2);
c=arclength_param(c',1,[])';

c(:,1) = sgolayfilt(c(:,1),3,41);
c(:,2) = sgolayfilt(c(:,2),3,41);
c(:,3) = sgolayfilt(c(:,3),3,41);

[t,n,b]=FrenetSerret_frame(c,0);
[n,b]=rotate_normal(n,b,t);
I=InterpCross(V,c,t,n,b,isz,scale_factor);
ih1=imshow(I(:,:,ind),[]);
hold on;
ph=plot((scale_factor*isz+1)/2,(scale_factor*isz+1)/2,'r.');

ang=0;
midLine=round((scale_factor*isz+1)/2);
I1=I;
fh2=figure();
ih2=imshow(imresize(squeeze(I1(:,midLine,:)),scale_factor*[isz,size(I,3)])',[])


set(fh1,'WindowScrollWheelFcn',@chage_view);
set(fh2,'WindowScrollWheelFcn',@chage_view);

function chage_view(src,evnt)
    if gcf==fh1
     ind=max(min([ind+evnt.VerticalScrollCount,size(I,3)]),1);
     set(ih1,'Cdata',I(:,:,ind))
    end
    
    if gcf==fh2
     ang=ang+5*evnt.VerticalScrollCount;
     [n1,b1]=rotate_straight_img(n,b,t,ang);
     I1=InterpCross(V,c,t,n1,b1,isz,scale_factor); 
     set(ih2,'Cdata',(imresize(squeeze(I1(:,midLine,:)),scale_factor*[isz,size(I1,3)]))');
    end
end

end