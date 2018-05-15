function [R,UR_tol,DR_tol,PM,PU_tol,PD_tol,PX,PX_tol,Profile,Profile_tol] = Xiangdi_Geometric(Node_Bias,Node_Biastol,PartNum)%计算各零件\子装配体\装配体的平面度\平行度\轮廓度
%% 计算圆度
R=zeros(PartNum,1);%零件圆度
for i=1:PartNum
    D1=Node_Bias{i}(1:5:end,:);
    D2=Node_Bias{i}(5:5:end,:);
    R(i)=max(yd(D1),yd(D2));
end
UR=Node_Biastol(1:5:end,:);%装配体圆度（注意：二级氧箱计算几何指标需要指定,修改）
DR=Node_Biastol(5:5:end,:);
UR_tol=yd(UR);
DR_tol=yd(DR);
%% 计算平面度
PM=zeros(PartNum,1);%零件平面度
for i=1:PartNum
    biasU=Node_Bias{i}(1:5:end,:);
    biasD=Node_Bias{i}(5:5:end,:);
    PM(i)=max(pmd(biasU),pmd(biasD));
end
biasU_tol=Node_Biastol(1:5:end,:);%装配体上端面平面度（注意：二级氧箱计算几何指标需要指定,修改）
PU_tol=pmd(biasU_tol);
biasD_tol=Node_Biastol(5:5:end,:);%装配体下端面平面度
PD_tol=pmd(biasD_tol);
%% 计算平行度
PX=zeros(PartNum,1);%零件平行度
for i=1:PartNum
    PX(i)=pxd(Node_Bias{i}(1:5:end,:),Node_Bias{i}(5:5:end,:));
end
PX_tol=pxd(Node_Biastol(1:5:end,:),Node_Biastol(5:5:end,:));%装配体上下端面平行度
Profile=zeros(PartNum,1);Profile_tol=0;
end

