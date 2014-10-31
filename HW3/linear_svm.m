function [acc, time]=linear_svm(X, Y)

C=[4^-6,4^-5,4^-4,4^-3,4^-2,4^-1,1,4,4^2];
[N,D]=size(X);
YX=repmat(Y,1,D).*X;
opts = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
for i=1:9
    
    H = diag([ones(1, D), zeros(1, N + 1)]);
    f = [zeros(1, D), C(i) * ones(1, N), 0]';
    
    A=[YX,eye(N),Y];
    B = ones(N, 1);
    
    lb = [-inf(D, 1); zeros(N, 1); -inf(1, 1)];
    z = quadprog(H, f, -A, -B, [], [], lb,[],[],opts);
    
    w=z(1:D,1);
    b=z(N+D+1);
    
    for k=1:N
        if(X(k,:)*w+b>0)
            predict_y(k)=1;
        else
            predict_y(k)=-1;
        end
    end
    
    acc(i)=1-nnz(predict_y'-Y)/size(Y,1);
    
end
