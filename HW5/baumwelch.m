function [A_estimate, E_estimate] = baumwelch(data, A_guess, E_guess, N_iter)
pi = [0.5,0.5];
K=2;
E=4;
[N,T] = size(data);
a = zeros(T,K);
b = zeros(T,K);
sp = zeros(T-1,K,K);
unsp = zeros(T,K);

for it = 1:N_iter
    s_a1 = zeros(K,K);
    s_a2 = zeros(K,K);
    s_b3 = zeros(K,E);
    s_b4 = zeros(K,E);
    for n = 1:N
        sample = data(n,:);
        p1 = 0;
        
        %initialize
        for i = 1:K
            b(T,i) = 1;
            a(1,i) = pi(i) * E_guess(i,sample(1));
            p1 = p1 + a(T,i);
        end
        for t = T-1:-1:1
            for i = 1:K
                tmp = 0;
                for j = 1:K
                    tmp = tmp + A_guess(i,j) * E_guess(j,sample(t+1)) * b(t+1,j);
                end
                b(t,i) = tmp;
            end
        end
        
        for t = 1:T-1
            for i = 1:K
                tmp = 0;
                for m = 1:K
                    tmp = tmp + a(t,m) * A_guess(m,j);
                end
                a(t+1,i) = tmp * E_guess(i,sample(t+1));
                for j = 1:K
                    tmp = 0;
                    for m = 1:K
                        for n = 1:K
                            tmp = tmp + a(t,m) * A_guess(m,n) * E_guess(n,sample(t+1)) * b(t+1,n);
                        end
                    end
                    sp(t,i,j) = a(t,i) * A_guess(i,j) * E_guess(j,sample(t+1)) * b(t+1,j) / tmp;
                end
            end
        end
        
        for t = 1:T
            for i = 1:K
                tmp = 0;
                for m = 1:K
                    tmp = tmp + a(t,m) * b(t,m);
                end
                unsp(t,i) = a(t,i) * b(t,i) / double(tmp);
            end
        end
        
        %estimate
        for j = 1:K
            for k = 1:4
                for t = 1:T
                    if sample(t) == k
                        s_b3(j,k) = s_b3(j,k) + unsp(t,j);
                    end
                        s_b4(j,k) = s_b4(j,k) + unsp(t,j);
                end
            end
            for m = 1:K
                for t = 1:T-1
                    s_a1(j,m) = s_a1(j,m) + sp(t,j,m);
                    s_a2(j,m) = s_a2(j,m) + unsp(t,j);
                end
            end
            pi(j) = unsp(1,j);
        end
        
    end
    A_estimate = s_a1 ./ s_a2;
    E_estimate = s_b3 ./ s_b4;
    
    sa = sum(A_estimate,2);
    se = sum(E_estimate,2);
    for k = 1:K
        for kk = 1:K
            A_estimate(k,kk) = A_estimate(k,kk) / sa(k);
        end
        for e = 1:E
            E_estimate(k,e) = E_estimate(k,e) / se(k);
        end
    end
    A_guess = A_estimate;
    E_guess = E_estimate;
end
end

%
% Train Hidden Markov Model using the Baum-Welch algorithm (expectation maximization)
% Input:
%  data: N*T matrix, N data samples of length T
%  A_guess: K*K matrix, where K is the number hidden states [initial guess for the transition matrix]
%  E_guess: K*E matrix, where E is the number of emissions [initial guess for the emission matrix]
%
% Output:
%  A_estimate: estimate for the transition matrix after N_iter iterations of expectation-maximization
%  E_estimate: estimate for the emission matrix after N_iter iterations of expectation-maximization
%
% CSCI 576 2014 Fall, Homework 5
% digits(40);