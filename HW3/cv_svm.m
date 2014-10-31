function [acc,time] = cv_svm(train_data, train_label)

%preprocess for cross validation
[N,D]=size(train_data);
XplusY=[train_data,train_label];
shuffedXY= XplusY(randperm(size(XplusY,1)),:);
shuffedX=shuffedXY(:,1:D);
shuffedY=shuffedXY(:,D+1);
div=N/5;

for cv=1:5 % 5-fold cross validation
    s=(cv-1)*div+1;
    ctest_data=shuffedX(s:s+div-1,:);
    ctest_label=shuffedY(s:s+div-1,:);
    if(s==1)
        ctrain_data=shuffedX(s+div:N,:);
        ctrain_label=shuffedY(s+div:N,:);
    elseif(s==N-div+1)
        ctrain_data=shuffedX(1:s-1,:);
        ctrain_label=shuffedY(1:s-1,:);
    else
        ctrain_data=[shuffedX(1:s-1,:);shuffedX(s+div:N,:)];
        ctrain_label=[shuffedY(1:s-1,:);shuffedY(s+div:N,:)];
    end
    %learn and predict
    C=[4^-6,4^-5,4^-4,4^-3,4^-2,4^-1,1,4,4^2];
    
    for i=1:9
        t = cputime;
        [w,b] = trainsvm(ctrain_data, ctrain_label, C(i));       
        acc(cv,i) = testsvm(ctest_data, ctest_label, w, b); 
        e = cputime-t;
        time(cv,i)=e;
    end
end

end
