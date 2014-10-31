% logistic regression gradient descent
function[wnorm, cross_v, w]= LR_gradient(X, Y,stepsize,lambda,itr)

b=0.1;
% X is N*D, Y is N*1;
dim=size(X,2);% feature dimension D

w=zeros(dim,1);% weight initialization
trsize=size(X,1);%training sample size
w=[b;w];
X=[ones(trsize,1),X];
%=0.001;% fix step size
M=eye(dim+1);
M(1,1)=0;
%hold on;
Y=ones-Y;
for i=1:itr
    sig=sigmoid(X*w);
    grd=X'*(sig-Y)+2*lambda*M*w;
    w=w-stepsize*grd;
    %cross-entropy value
    tmp=w;
    tmp(1)=[];
    cross_v(i,1)= -sum(Y.*log(sig)+(1-Y).*log(1-sig))+lambda*norm(tmp)^2;
    %plot(cross_v);
    %hold on;
end

w(1)=[];
wnorm=norm(w);

end

