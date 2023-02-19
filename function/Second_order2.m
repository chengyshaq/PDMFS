

function [feat]= Second_order2(data, order,W, answer)
numf=size(data,2);
P=3;
k=ceil(numf/P);
%p1=0.4;p2=0.4;p3=0.2; 
%p1=0.7;p2=0.2;p3=0.1; 
p1=0.6;p2=0.3;p3=0.1; 
%p1=0.5;p2=0.1;p3=0.1;p4=0.1;p5=0.1;p6=0.1; 

ll=length(order);
k0=ll-k*(P-1);
num1=ceil(k*p1);
num2=ceil(k*p2);
num3=ceil(k0*p3);
%num4=ceil(k*p4);
%num5=ceil(k*p5);
%num6=ceil(k0*p6);
%subnum=[num1 num2 num3 num4 num5 num6];
subnum=[num1 num2 num3];

SOrder=zeros(P,k);
for A=1:P
    [sec_order]=fI_significance(k,A,order,W, answer);
    if A<P
        SOrder(A,:)=sec_order;
    else
        SOrder(A,(1:k0))=sec_order;
    end
end
%%%%%%分组得到各组的特征子集序列%%%%

L=sum(subnum);
feat=zeros(1,L);
for A=1:P
    feat(1,((sum(subnum(1,(1:(A-1)))))+1):sum(subnum(1,(1:A))))=SOrder(A,(1:subnum(1,A)));
end
end
