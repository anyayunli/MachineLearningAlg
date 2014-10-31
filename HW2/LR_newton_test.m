function [wnorm, cross_v]=LR_newton_test(X,Y,stepsize,lambda, Xtest, Ytest)

b=0.1;
% X is N*D, Y is N*1;
dim=size(X,2);% feature dimension D
[n1,n2,w]=LR_gradient(X, Y,0.01,0.05,5);
%w=zeros(dim,1);% weight initialization
trsize=size(X,1);%training sample size
b=repmat(0.4438,trsize,1);
X_t=[ones(trsize,1),X];
w_t = [0.4438;w];
Y=ones-Y;
for i=1:50
    sig=sigmoid(X_t*w_t);
    S=diag(sig.*(1-sig));
    grd=X'*(sig-Y)+2*lambda*w;
    H=X'*S*X+2*diag(repmat(lambda,1,dim));
    w=w-pinv(H)*grd;
    b=b-pinv(sig'*(1-sig))*sum(sig-Y);
    w_t = [b(1,1);w];
end
Ytest=ones-Ytest;
wnorm=norm(w);
%cross-entropy value
sig=sigmoid(Xtest*w+b(1,1));
cross_v= -sum(Ytest.*log(sig)+(1-Ytest).*log(1-sig))+lambda*norm(w)^2;
   
end

