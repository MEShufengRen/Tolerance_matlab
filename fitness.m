function fit= fitness(x,PartNum,part_distribute)
global K Tran
%将零件维度对应刚度阵存储起来
part_size=zeros(PartNum);%初始化各个零件维度/节点数目
part_size(1)=length(K{1,1});part_size(2)=length(K{1,2});%各个零件维度=刚度矩阵维度=节点数目*3
for i=2:PartNum-1
    part_size(i+1)=length(K{i,2});
end
fit=zeros(size(x,1),1);%初始化种群（size(x,1)个个体）的适应度值
for i = 1:size(x,1)
    a = x(i,:);
    Bias = bias_simulate(a,PartNum,part_size,part_distribute); %模拟零件偏差场
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
   [R,UR_tol,DR_tol,PM,PU_tol,PD_tol,PX,PX_tol,Profile,Profile_tol] = Geometric(Bias,Biastol,PartNum);
    % 计算此次偏差场下的适应度函数,作为评价指标,fit为适应度
    a=1.6;   %加工成本系数  %     a1=1.6;a2=0.3;a3=2.0;a4=1.0;   %加工成本系数
    b=1.2;   %修配成本系数  %     b1=1.2;b2=0.2;b3=1.6;b4=0.5;   %修配成本系数
    c=1.2;   %质量损失系数  %     c1=1.2;c2=0.2;c3=1.6;c4=0.5;   %质量损失系数
    if PU_tol<=3 && PD_tol<=3 && PX_tol<=3 && UR_tol<=3 && DR_tol<=3 && Profile_tol<=3 %装配体是否满足要求,装配体输入要求？（选点输入计算是否满足要求）
        xp=zeros(PartNum,1);       %初始化各零件修配量
        eval_PM=0;                 %初始化适应度函数三部分（加工成本、修配成本、质量损失）
        eval_xp=0;
        eval_profile=0;
        for k=1:PartNum
            if Profile(k)>=0.5     %评价零件的修配量
                xp(k)=0;
            else
                xp(k)=0.5-Profile(k);
            end
            eval_PM=a/PM(k)+eval_PM;
            eval_xp=b*sqrt(xp(k))+eval_xp;
            eval_profile=c/4*sqrt(Profile(k))+eval_profile;
        end
        fit(i)=eval_PM+eval_xp+eval_profile;
    else
        fit(i)=20;
    end
    fit(i)=21-fit(i); %目标函数值小，适应度大
end
end