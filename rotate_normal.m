function [n1,b1]=rotate_normal(n,b,t)
%the function rotates the normal plane vectores to have the same global
%direction
%Yechiel Lamash, 2017
ang(1)=0;
for i=1:size(t,1)
    %calc diff angle between adjucent normals
    if i>1
    pn=sum(n(i-1,:).*n(i,:),2);
    pb=sum(n(i-1,:).*b(i,:),2);
    ang(i)=atan2d(pb,pn);
    end
    %cumsum the angle
    sumang(i)=sum(ang(1:i));
    %compute new vectors n1,v1
    A=[n(i,:);b(i,:);t(i,:)];
    bb=[cosd(sumang(i)+180);sind(sumang(i)+180);0];
    v1=inv(A)*bb;
    n1(i,:)=v1';
    b1(i,:)=cross(v1',t(i,:))';
end

mean(abs(acosd(sum(t.*n1,2))-90))



