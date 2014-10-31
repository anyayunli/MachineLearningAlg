function [eigenvecs] = pca_fun(X, d)
% compute sample covariance
u_data=ones(640,1)*mean(X);
dataC=X-u_data;
smpCov=cov(dataC);
% top d values and vectors
[V,D]=eigs(smpCov,d,'la');
eigenvecs=V;


% Implementation of PCA
% input:
%   X - N*D data matrix, each row as a data sample
%   d - target dimensionality, d <= D
% output:
%   eigenvecs: D*d matrix
%
% usage:
%   eigenvecs = pca_fun(X, d);
%   projection = X*eigenvecs;
%
% CSCI 576 2014 Fall, Homework 5

