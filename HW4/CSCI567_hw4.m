function[]=CSCI567_hw4()

lineStyle=cellstr(['r.';'g.';'y.';'b.';'c.';'m-';'c-';'b-';'g-';'r-';'y-']);
carray=csvread('2DGaussian.csv',1,0);
data1=carray(:,2:3);

% 5.2b
%figure();
for i=1:5
    [~,J(i,:),~]=kmeans(4,data1,2,0);
    plot(1:50,J(i,:),lineStyle{5+i});
    hold on;
end   
title('5.2b, K-means distortion measure, K=4');

%5.2 a
K1=[2,3,5];
figure();
[output,~,~]=kmeans(K1(1),data1,2,1);
for i=1:500
        plot(output(i,1),output(i,2),lineStyle{int64(output(i,3))});
        hold on;
end
title('5.2a K-means clusters, K=2');

figure();
[output,~,~]=kmeans(K1(2),data1,2,1);
for i=1:500
        plot(output(i,1),output(i,2),lineStyle{int64(output(i,3))});
        hold on;
end
title('5.2a K-means clusters, K=3');

figure();
[output,~,~]=kmeans(K1(3),data1,2,1);
for i=1:500
        plot(output(i,1),output(i,2),lineStyle{int64(output(i,3))});
        hold on;
end
title('5.2a K-means clusters, K=5');




%5.3
K3=[3,8,15];
figure();
img1=VQ(K3(1));
image(img1);
title('5.3 Vector Quantization using k-means, K=3');

figure();
img2=VQ(K3(2));
image(img2);
title('5.3 Vector Quantization using k-means, K=8');

figure();
img3=VQ(K3(3));
image(img3);
title('5.3 Vector Quantization using k-means, K=15');