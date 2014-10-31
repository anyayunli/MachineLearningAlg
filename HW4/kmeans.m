function [output,J,uk]=kmeans(K,data,d,isplot)
% K: number of clusters
% data: input
% d: feature dimensionality
% isplot: plot clusters/ distortion function
[N,~]=size(data);
if isplot==0
    uk=rand(K,d);
else
    randindex=randi(N, K, 1);
    
    for i=1:K
        uk(i,:)=data(i,:);
    end
end
N=size(data,1);

eucDistance=zeros(N,K);
itr=1;
tmp=zeros(N,K);
J=zeros(50,1);
while itr<=50
    rnk=zeros(N,K);
    prev=J(itr,1);
    %step2 update rnk
    for i=1:N
        for j=1:K
            eucDistance(i,j)=norm(data(i,:)-uk(j,:));
        end
        [V,I]=min(eucDistance(i,:));
        J(itr,1)=prev+V;
        rnk(i,I)=1;
    end
    itr=itr+1;
    
    %     if isequal(tmp,rnk)
    %         break;
    %     end
    
    
    %update uk for x
    uk=[];
    for k=1:d
        x=rnk.*repmat(data(:,k), 1,K) ;
        x=sum(x)./sum(rnk);
        x(isnan(x)) = 1 ;
        uk(:,k)=x(:);
    end
   
    for i=1:N
        for j=1:K
            tmp(i,j)=rnk(i,j);
        end
    end
end


if isplot==2
    for i=1:N
        [~,colindex]=find(rnk(i,:)==1);
        output(i,:)=uk(colindex,:);
    end
end

if isplot==1
    for i=1:N
        [~,colindex]=find(rnk(i,:)==1);
        output(i,:)=[data(i,:),colindex];
    end
end

if isplot==0
    for i=1:N
        [~,colindex]=find(rnk(i,:)==1);
        output(i,:)=[data(i,:),colindex];
    end
end



if isplot==1
    lineStyle=cellstr(['r.';'g.';'y.';'b.';'c.';'m+';'y-';'wo';'*o';'ro';'yo']);
    for i=1:N
        plot(output(i,1),output(i,2),lineStyle{int64(output(i,3))});
        hold on;
    end
end
