function [new_accu, train_accu] = knn_classify(train_data, train_label, new_data, new_label, k)
%[D,I] = pdist2(train_data,train_label,'Smallest',k)
[trow, tcol]=size(train_data);
[nrow, ncol]=size(new_data);

for i = 1:nrow
    for j=1:trow
        distance(i,j)=norm(new_data(i,:)-train_data(j,:));
    end
end

for i = 1:trow
    for j=1:trow
        if(i==j)
            distance_t(i,j)=1000000000000000;
        else
            distance_t(i,j)=norm(train_data(i,:)-train_data(j,:));
        end
    end
end

%for new data accuracy
for i= 1:nrow
    label_count(1:1,1:100)=0.0;% related to num of features
    [sortedValues,sortIndex] = sort(distance(i,:),'ascend')
    MinIndex(1:k) = sortIndex(1:k); %get index of the smallest k distances for new_data entry i 
        
    for m=1:k %count the frequency of labels among the k smallest distances
        index=MinIndex(m);
        label=train_label(index);         
        label_count(label)=label_count(label)+1;
    end    
    [L, I]=max(label_count);
    predict_label(i)=I;
    
end


diff=predict_label-new_label';
predict_size=size(predict_label,2);
%disp(predict_size);
error=0;
for i=1:predict_size
    if(diff(i)~=0)
        error=error+1;
    end
end
new_accu=1-error/predict_size;


%for train accuracy
prodict_label=0;
for i= 1:trow
    label_count(1:1,1:100)=0.0;% related to num of features
    [sortedValues,sortIndex] = sort(distance_t(i,:),'ascend')
    MinIndex(1:k) = sortIndex(1:k); %get index of the smallest k distances for new_data entry i 
        
    for m=1:k %count the frequency of labels among the k smallest distances
        index=MinIndex(m);
        label=train_label(index);         
        label_count(label)=label_count(label)+1;
    end    
    [L, I]=max(label_count);
    predict_label(i)=I;
    
end


diff=predict_label-train_label';
predict_size=size(predict_label,2);
%disp(predict_size);
error=0;
for i=1:predict_size
    if(diff(i)~=0)
        error=error+1;
    end
end
train_accu=1-error/predict_size;


% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  k: number of nearest neighbors
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
%
% CSCI 567 2014 Fall, Homework 1


