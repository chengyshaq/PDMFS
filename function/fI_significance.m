function [sec_order]= fI_significance( k,A,order,W, answer)
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

% fcol = size(W, 1 ); 
Icol = size(answer, 1 );
 f_ent = zeros( kk, 1 );
I_ent = zeros( Icol, 1 );
fI_ent = zeros( kk, Icol );

for i=1:kk 
  f_ent( i, 1 ) = p_entropy(W(suborder(1,i),:)');
    for m=1:Icol
        fI_ent(i,m) = p_entropy( [W(suborder(1,i),:)' answer(m,:)'] );
    end
end
for m=1:Icol
  I_ent( 1, m ) = p_entropy(answer(m,:)'); 
end
%互信息的计算：I(S;L)=H(S)-H(S;L)+H(L); f_ent(k)- fl_ent(k,m)+ l_ent(m)
% rel = zeros( kk,1 );
for i=1:kk
    for m=1:Icol
        rel = f_ent(i)+ I_ent(m) ...
            - fI_ent(i,m);
        ff_cor(i,m)=rel;
    end
    ffIG(i,:)=sum(ff_cor(i,:));
end
[newrel,neworder]=sort(ffIG,'descend');
for i=1:kk
    sec_order(1,i)=suborder(1,neworder(i,1));
end
end