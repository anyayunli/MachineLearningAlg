function[feature]=expand(fmatrix)
[row,col]=size(fmatrix);

for i=1:row
    if(fmatrix(i,1)==1)
        feature(i,1)=1;
    else
        feature(i,1)=0;
    end
    
    if(fmatrix(i,1)==2)
        feature(i,2)=1;
    else
        feature(i,2)=0;
    end
    
    if(fmatrix(i,1)==3)
        feature(i,3)=1;
    else
        feature(i,3)=0;
    end
    
    if(fmatrix(i,1)==4)
        feature(i,4)=1;
    else
        feature(i,4)=0;
    end
    
    if(fmatrix(i,2)==1)
        feature(i,5)=1;
    else
        feature(i,5)=0;
    end
    
    if(fmatrix(i,2)==2)
        feature(i,6)=1;
    else
        feature(i,6)=0;
    end
    
    if(fmatrix(i,2)==3)
        feature(i,7)=1;
    else
        feature(i,7)=0;
    end
    
    if(fmatrix(i,2)==4)
        feature(i,8)=1;
    else
        feature(i,8)=0;
    end
    
    if(fmatrix(i,3)==2)
        feature(i,9)=1;
    else
        feature(i,9)=0;
    end
    
    if(fmatrix(i,3)==3)
        feature(i,10)=1;
    else
        feature(i,10)=0;
    end
    
    if(fmatrix(i,3)==4)
        feature(i,11)=1;
    else
        feature(i,11)=0;
    end
    
    if(fmatrix(i,3)==5)
        feature(i,12)=1;
    else
        feature(i,12)=0;
    end
    
    if(fmatrix(i,4)==2)
        feature(i,13)=1;
    else
        feature(i,13)=0;
    end
    
    if(fmatrix(i,4)==4)
        feature(i,14)=1;
    else
        feature(i,14)=0;
    end
    
    if(fmatrix(i,4)==6)
        feature(i,15)=1;
    else
        feature(i,15)=0;
    end
    
    if(fmatrix(i,5)==1)
        feature(i,16)=1;
    else
        feature(i,16)=0;
    end
    
    if(fmatrix(i,5)==2)
        feature(i,17)=1;
    else
        feature(i,17)=0;
    end
    
    if(fmatrix(i,5)==3)
        feature(i,18)=1;
    else
        feature(i,18)=0;
    end
    
    if(fmatrix(i,6)==1)
        feature(i,19)=1;
    else
        feature(i,19)=0;
    end
    
    if(fmatrix(i,6)==2)
        feature(i,20)=1;
    else
        feature(i,20)=0;
    end
    
    if(fmatrix(i,6)==3)
        feature(i,21)=1;
    else
        feature(i,21)=0;
    end
end