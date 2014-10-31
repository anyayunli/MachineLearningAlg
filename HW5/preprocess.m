function [X,Sub,Y,hmmData,tranp,emip] = preprocess()
clc
clear

input=load('face_data.mat');
N=size(input.image,2);
X=zeros(N,2500);
for i=1:N
X(i,:)=reshape(input.image{1,i},[1,2500]);
end
Sub=input.subsetID';
Y=input.personID';

hmmData=load('hmm_data.mat');
hmmData=hmmData.data;
tranp=[0.7,0.3;0.3,0.7];
emip=[0.25,0.25,0.25,0.25;0.25,0.25,0.25,0.25];


