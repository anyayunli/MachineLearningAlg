function accu = testsvm(test_data, test_label, w, b)
% Test linear SVM 
% Input:
%  test_data: M*D matrix, each row as a sample and each column as a
%  feature
%  test_label: M*1 vector, each row as a label
%  w: feature vector 
%  b: bias term
%
% Output:
%  accu: test accuracy (between [0, 1])
%
% CSCI 576 2014 Fall, Homework 3
[N,D]=size(test_data);
for k=1:N
    if(test_data(k,:)*w+b>0)
        predict_y(k)=1;
    else
        predict_y(k)=-1;
    end
end

accu=1-nnz(predict_y'-test_label)/size(test_label,1);

end