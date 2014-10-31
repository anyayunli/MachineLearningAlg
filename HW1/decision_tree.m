function[accuracy]= decision_tree(traindata, trainlab, newdata,newlab)


for num=1:10
dt=ClassificationTree.fit(traindata,trainlab, 'MinLeaf', num, 'Prune','off','SplitCriterion','deviance')
%view(dt,'Mode','Graph')
[predict_label] = predict(dt,newdata)


diff=predict_label-newlab;
predict_size=size(predict_label,1);

error=0;
for i=1:predict_size
    if(diff(i)~=0)
        error=error+1;
    end
end
accuracy(num)=1-error/predict_size;
end