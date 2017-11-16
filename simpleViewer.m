function simpleViewer(V)

% global FlagDn;
FlagDn=0; %Flag for down press button

fh=figure;
ic=round(size(V,3)/2);
is=round(size(V,2)/2);
ia=round(size(V,1)/2);

ih=imshow(V(:,:,ic),[]);
c0=mean(get(gca,'CLim'));
w0=diff(get(gca,'CLim'));

Win=[c0-w0/2,c0+w0/2];
FlagDn=0;
% c0=mean(Win,2);w0=diff(Win);

global xyz;
xyz=[0,0,1];
cp = get(gca,'CurrentPoint');
xy0=cp(1,1:2);

set(fh,'WindowButtonDownFcn',@start);
set(fh,'WindowButtonUpFcn',@stp);
set(fh,'WindowScrollWheelFcn',@setSlice2);

btn1 = uicontrol('Style', 'pushbutton', 'String', 'coronal',...
    'Position', [200 20 50 20],...
        'Callback', 'global xyz;xyz=[0,0,1];'); 
%     'Callback', @set_coronal); 

btn2 = uicontrol('Style', 'pushbutton', 'String', 'sagital',...
    'Position', [280 20 50 20],...
        'Callback', 'global xyz;xyz=[0,1,0];'); 
%     'Callback', @set_axial); 
btn3 = uicontrol('Style', 'pushbutton', 'String', 'axial',...
    'Position', [360 20 50 20],...
        'Callback','global xyz;xyz=[1,0,0];'); 
%     'Callback', @set_sagital); 

function start(src,evnt) %DnClick fig1
FlagDn=1;
cp = get(gca,'CurrentPoint');
xy0=cp(1,1:2);
    if strcmp(get(src,'SelectionType'),'normal')
        set(fh,'WindowButtonMotionFcn',@setSlice1)           
    elseif strcmp(get(src,'SelectionType'),'extend')
        set(fh,'WindowButtonMotionFcn',@win)
    end
end

function stp(src,evnt)
 FlagDn=0;
    set(fh,'WindowButtonMotionFcn','')
          
    c0=mean(get(gca,'CLim'));
    w0=diff(get(gca,'CLim'));
end

function win(src,evnt)
        cp = get(gca,'CurrentPoint');          
        w=min(max(w0+(cp(1,1)-xy0(1)),0),700);
        c1=min(max(c0-(cp(1,2)-xy0(2)),0),700);
        wini=[c1-w/2,c1+w/2];
        if FlagDn
        title(['C: ',num2str(round((c1))),'   W: ', num2str(round(w))])
        set(gca,'CLim',wini)
        end
end
     
function setSlice1(src,evnt) %Vis. Cross
    if FlagDn
    cp = get(gca,'CurrentPoint');
    xy1=cp(1,1:2);
     if find(xyz)==3
        ic=max([min([round((xy1(2)-xy0(2))/10)+ic,size(V,3)]),1]);
        set(ih,'Cdata',V(:,:,ic));
     elseif find(xyz)==2
        is=max([min([round((xy1(2)-xy0(2))/10)+is,size(V,2)]),1]);
        set(ih,'Cdata',squeeze(V(:,is,:)));
     else
        ia=max([min([round((xy1(2)-xy0(2))/10)+ia,size(V,1)]),1]);
        set(ih,'Cdata',squeeze(V(ia,:,:))');
     end
    end
end

function setSlice2(src,evnt) %Vis. Cross 
   % global xyz;
     if find(xyz)==3
        ic=max(min([ic+evnt.VerticalScrollCount,size(V,3)]),1);
        set(ih,'Cdata',V(:,:,ic));
     elseif find(xyz)==2
        is=max(min([is+evnt.VerticalScrollCount,size(V,2)]),1);
        set(ih,'Cdata',squeeze(V(:,is,:)));
     else
        ia=max(min([ia+evnt.VerticalScrollCount,size(V,1)]),1);
        set(ih,'Cdata',squeeze(V(ia,:,:))');
     end
end

end