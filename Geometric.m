function [R,UR_tol,DR_tol,PM,PU_tol,PD_tol,PX,PX_tol,Profile,Profile_tol] = Geometric(Bias,Biastol,PartNum)%计算各零件\子装配体\装配体的平面度\平行度\轮廓度
%% 计算圆度
R=zeros(PartNum,1);%零件圆度
for i=1:PartNum
    biasUR=sqrt(Bias{i}(1:15:81*3,1).^2+Bias{i}(3:15:81*3,1).^2);
    biasDR=sqrt(Bias{i}(13:15:end,1).^2+Bias{i}(15:15:end,1).^2);
    UR=max(max(biasUR));
    DR=max(max(biasDR));
    R(i)=max(UR,DR);
end
biasUR_tol=sqrt(Biastol(1:15:316*3,1).^2+Biastol(3:15:316*3,1).^2);%装配体圆度（注意：二级氧箱计算几何指标需要指定,修改）
biasDR_tol=sqrt(Biastol(13:15:end,1).^2+Biastol(15:15:end,1).^2);
UR_tol=max(biasUR_tol);
DR_tol=max(biasDR_tol);
%% 计算平面度
PM=zeros(PartNum,1);%零件平面度
biasU=cell(PartNum,1);
biasD=cell(PartNum,1);
for i=1:PartNum
    biasU{i}=Bias{i}(2:15:81*3,1);
    biasD{i}=Bias{i}(14:15:end,1);
    PU=max(biasU{i})-min(biasU{i});
    PD=max(biasD{i})-min(biasD{i});
    PM(i)=max(PU,PD);
end
biasU_tol=Biastol(2:15:316*3,1);%装配体上端面平面度（注意：二级氧箱计算几何指标需要指定,修改）
PU_tol=max(biasU_tol)-min(biasU_tol);
biasD_tol=Biastol(14:15:end,1);%装配体下端面平面度
PD_tol=max(biasD_tol)-min(biasD_tol);
%% 计算平行度
PX=zeros(PartNum,1);%零件平行度
for i=1:PartNum
    PX(i)=max(max(biasU{i})-min(biasD{i}),max(biasD{i})-min(biasU{i}));
end
PX_tol=max(max(biasU_tol)-min(biasD_tol),max(biasD_tol)-min(biasU_tol));%装配体上下端面平行度
%% 计算轮廓度/母线直线度
Profile=zeros(PartNum,1);%零件轮廓度
for i=1:PartNum
    profile=sqrt(Bias{i}(1:3:end,1).^2+Bias{i}(2:3:end,1).^2+Bias{i}(3:3:end,1).^2);
    Profile(i)=max(profile);
end
profile_tol=sqrt(Biastol(1:3:end,1).^2+Biastol(2:3:end,1).^2+Biastol(3:3:end,1).^2);%装配体轮廓度
Profile_tol=max(profile_tol);
end

