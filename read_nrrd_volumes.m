function [X,meta,fname]=read_nrrd_volumes(datapath,identifier)
% the function gets datapath to a nrrd study dir and an identifier ward in the dir name 
% and returns the volumes and metadata
% for example: identifier='POST' returns the post contrast volumes.
% Yechiel Lamash, 2017

jj=0;
d2=dir(datapath);
for j=3:size(d2,1)
    inds=ismember(d2(j).name,identifier);
    inds2=conv(single(inds),ones(1,length(identifier)));
    inds2=inds2(length(identifier):end)==length(identifier);
    if sum(inds2,2)>=1
% if sum(inds,2)==length(identifier)&&prod(diff(find(inds)))==1
    jj=jj+1;
     d3=dir([datapath,d2(j).name,'/*.nrrd']);
    [X{jj}, meta{jj}] = nrrdread([datapath,d2(j).name,'/',d3(1).name]);
    fname{jj}=d2(j).name;
end
end