function [new_accu, train_accu] = naive_bayes(train_data, train_label, new_data, new_label)

[trow,tcol]=size(train_data);
[nrow,ncol]=size(new_data);

[ldim,no]=size(unique(train_label));%label dimen
fdim=tcol;%feature dimen

for i=1:ldim
    Label(:,i)=(train_label==i);
end

Plabel=sum(Label)/sum(sum(Label));

feature_label_c(1:fdim,1:ldim)=0;
for i=1:fdim
    for j=1:ldim
        temp=times(train_data(:,i), Label(:,j));
        for m=1:size(temp)
            if(temp(m)==1)
                feature_label_c(i,j)=feature_label_c(i,j)+1;
            end
        end        
    end
end

for i=1:fdim
    for j=1:ldim
         sum_l=sum(feature_label_c);
        if(sum_l(1,j)~=0)
            prob=feature_label_c(i,j)/sum_l(1,j);
        else
            prob=0;
        end
        if(prob==0)
           feature_label_p(i,j)=log(0.0000001);
        else
           feature_label_p(i,j)=log(prob);
        end
    end
end
%predict new data
predict_label(1:nrow,1)=0;

for i=1:nrow %each new data observation
    for l=1:ldim % per each label
         p(i,l)=0;
        for f=1:fdim % per each feature
            if(new_data(i,f)==1)  % ith observation's fth feature          
            p(i,l)=p(i,l)+feature_label_p(f,l);
            end
        end
        p(i,l)=p(i,l)+log(Plabel(l))
    end
    [Value,predict_label(i,1)]=max(p(i,:))
    
    %disp(p)
end

diff=predict_label-new_label;
%disp(diff)
predict_size=size(predict_label,1);
%disp(predict_size);
error=0;
for i=1:predict_size
    if(diff(i)~=0)
        error=error+1;
    end
end
new_accu=1-error/predict_size;

%predict train accuracy
predict_label(1:nrow,1)=0;

for i=1:trow %each train data observation
    for l=1:ldim % per each label
         p(i,l)=0;
        for f=1:fdim % per each feature
            if(train_data(i,f)==1)  % ith observation's fth feature          
            p(i,l)=p(i,l)+feature_label_p(f,l);
            end
        end
        p(i,l)=p(i,l)+log(Plabel(l))
    end
    [Value,predict_label(i,1)]=max(p(i,:))
    
    %disp(p)
end

diff=predict_label-train_label;
%disp(diff)
predict_size=size(predict_label,1);
%disp(predict_size);
error=0;
for i=1:predict_size
    if(diff(i)~=0)
        error=error+1;
    end
end
train_accu=1-error/predict_size;
    


% naive bayes classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data 
%
% CSCI 567 2014 Fall, Homework 1