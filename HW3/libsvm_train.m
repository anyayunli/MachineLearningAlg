function [testacc]= libsvm_train(trdata,trlabel,tedata,telabel)
%libsvm

addpath('C:\School Work\CSCI 567\HW3\libsvm-3.18\libsvm-3.18\matlab');

C1=[4^-6,4^-5,4^-4,4^-3,4^-2,4^-1,1,4,4^2];
C2=[4^-4,4^-3,4^-2,4^-1,1,4,4^2,4^3,4^4,4^5,4^6,4^7];
d=[1,2,3];
g=[4^-7,4^-6,4^-5,4^-4,4^-3,4^-2,4^-1];
for i=1:9
    %4.4 linear
    cmd_l=['-t 0 -q -v 5 -c ', num2str(C1(i))];
    t = cputime;
    acc_l(i) = round(svmtrain(trlabel, trdata, cmd_l)*10000)/1000000;
    time_l(i) = cputime-t;
end    

for i=1:12
    %4.5 polynomial
    for j=1:3
    cmd_p=['-t 1 -q -v 5 -c ', num2str(C2(i)),' -d ',num2str(d(j))];
    t = cputime;
    acc_p(j,i) = svmtrain(trlabel, trdata, cmd_p)/100;
    time_p(j,i) = cputime-t;
    end
    
    for j=1:7
    %4.5 rbf
    cmd_r=['-t 2 -q -v 5 -c ', num2str(C2(i)),' -g ',num2str(g(j))];
    t = cputime;
    acc_r(j,i) = svmtrain(trlabel, trdata, cmd_r)/100;
    time_r(j,i) = cputime-t;
    
    end
end
     cmd=['-t 2 -q -c ', num2str(4),' -g ',num2str(4^-3)];
     model=svmtrain(trlabel, trdata, cmd);
     display('libsvm rbf kernel, test data accuracy');
    [no,testacc,no]=svmpredict(telabel, tedata, model);
end


