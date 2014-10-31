function[X,Y]=spam(spampath, hampath); 
%clear;
fid = fopen('C:\School Work\CSCI 567\HW2\hw2_data\spam\vocab.dat');
tline = fgets(fid);
dict={};
while ischar(tline)
    dict = [dict;cellstr(tline)];
    tline = fgets(fid);
end;
fclose(fid);
num_vocab = length(dict);

dir_current = {spampath, hampath};
for round=1:length(dir_current)
    filelist = dir(char(dir_current(round)));
    file_num = length(filelist);

    for i=1:file_num
        counts = zeros(num_vocab,1);
        if filelist(i,1).isdir==0
            fileID = fopen(strcat(char(dir_current(round)), filelist(i,1).name));
            input = fread(fileID,'*char')';
            fclose(fileID);
            [m,matches] = strsplit(input,{',','.','?','\n','\r',' ','\t'},'CollapseDelimiters',true);
             m=lower(m);
            for j=1:num_vocab
                counts(j,1) = counts(j,1) + nnz(strcmp(m, dict(j,1)));
            end
            if(round==1)
                X(i,:)=counts;
                Y(i,1)=0;
            else
                X(i+125,:)=counts;
                Y(i+125,1)=1;
            end
        end
        
    end
end

[rank,ind] = sort(counts, 'descend');
rst = dict(ind);

end