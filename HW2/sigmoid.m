function [y]=sigmoid(a)
y=1./ (1.0 + exp(-a));
y(y<1e-16)=1e-16;
y(y>1-1e-16)=1-1e-16;
% if(y<1e-16)
%     y=1e-16;
% end
% if(y>1-1e-16)
%     y=1-1e-16;
% end
%     
end