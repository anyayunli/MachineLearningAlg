function [] = CSCI567_hw3()
% quadprog implementation of svm
[train_data, train_label,test_data, test_label]=preprocess();

[acc,time] = cv_svm(train_data, train_label);
avg_acc=mean(acc);
avg_time=mean(time);

c=4^-4;
[w,b] = trainsvm(train_data, train_label, 4^-4);       
acc = testsvm(test_data, test_label, w, b);
display('my svm implementation, test accuracy');
display(acc);

%libsvm
libacc=libsvm_train(train_data, train_label,test_data, test_label);

end