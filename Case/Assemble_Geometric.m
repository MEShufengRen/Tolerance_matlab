function [R,UR_tol,DR_tol,PM,PU_tol,PD_tol,PX,PX_tol,Profile,Profile_tol] = Assemble_Geometric(Node_Bias,Node_Biastol,PartNum)%计算各零件\子装配体\装配体的平面度\平行度\轮廓度
%% 计算圆度
R=zeros(PartNum,1);%零件圆度
for i=1:PartNum
    D1=Node_Bias{i}(1:1:16,:);
    D2=Node_Bias{i}(end-15:1:end,:);
    R(i)=max(yd(D1),yd(D2));
end
UR=Node_Biastol(305:1:320,:);%装配体圆度（注意：二级氧箱计算几何指标需要指定,修改）
DR=Node_Biastol(end-15:1:end,:);
UR_tol=yd(UR);
DR_tol=yd(DR);
%% 计算平面度
PM=zeros(PartNum,1);%零件平面度
for i=1:PartNum
    biasU=Node_Bias{i}(1:1:16,:);
    biasD=Node_Bias{i}(end-15:1:end,:);
    PM(i)=max(pmd(biasU),pmd(biasD));
end
biasU_tol=Node_Biastol(305:1:320,:);%装配体上端面平面度（注意：二级氧箱计算几何指标需要指定,修改）
PU_tol=pmd(biasU_tol);
biasD_tol=Node_Biastol(end-15:1:end,:);%装配体下端面平面度
PD_tol=pmd(biasD_tol);
%% 计算平行度
PX=zeros(PartNum,1);%零件平行度
for i=1:PartNum
    PX(i)=pxd(Node_Bias{i}(1:1:16,:),Node_Bias{i}(end-15:1:end,:));
end
PX_tol=pxd(Node_Biastol(305:1:320,:),Node_Biastol(end-15:1:end,:));%装配体上下端面平行度
%% 计算轮廓度/母线直线度
Profile=zeros(PartNum,1);%零件轮廓度
for i=[3,4,7,8]
    profile={Node_Bias{i}(1:16:end,:),Node_Bias{i}(5:16:end,:),Node_Bias{i}(9:16:end,:),Node_Bias{i}(13:16:end,:)};%两条母线直线
    Profile(i)=zxd(profile{1});
end
profile_tol={Node_Biastol(65:16:225,:),Node_Biastol(69:16:229,:),Node_Biastol(73:16:233,:)};%装配体轮廓度(选取两条母线）
Profile_tol=zxd(profile_tol{1});
end

