function [pc,dst]=project_on_plane(c,pln,v0)
%input:
% c: curve in 3d
% pln: plane eq [a,b,c,d]
% v0: vector of interest
%output:
% pc: projection of curve on plane
% dst: distances of curve from plane
%
    for i=1:size(c,2)
        %distance from curve to plane
         dst(i)=(-pln(4)-dot(c(:,i),pln(1:3)'))/dot(v0,pln(1:3)');
         pc(:,i)=c(:,i)+dst(i)*v0;% point on plane by projecting in direction v0
    end