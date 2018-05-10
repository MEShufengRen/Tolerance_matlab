function [Bias,Bias_sub,Biastol] = FinalResult(finalsolution,PartNum,part_distribute)
global K Tran
%将零件维度对应刚度阵存储起来
part_size=zeros(PartNum);%初始化各个零件维度/节点数目
part_size(1)=length(K{1,1});part_size(2)=length(K{1,2});%各个零件维度=刚度矩阵维度=节点数目*3
for i=2:PartNum-1
    part_size(i+1)=length(K{i,2});
end
for i=1:1000
    Bias = bias_simulate(finalsolution,PartNum,part_size,part_distribute); %模拟零件偏差场
    Bias_sub=cell(PartNum-1,1);%初始化子装配体偏差场 
    % 按照变形协调计算子装配体/装配体偏差场
    temp1=Tran{1,1}*K{1,1}*Bias{1};%先进行一次装配
    temp2=Tran{1,2}*K{1,2}*Bias{2};
    Bias_sub{1}=K{1,3}\(temp1+temp2);
    for j=2:PartNum-1  %完成剩余装配
        temp1=Tran{j,1}*K{j,1}*Bias_sub{j-1};
        temp2=Tran{j,2}*K{j,2}*Bias{j+1};
        Bias_sub{j}=K{j,3}\(temp1+temp2);
    end
    Biastol=Bias_sub{end}; %总装配体偏差场
    %计算各零件\子装配体\装配体的平面度\平行度\轮廓度
    [R(:,i),UR_tol(i),DR_tol(i),PM(:,i),PU_tol(i),PD_tol(i),PX(:,i),PX_tol(i),Profile(:,i),Profile_tol(i)] = Geometric(Bias,Biastol,PartNum);
end
%零件几何指标（顺序按照装配顺序）
PM_qualify=mean(PM,2);%按行平均，每一行代表一个零件在1000次模拟中的几何指标
PX_qualify=mean(PX,2);
R_qualify=mean(R,2);
Profile_qualify=mean(Profile,2);
%装配体几何指标
PU_tol_qualify=mean(PU_tol);PD_tol_qualify=mean(PD_tol);
PX_tol_qualify=mean(PX_tol);
UR_tol_qualify=mean(UR_tol);DR_tol_qualify=mean(DR_tol);
Profile_tol_qualify=mean(Profile_tol);

for i=1:PartNum
    fprintf(strcat('零件',num2str(i)));   
    fprintf('\n'); 
    fprintf('端面平面度：%1.2f\n',PM_qualify(i)); 
    fprintf('端面平行度：%1.2f\n',PX_qualify(i));
    fprintf('轮廓度：%1.2f\n', Profile_qualify(i));
    fprintf('圆度：%1.2f\n',2*R_qualify(i));
end
fprintf('总装配体\n');                      
fprintf('上端面平面度：%1.2f\n',PU_tol_qualify);  
fprintf('下端面平面度：%1.2f\n',PD_tol_qualify);
fprintf('前后端面平行度：%1.2f\n',PX_tol_qualify);
fprintf('母线直线度：%1.2f\n',Profile_tol_qualify);
fprintf('前底圆度：%1.2f\n',2*UR_tol_qualify);
fprintf('后底圆度：%1.2f\n',2*DR_tol_qualify);
end