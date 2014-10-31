function[]=CSCI567_hw2()

[Xi,Yi]=ionosphere('C:\School Work\CSCI 567\HW2\hw2_data\ionosphere\ionosphere_train.dat',1);
[XiTest,YiTest]=ionosphere('C:\School Work\CSCI 567\HW2\hw2_data\ionosphere\ionosphere_test.dat',0);

[Xs,Ys]=spam('C:\School Work\CSCI 567\HW2\hw2_data\spam\train\spam\', 'C:\School Work\CSCI 567\HW2\hw2_data\spam\train\ham\');
[XsTest,YsTest]=spam('C:\School Work\CSCI 567\HW2\hw2_data\spam\test\spam\', 'C:\School Work\CSCI 567\HW2\hw2_data\spam\test\ham\');

stepsize=[0.001,0.01,0.05,0.1,0.5];
lambda=[0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5];
lineStyle=['k','g','r','b','c','m','y','w','*','r','y'];

%---------------------Newton--------------------------------------------------------
display('--------------------------------------Newton--------------------------');

for i=1:size(lambda,2)
[Iw,Ic(i,1)]=LR_newton_test(Xi,Yi,0.01,lambda(i), XiTest, YiTest);
[Sw,Sc(i,1)]=LR_newton_test(Xs,Ys,0.01,lambda(i), XsTest, YsTest);
end
display('5.7.c, cross entropy value for test data');
display('Ionosphere');
display(Ic');
display('Spam/ham');
display(Sc');


figure();
for i=1:size(lambda,2)
[wnorm(i,1), cross_v]=LR_newton(Xi,Yi,0.01,lambda(i));
plot(1:50,cross_v, lineStyle(i));
title('5.3.7, ionosphere dataset');
legend('lambda = 0','lambda = 0.05','lambda = 0.1','lambda = 0.15','lambda = 0.2','lambda = 0.25','lambda = 0.3','lambda = 0.35','lambda = 0.4','lambda = 0.45','lambda = 0.5','Location','northeastoutside');
xlabel('num of iterations');
ylabel('cross entropy');
hold on;
end
display('5.7.b L2 norm of w after 50 iterations, inosphere dataset');
display(wnorm');


figure();
for i=1:size(lambda,2)
[wnorm(i,1), cross_v]=LR_newton(Xs,Ys,0.01,lambda(i));
plot(1:50,cross_v, lineStyle(i));
title('5.3.7, spam/ham dataset');
legend('lambda = 0','lambda = 0.05','lambda = 0.1','lambda = 0.15','lambda = 0.2','lambda = 0.25','lambda = 0.3','lambda = 0.35','lambda = 0.4','lambda = 0.45','lambda = 0.5','Location','northeastoutside');
xlabel('num of iterations');
ylabel('cross entropy');
hold on;
end
display('5.7.b L2 norm of w after 50 iterations, SPAM/HAM dataset');
display(wnorm');


%5.6 test data
[Iw,Ic]=LR_newton_test(Xi,Yi,0.01,0, XiTest, YiTest);
[Sw,Sc]=LR_newton_test(Xs,Ys,0.01,0, XsTest, YsTest);
display('5.6.c, cross entropy value for test data');
display('Ionosphere');
display(Ic');
display('Spam/ham');
display(Sc');


%5.6.a
figure();
[Inorm, cross_v]=LR_newton(Xi,Yi,0.01,0);
plot(1:50,cross_v, lineStyle(1));
title('5.3.6, ionosphere dataset');
legend('lambda = 0','lambda = 0.05','lambda = 0.1','lambda = 0.15','lambda = 0.2','lambda = 0.25','lambda = 0.3','lambda = 0.35','lambda = 0.4','lambda = 0.45','lambda = 0.5','Location','northoutside');
xlabel('num of iterations');
ylabel('cross entropy');
hold on;
display('5.6.b L2 norm of w after 50 iterations, ionosphere dataset');
display(Inorm');

figure();
[Snorm, cross_v]=LR_newton(Xs,Ys,0.01,0);
plot(1:50,cross_v, lineStyle(1));
title('5.3.6, spam/ham dataset');
legend('lambda = 0','lambda = 0.05','lambda = 0.1','lambda = 0.15','lambda = 0.2','lambda = 0.25','lambda = 0.3','lambda = 0.35','lambda = 0.4','lambda = 0.45','lambda = 0.5','Location','northoutside');
xlabel('num of iterations');
ylabel('cross entropy');
hold on;

display('5.b.a L2 norm of w after 50 iterations, spam/ham dataset');
display(Snorm');

%----------------------------------Gradient Descent-----------------------------------
%5.3.(4)c, plot for each lambda, stepsize
display('--------------------------------------for Gradient Descent--------------------------');
for i=1:size(stepsize,2)
    figure();
    for j=1:size(lambda,2)
    Icross_tr(j,1)= LR_cross(Xi, Yi,stepsize(i),lambda(j),Xi, Yi);
    Icross_te(j,1)= LR_cross(Xi, Yi,stepsize(i),lambda(j),XiTest, YiTest);
    end
    plot(lambda,Icross_tr,lineStyle(1),lambda,Icross_te,lineStyle(2) );
    hold on;
    title('5.3.4, inosphere dataset');
    legend('ionosphere training data','ionosphere test data');
    xlabel('lambda');
    ylabel('cross entropy');
end

for i=1:size(stepsize,2)
    figure();
    for j=1:size(lambda,2)
    Scross_tr(j,1)= LR_cross(Xs, Ys,stepsize(i),lambda(j),Xs, Ys);
    Scross_te(j,1)= LR_cross(Xs, Ys,stepsize(i),lambda(j),XsTest, YsTest);
    end
    plot(lambda,Scross_tr,lineStyle(1),lambda,Scross_te,lineStyle(2) );
    hold on;
    title('5.3.4, ham/spam dataset');
    legend('ham/spam training data','ham/spam test data');
    xlabel('lambda');
    ylabel('cross entropy');
end


% 5.3.(3) norm and plot without regularization---for ionosphere dataset
figure();
for i=1:size(stepsize,2)
[Inorm(i,1), Icross]= LR_gradient(Xi, Yi,stepsize(i),0,50);
plot(1:50,Icross, lineStyle(i));
title('5.3.3, inosphere dataset');
legend('stepsize = 0.001','stepsize = 0.01','stepsize = 0.05','stepsize = 0.1','stepsize = 0.5');
xlabel('num of iterations');
ylabel('cross entropy');
hold on;
end
display('5.3.3 L2 norm of w after 50 iterations without lambda, ionosphere dataset');
display(Inorm');

% 5.3.(3) norm and plot without regularization---for spam/ham dataset
figure()
for i=1:size(stepsize,2)
[Snorm(i,1), Scross]= LR_gradient(Xs, Ys,stepsize(i),0,50);
plot(1:50,Scross, lineStyle(i));
title('5.3.3, spam/ham dataset');
legend('stepsize = 0.001','stepsize = 0.01','stepsize = 0.05','stepsize = 0.1','stepsize = 0.5');
xlabel('num of iterations');
ylabel('cross entropy');
hold on;
end
display('5.3.3 L2 norm of w after 50 iterations without lambda, spam/ham dataset');
display(Snorm');

%5.3.(4).a  plot with lambda=0.1---for ionosphere dataset
figure();

for i=1:size(stepsize,2)
[Inorm(i,1), Icross]= LR_gradient(Xi, Yi,stepsize(i),0.1,50);
plot(1:50,Icross, lineStyle(i));
title('5.3.4, lambda=0.1, inosphere dataset');
legend('stepsize = 0.001','stepsize = 0.01','stepsize = 0.05','stepsize = 0.1','stepsize = 0.5');
xlabel('num of iterations');
ylabel('cross entropy');
hold on;
end

% 5.3.(4)a plot with lambda=0.1---for spam/ham dataset
figure()
for i=1:size(stepsize,2)
[Snorm(i,1), Scross]= LR_gradient(Xs, Ys,stepsize(i),0.1,50);
plot(1:50,Scross, lineStyle(i));
title('5.3.4, lambda=0.1, spam/ham dataset');
legend('stepsize = 0.001','stepsize = 0.01','stepsize = 0.05','stepsize = 0.1','stepsize = 0.5');
xlabel('num of iterations');
ylabel('cross entropy');
hold on;
end

%5.3.(4)b L2 norm, for each lambda
for i=1:size(lambda,2)
[Inorm(i,1), Icross]= LR_gradient(Xi, Yi,0.01,lambda(i),50);
[Snorm(i,1), Scross]= LR_gradient(Xs, Ys,0.01,lambda(i),50);
end

display('5.3.4b, L2 norm for test data, with different lambda');
display('Ionosphere');
display(Inorm');
display('Spam/ham');
display(Snorm');

end