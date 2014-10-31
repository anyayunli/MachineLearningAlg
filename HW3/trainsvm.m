function [w,b] = trainsvm(train_data, train_label, C)
% Train linear SVM (primal form)
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  C: tradeoff parameter (on slack variable side)
%
% Output:
%  w: feature vector (column vector)
%  b: bias term
%
% CSCI 576 2014 Fall, Homework 3
X=train_data;
Y=train_label;
[N,D]=size(X);
YX=repmat(Y,1,D).*X;
opts = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');

    H = diag([ones(1, D), zeros(1, N + 1)]);
    f = [zeros(1, D), C * ones(1, N), 0]';
    
    A=[YX,eye(N),Y];
    B = ones(N, 1);
    
    lb = [-inf(D, 1); zeros(N, 1); -inf(1, 1)];
    z = quadprog(H, f, -A, -B, [], [], lb,[],[],opts);
    
    w=z(1:D,1);
    b=z(N+D+1);
    
end
    
