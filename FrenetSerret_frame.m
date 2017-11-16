function [t,n,b]=FrenetSerret_frame(xyz3,draw)
% extract local axis system [t,n,b] along the curve xyz3
% smooth the tangenet vector t and n
% Yechiel Lamash, 2017
replicate_borders=0;win=41;
sg.ord=3;
sg.framelen=41;

t=diff(xyz3,1);
sz=size(t,1);
if replicate_borders
t=[t(win:-1:1,:);t;t(end:-1:end-win+1,:)];
end
t1=sgolayfilt(t,sg.ord,sg.framelen,[],1);
t=t./repmat(sqrt(sum(t.^2,2)),[1,3]);
t1=t1./repmat(sqrt(sum(t1.^2,2)),[1,3]);
if replicate_borders
t1=t1(win+1:win+sz,:);
t=t(win+1:win+sz,:);
end

n=diff(t1);
n=[n(1,:);n];
if replicate_borders
n=[n(win:-1:1,:);n;n(end:-1:end-win+1,:)];
end
n1=sgolayfilt(n,sg.ord,sg.framelen,[],1);

n=n./repmat(sqrt(sum(n.^2,2)),[1,3]);
n1=n1./repmat(sqrt(sum(n1.^2,2)),[1,3]);
if replicate_borders
n1=n1(win+1:win+sz,:);
n=n(win+1:win+sz,:);
end

b=cross(t,n);
b=b./repmat(sqrt(sum(b.^2,2)),[1,3]);

b1=cross(t1,n1);
b1=b1./repmat(sqrt(sum(b1.^2,2)),[1,3]);

if draw
figure(2);
subplot 311;plot(t(:,1))
subplot 312;plot(t(:,2))
subplot 313;plot(t(:,3))
subplot 311;hold on;plot(t1(:,1),'r')
subplot 312;hold on;plot(t1(:,2),'r')
subplot 313;hold on;plot(t1(:,3),'r')
% n=n./repmat(sqrt(sum(n.^2,2)),[1,3]);
figure(3);
subplot 311;plot(n(:,1))
subplot 312;plot(n(:,2))
subplot 313;plot(n(:,3))
subplot 311;hold on;plot(n1(:,1),'r')
subplot 312;hold on;plot(n1(:,2),'r')
subplot 313;hold on;plot(n1(:,3),'r')
figure(4);
subplot 311;plot(b(:,1));hold on;plot(b1(:,1),'r')
subplot 312;plot(b(:,2));hold on;plot(b1(:,2),'r')
subplot 313;plot(b(:,3));hold on;plot(b1(:,3),'r')
end

do_filtering=0;
if do_filtering
b=b1;
n=n1;
t=t1;
end

mean(abs(acosd(sum(t.*n,2))-90))