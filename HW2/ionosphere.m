function[X, Y]=ionosphere(path, flag)
%clear
fid=fopen(path);
c=textscan(fid,'%s')
if(flag==1)
    size=269;
else
    size=82;
end
for i=1:size
    tmp=strsplit(c{1,1}{i,1},',');
    X(i,:)=cellfun(@str2num, tmp(1:34));
    if(strcmp('b',tmp(35)))
        Y(i,1)=0;
    else
        Y(i,1)=1;
    end
end

end