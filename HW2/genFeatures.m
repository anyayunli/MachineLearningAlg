function[]=genFeatures()

spamaddr='C:\School Work\CSCI 567\HW2\hw2_data\spam\train\spam\';
spamflist=dir(spamaddr);
hamaddr='C:\School Work\CSCI 567\HW2\hw2_data\spam\train\ham\';
hamflist=dir(hamaddr);

fid = fopen('C:\School Work\CSCI 567\HW2\hw2_data\spam\vocab.dat');
tline = fgets(fid);
dict={};
while ischar(tline)
    dict = [dict;cellstr(tline)];
    tline = fgets(fid);
end;
fclose(fid);
num_vocab = length(dict);
counts = zeros(num_vocab,1);


for i =3:numel(spamflist)
    %disp(spam);
    fname=strcat(spamaddr, spamflist(i).name);
    %words=textread(fname, '%s','delimiter', '.?,','whitespace', '');
    input = fread(fileID,'*char')';
    display(words);
   
end
