function [Result]=Repair(feat,feat1,data,subnum)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
a=subnum(1,1);
b=subnum(1,2);
c=subnum(1,3);
feat11=feat1(1,1:a);
for i=1:a
    for j=1:a
        if (feat11(1,i) == feat(1,j))    
            feat11(1,i)=0;          
        end   
    end
end
R1=[feat(1,1:a),feat11];
R1=R1';
R1(all(R1==0,2),:)=[];
% R1=union(feat(1,1:subnum(1,1)),feat1(1,1:subnum(1,1)));
[Result1]=Second_order4(data, R1);
f1=feat(1,(a+1):(a+b));
feat12=feat1(1,(a+1):(a+b));
for i=1:b
    for j=1:b
        if (feat12(1,i) == f1(1,j))    
            feat12(1,i)=0;          
        end   
    end
end
R2=[f1,feat12];
R2=R2';
R2(all(R2==0,2),:)=[];
Result2=Second_order4(data, R2);
f2=feat(1,(a+b+1):(a+b+c));
feat13=feat1(1,(a+b+1):(a+b+c));
for i=1:c
    for j=1:c
        if (feat13(1,i) == f1(1,j))    
            feat13(1,i)=0;          
        end   
    end
end
R3=[f2,feat13];
R3=R3';
R3(all(R3==0,2),:)=[];
Result3=Second_order4(data, R3);
q=length(Result1);
% Result2=Result2(1,1:b);
w=length(Result2);
for i=1:w
    for j=1:q
        if (Result2(1,i) == Result1(1,j))    
            Result2(1,i)=0;          
        end   
    end
end
Result4=[Result1,Result2];
Result4=Result4';
Result4(all(Result4==0,2),:)=[];
Result4=Result4';
r=length(Result4);
% Result3=Result3(1,1:c);
v=length(Result3);
for i=1:v
    for j=1:r
        if (Result3(1,i) == Result4(1,j))    
            Result3(1,i)=0;          
        end   
    end
end
Result=[Result4,Result3];
Result=Result';
Result(all(Result==0,2),:)=[];
Result=Result';

