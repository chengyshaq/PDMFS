function [order]= IG_significance( data, answer)

fcol = size(data, 2 ); 
% icol = size(data, 1 );
lcol = size(answer, 2 ); 

f_ent = zeros( fcol, 1 );
fl_ent = zeros( fcol, lcol ); 
%fi_ent = zeros( icol, 1 );

for k=1:fcol
    f_ent( k, 1 ) = p_entropy(data(:,k)); 
    for m=1:lcol  
        fl_ent(k,m) = p_entropy( [data(:,k) answer(:,m)] );
    end
end
l_ent = zeros( 1, lcol );
for m=1:lcol
    l_ent( 1, m ) = p_entropy( answer(:,m) );
end
%���������ǩ�Ļ���Ϣ�ļ��㣺I(S;L)=H(S)-H(S;L)+H(L); f_ent(k)- fl_ent(k,m)+ l_ent(m)
rel = zeros( fcol, 1 );
for k=1:fcol
    for m=1:lcol
        rel(k) = rel(k) + f_ent(k) + l_ent(m) ...
            - fl_ent(k,m);
    end
end
[newrel,order]=sort(rel,'descend');
end