function[org_image]=VQ(K)
clc
img=im2double(imread('hw4.jpg'));
[r,c,d]=size(img);

data=reshape(img,[],d);

[output,~,uk]=kmeans(K,data,3,2);

vqdata=cat(3,output(:,1),output(:,2),output(:,3));

s=size(img);
org_image = permute(reshape( output, s),[1 2 3]);
%image(org_image);
