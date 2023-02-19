function [train target]=trans_11(train_data,train_target,numB)
[m,n]=size(train_data);
target=train_target';
train=[];
for i=1:n
    res=dis_efi(train_data(:,i), numB );
    train=[train res];
end
index=find(target==0);
target(index)=-1;