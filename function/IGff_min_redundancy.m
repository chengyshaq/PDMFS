function [sec_order]=IGff_min_redundancy(k,A,order,data)
l=length(order);
if A*k<l
    suborder=order(((A-1)*k+1):A*k);
else
    suborder=order(((A-1)*k+1):l);
end
suborder=suborder';

kk=length(suborder);
ff_cor=zeros(kk,kk);
ffIG=zeros(kk,1);
sec_order=zeros(1,kk);
for i=1:kk
    for j=1:kk
        resff=p_entropy([data(:,suborder(1,i)) data(:,suborder(1,j))]);
        ff_cor(i,j)=resff;
    end
    ff_cor(i,i)=0;
    ffIG(i,:)=sum(ff_cor(i,:));
end
[newff,neworder]=sort(ffIG);
for i=1:kk
    sec_order(1,i)=suborder(1,neworder(i,1));
end
end

 
 
 
