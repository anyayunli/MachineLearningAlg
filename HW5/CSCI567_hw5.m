function[]  = CSCI567_hw5()
[X,SubID,Y,hmmData,tranp,emip] =preprocess();

%5 HMM Bonus
[ae,ee]= baumwelch(hmmData, tranp, emip, 500);
[ae2,ee2]= hmmtrain(hmmData, tranp, emip);

display('emission estimate of baumwelch:');
display(ee);
display('emission estimate of hmmtrain:');
display(ee2);
display('transition estimate of baumwelch:');
display(ae);
display('transition estimate of hmmtrain:');
display(ae2);

%4.d classification
d=[20,50,100,200]
for i=1:4
    egVec=pca_fun(X, d(i));
    proj_X=X*egVec;
    
    [optC_l(:,i),testacc_l(:,i),optC_r(:,i),optG_r(:,i),testacc_r(:,i)]=cv_svm(proj_X, SubID,Y,d(i));
end

display('optimal c for linear svm:');
display(optC_l);
display('test accuracy for linear svm:');
display(sum(testacc_l)/5);
display('optimal c for rbf svm:');
display(optC_r);
display('optimal g for rbf svm:');
display(optG_r);
display('test accuracy for rbf svm:');
display(sum(testacc_r)/5);

%4.c eigenfaces
egVec=pca_fun(X, 5);

for i=1:5
    figure();
    tmp=reshape(egVec(:,i),[50,50]);
    imshow(tmp,[]);
end





