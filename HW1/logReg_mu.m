function[accuracy]= logReg_mu(traindata, trainlab, newdata,newlab)
B = mnrfit(traindata,trainlab)

for i=1:size(newdata, 1)
    pihat=mnrval(B, newdata(i,:));
    [no(i), idx(i)]=max(pihat);
end

predict_label=idx'
diff=predict_label-newlab;
predict_size=size(predict_label,1);
error=0;
for i=1:predict_size
    if(diff(i)~=0)
        error=error+1;
    end
end
accuracy=1-error/predict_size;
end