function [trdata,trlabel,tedata,telabel]=preprocess()
clear
train=load('C:\School Work\CSCI 567\HW3\splice_train.mat');
test=load('C:\School Work\CSCI 567\HW3\splice_test.mat');

[trsize,fdim]=size(train.data);
[tesize,fdim]=size(test.data);

trmean=mean(train.data);
trstd=std(train.data);

for i=1:trsize
    trdata(i,:)=(train.data(i,:)-trmean)./trstd;
end

for i=1:tesize
    tedata(i,:)=(test.data(i,:)-trmean)./trstd;
end

trlabel=train.label;
telabel=test.label;

end