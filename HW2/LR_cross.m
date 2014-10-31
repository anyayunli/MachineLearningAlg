function[cross_v]= LR_cross(X, Y,stepsize,lambda,TestX, TestY)

b=0.1;
% X is N*D, Y is N*1;
dim=size(X,2);% feature dimension D

w=zeros(dim,1);% weight initialization
trsize=size(X,1);%training sample size
testsize=size(TestX,1);%training sample size
w=[b;w];
X=[ones(trsize,1),X];
TestX=[ones(testsize,1),TestX];
%=0.001;% fix step size
M=eye(dim+1);
M(1,1)=0;
%hold on;
Y=ones-Y;
for i=1:50
    sig=sigmoid(X*w);
    grd=X'*(sig-Y)+2*lambda*M*w;
    w=w-stepsize*grd;
    
end
sig=sigmoid(TestX*w);
tmp=w;
tmp(1)=[];
%cross-entropy value
TestY=ones-TestY;
cross_v= -sum(TestY.*log(sig)+(1-TestY).*log(1-sig))+lambda*norm(tmp)^2;
   
end

