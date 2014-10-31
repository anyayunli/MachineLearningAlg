function [optC_l,testacc_l,optC_r,optG_r,testacc_r] = cv_svm(X, subsetid,Y,d)
addpath('.\libsvm-3.18\libsvm-3.18\matlab');
%parameters
C=[4^-10,4^-9,4^-8,4^-7,4^-6,4^-5,4^-4,4^-3,4^-2,4^-1,1,4,4^2,4^3,4^4,4^5,4^6,4^7,4^8,4^9,4^10,4^11,4^12];
g=[4^-10,4^-9,4^-8,4^-7,4^-6,4^-5,4^-4];
%preprocess for leave-one-out
data=sortrows([X,subsetid,Y],d+1);
data= arrayfun(@(x) data(data(:,d+1) == x, :), unique(data(:,d+1)), 'uniformoutput', false)

store1=data;
for cv=1:5 % 5-fold leave one out
    data=store1;
    testdata=data{cv}(:,1:d);
    testlabel=data{cv}(:,d+2);
    data{cv}=[];
    data=data(~cellfun('isempty',data));%left are training data
   
    store2=data;
    %acc=zeros(4,size(C,2));
     %-----------------------KBF Kernel SVM------------------------------
   acc=[];
   for k=1:size(g,2)
       for j=1:size(C,2) %tune C,linear svm
           for i=1:4
               data=store2;
               validdata=data{i}(:,1:d);
               validlabel=data{i}(:,d+2);
               data{i}=[];
               data=data(~cellfun('isempty',data));
               data=cell2mat(data);
               traindata=data(:,1:d);
               trainlabel=data(:,d+2);
              
               cmd_r=['-t 2 -q -c ', num2str(C(j)),' -g ',num2str(g(k))];                           
               model=svmtrain(trainlabel, traindata, cmd_r);
               [~,tt,~]=svmpredict(validlabel, validdata, model);
               vld(i,1)=tt(1);
           end%inner loop, train,valid and tune;           
           acc(j,k)=sum(vld)/4;
       end % tune c
   end % tune g
   [row,col] = find(acc == max(acc(:)));
   rowindex=row(1);
   colindex=col(1);       
   optC_r(cv,1)=C(rowindex);
   optG_r(cv,1)=C(colindex);
   data=cell2mat(store2);
   traindata=data(:,1:d);
   trainlabel=data(:,d+2);
   cmd_r=['-t 2 -q -c ', num2str(optC_r(cv,1)),' -g ',num2str(optG_r(cv,1))];                           
   model=svmtrain(trainlabel, traindata, cmd_r);
   [~,tt,~]=svmpredict(testlabel, testdata, model);
   testacc_r(cv,1)=tt(1);

    %-------------------------------linear svm---------------------------
    acc=[];
    for j=1:size(C,2) %tune C,linear svm
        for i=1:4
            data=store2;           
            validdata=data{i}(:,1:d);            
            validlabel=data{i}(:,d+2);            
            data{i}=[];
            data=data(~cellfun('isempty',data));
            data=cell2mat(data);
            traindata=data(:,1:d);
            trainlabel=data(:,d+2);
            
            cmd_l=['-t 0 -q -c ', num2str(C(j))];
            model = svmtrain(trainlabel, traindata, cmd_l);
            [~,tt,~]=svmpredict(validlabel, validdata, model);
            acc(i,j)=tt(1);
           
        end%inner loop, train,valid and tune;
    end % tune c
    [~,maxindex]=max(sum(acc));
    optC_l(cv,1)=C(maxindex);
    data=cell2mat(store2);
    traindata=data(:,1:d);
    trainlabel=data(:,d+2);
    cmd_l=['-t 0 -q -c ', num2str(optC_l(cv,1))];
    model = svmtrain(trainlabel, traindata, cmd_l);
    [~,tt,~]=svmpredict(testlabel, testdata, model);
    testacc_l(cv,1)=tt(1);
end
   

    

  
%end % 5-fold leave-one-out