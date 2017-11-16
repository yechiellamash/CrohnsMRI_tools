function centerlineExtractor2(V)

% global FlagDn;
FlagDn=0; %Flag for down press button
global isNormal;
global isAlt;
global pt_idx;
global cent;
global results_path;
global file_name;
global p;
global suffix;

pt_idx=0;
isNormal=0;
fh3=figure(3);
ic=round(size(V,3)/2);
ih3=imshow(V(:,:,ic),[]);

fh2=figure(2);
is=round(size(V,2)/2);
ih2=imshow(squeeze(V(:,is,:)),[]);

fh1=figure(1);
ia=round(size(V,1)/2);
ih1=imshow(squeeze(V(ia,:,:))',[]);

c0=mean(get(gca,'CLim'));
w0=diff(get(gca,'CLim'));

Win=[c0-w0/2,c0+w0/2];
global xyz;
xyz=[0,0,1];
cp = get(gca,'CurrentPoint');
xy0=cp(1,1:2);

cf=fh1;

set(fh1,'WindowButtonDownFcn',@start);
set(fh2,'WindowButtonDownFcn',@start);
set(fh3,'WindowButtonDownFcn',@start);

set(fh1,'WindowButtonUpFcn',@stp);
set(fh2,'WindowButtonUpFcn',@stp);
set(fh3,'WindowButtonUpFcn',@stp);

set(fh1,'WindowScrollWheelFcn',@setSlice2);
set(fh2,'WindowScrollWheelFcn',@setSlice2);
set(fh3,'WindowScrollWheelFcn',@setSlice2);

figure(3)
btn1 = uicontrol('Style', 'pushbutton', 'String', 'save',...
    'Position', [200 20 50 20],...
    'Callback', @saveCent); 
% 
% btn2 = uicontrol('Style', 'pushbutton', 'String', 'sagital',...
%     'Position', [280 20 50 20],...
%         'Callback', 'global xyz;xyz=[0,1,0];'); 
% %     'Callback', @set_axial); 
% btn3 = uicontrol('Style', 'pushbutton', 'String', 'axial',...
%     'Position', [360 20 50 20],...
%         'Callback','global xyz;xyz=[1,0,0];'); 
%     'Callback', @set_sagital); 

function start(src,evnt) %DnClick fig1
FlagDn=1;
cp = get(gca,'CurrentPoint');
xy0=cp(1,1:2);
    if strcmp(get(src,'SelectionType'),'normal')
%         set(fh,'WindowButtonMotionFcn',@setSlice1)  
        cp = get(gca,'CurrentPoint'); 
    if gcf==fh3
        p=[cp(1,1),cp(1,2),ic];    
    elseif gcf==fh2
        p=[is,cp(1,2),cp(1,1)];
    else
        p=[cp(1,1),ia,cp(1,2)];
    end
    isNormal=1;
    elseif strcmp(get(src,'SelectionType'),'extend')
        set(gcf,'WindowButtonMotionFcn',@win)
    elseif strcmp(get(src,'SelectionType'),'alt')
        isAlt=1;
        cp = get(gca,'CurrentPoint'); 
    if gcf==fh3
        p=[cp(1,1),cp(1,2),ic];    
    elseif gcf==fh2
        p=[is,cp(1,2),cp(1,1)];
    else
        p=[cp(1,1),ia,cp(1,2)];
    end
    pt_idx=pt_idx+1;
    cent(pt_idx,:)=p;
    end
end

function stp(src,evnt)
 FlagDn=0;
%     set(fh,'WindowButtonMotionFcn','')
          
    c0=mean(get(gca,'CLim'));
    w0=diff(get(gca,'CLim'));
%     if isNormal
    cp = get(gca,'CurrentPoint'); 
    if gcf==fh3
    is=round(cp(1,1));set(ih2,'Cdata',squeeze(V(:,is,:)));
    ia=round(cp(1,2));set(ih1,'Cdata',squeeze(V(ia,:,:))');
    figure(1);set(findobj(gca,'Type','line'),'Visible','off');hold on;plot(p(1,1),p(1,3),'r+');
    figure(2);set(findobj(gca,'Type','line'),'Visible','off');hold on;plot(p(1,3),p(1,2),'r+');
    figure(3);set(findobj(gca,'Type','line'),'Visible','off');hold on;plot(p(1,1),p(1,2),'r+');
    figure(3);
    elseif gcf==fh2
    ic=round(cp(1,1));set(ih3,'Cdata',squeeze(V(:,:,ic)));
    ia=round(cp(1,2));set(ih1,'Cdata',squeeze(V(ia,:,:))');
    figure(1);set(findobj(gca,'Type','line'),'Visible','off');hold on;plot(p(1,1),p(1,3),'r+');
    figure(3);set(findobj(gca,'Type','line'),'Visible','off');hold on;plot(p(1,1),p(1,2),'r+');
    figure(2);set(findobj(gca,'Type','line'),'Visible','off');hold on;plot(p(1,3),p(1,2),'r+');
    figure(2);
    else
    is=round(cp(1,1));set(ih2,'Cdata',squeeze(V(:,is,:)));
    ic=round(cp(1,2));set(ih3,'Cdata',squeeze(V(:,:,ic)));
    figure(3);set(findobj(gca,'Type','line'),'Visible','off');hold on;plot(p(1,1),p(1,2),'r+');
    figure(2);set(findobj(gca,'Type','line'),'Visible','off');hold on;plot(p(1,3),p(1,2),'r+');
    figure(1);set(findobj(gca,'Type','line'),'Visible','off');hold on;plot(p(1,1),p(1,3),'r+');
    figure(1);
    end
    isNormal=0;
%     end
end

function win(src,evnt)
        cp = get(gca,'CurrentPoint');          
        w=min(max(w0+(cp(1,1)-xy0(1)),0),900);
        c1=min(max(c0-(cp(1,2)-xy0(2)),0),900);
        wini=[c1-w/2,c1+w/2];
        if FlagDn
        title(['C: ',num2str(round((c1))),'   W: ', num2str(round(w))])
        set(gca,'CLim',wini)
        end
end
     
function setSlice1(src,evnt) %Vis. Cross

    
    
%     if FlagDn
%     cp = get(gca,'CurrentPoint');
%     xy1=cp(1,1:2);
%      if find(xyz)==3
%         ic=max([min([round((xy1(2)-xy0(2))/10)+ic,size(V,3)]),1]);
%         set(ih,'Cdata',V(:,:,ic));
%      elseif find(xyz)==2
%         is=max([min([round((xy1(2)-xy0(2))/10)+is,size(V,2)]),1]);
%         set(ih,'Cdata',squeeze(V(:,is,:)));
%      else
%         ia=max([min([round((xy1(2)-xy0(2))/10)+ia,size(V,1)]),1]);
%         set(ih,'Cdata',squeeze(V(ia,:,:))');
%      end
%     end
end

function setSlice2(src,evnt) %Vis. Cross 
   % global xyz;
     if gcf==fh3
        ic=max(min([ic+evnt.VerticalScrollCount,size(V,3)]),1);
        set(ih3,'Cdata',V(:,:,ic));
        set(findobj(gca,'Type','line'),'Visible','off');
        if pt_idx>0
        ind=find(cent(:,3)==ic);
        plot(cent(ind,1),cent(ind,2),'g.')
        end
     elseif gcf==fh2
        is=max(min([is+evnt.VerticalScrollCount,size(V,2)]),1);
        set(ih2,'Cdata',squeeze(V(:,is,:)));
        set(findobj(gca,'Type','line'),'Visible','off');
        if pt_idx>0
        ind=find(cent(:,1)==is);
        plot(cent(ind,2),cent(ind,3),'g.')
        end
     else
        ia=max(min([ia+evnt.VerticalScrollCount,size(V,1)]),1);
        set(ih1,'Cdata',squeeze(V(ia,:,:))');
        set(findobj(gca,'Type','line'),'Visible','off');
        if pt_idx>0
        ind=find(cent(:,2)==ia);
        plot(cent(ind,1),cent(ind,3),'g.')
        end
     end
end

function saveCent(src,evnt)
        mkdir(results_path);
        save([results_path,file_name,date,suffix],'cent')
end

end