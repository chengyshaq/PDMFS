clc;
clear;
load('science.mat');

Train_data = train_data;
Train_target = train_target;
Test_data = test_data;
Test_target = test_target;
 %%%%%%%%%%Learning label specific features%%%%%%%%%%%%%% 
[W]= LearningLSF(train_data, test_data, train_target, test_target);
%%%%%%%%%%PDMFS Data Pre-processing%%%%%%%%%%%%%% 
numB=2;
numK=size(Train_data,2);
[data target]=trans_11(Train_data,Train_target',numB); 
[data1,W]=trans_11(Train_data,W',numB); 
answer=target';
%%%%%%%%%%%%%%% Channel A %%%%%%%%%%%%%%%%%%
[order]=(IG_significance( data, answer))';
[feat,subnum]=Second_order3(data, order');
%%%%%%%%%%%%%%% Channel B %%%%%%%%%%%%%%%%%%
[order2]=(IG_significance( W', answer'))';
[feat1,subnum]=Second_order3(data, order2');
%%%%%%%%%%%%%% Cross-merging %%%%%%%%%%%%%%%%%%%%%%% 
[Result]=Repair(feat,feat1,data,subnum);
%%%%%%%%%%%%%% MLKNN %%%%%%%%%%%%%%%%%%%%%%%
Num=10;Smooth=1;
n=length(Result);
for i=1:n  
    f=Result(1:i);
    [Prior,PriorN,Cond,CondN]=MLKNN_train(Train_data(:,f),Train_target,Num,Smooth);
    [HammingLoss,RankingLoss,Coverage,Average_Precision,Outputs,Pre_Labels]=MLKNN_test(Train_data(:,f),Train_target,Test_data(:,f),Test_target,Num,Prior,PriorN,Cond,CondN);
    [MacroPrecision, MacroRecall, MacroF1, MicroPrecision, MicroRecall, MicroF1]=MM_6Measures(Pre_Labels,Test_target);   
    HL_Result(i)=HammingLoss;
    RL_Result(i)=RankingLoss;
    CV_Result(i)=Coverage;
    AP_Result(i)=Average_Precision;
    MacroF1_Result(i)=MacroF1;
    MicroF1_Result(i)=MicroF1;    
end
