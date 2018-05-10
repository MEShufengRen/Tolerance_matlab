function [pop,finalsolution,Bias,Bias_sub,Biastol] = test(Part_sort,generation,part_distribute)
% Part_sort表示零件种类 range正态分布模拟偏差场的范围 generation 种群迭代次数
% part_distribute是按照装配顺序的零件种类分布，如[1,3,2,2,3,1,4,4]表示二级氧箱 1-箱底 2-筒段 3-Y型环 4-短壳
tic
warning('off')
%% 读取节点坐标信息和刚度矩阵
K_Path_tol='C:\Users\Shufeng Ren\Desktop\V2_td_Test\K_Information\Test_td_K_size517'; %输入储存刚度阵文件的位置
Node_Path_tol='C:\Users\Shufeng Ren\Desktop\V2_td_Test\K_Information\Test_td_Node_size517'; %输入储存节点坐标编号文件的位置
global K Tran
[K,Tran,FileNum_tol]=information(K_Path_tol,Node_Path_tol);%输出刚度矩阵和转换矩阵，FileNum_tol表示装配次数
PartNum=FileNum_tol+1;%得到零件数量（装配次数+1）=模拟偏差场个数
Simulate_para=Part_sort;%每种零件使用1个正态分布标准差参数模拟偏差场
pop.size = 200;%种群规模
pop.cr = 0.6;%交叉概率
range=1.2; %限定正态分布参数范围
pop = initialization(pop,Simulate_para,range,PartNum,part_distribute);%初始化种群
for i = 1:generation %遗传代数
    pop = newPop(pop,Simulate_para,range,PartNum,part_distribute);%生成新一代种群   
end
if max(abs(pop.bestSolution(end,:)-pop.bestSolution(end-1,:)))<0.1 %迭代是否收敛
    fprintf('最优结果较好\n');
else
    fprintf('最优结果不太好\n');
end
finalsolution=pop.bestSolution(end,:);
[Bias,Bias_sub,Biastol]=FinalResult(finalsolution,PartNum,part_distribute); %输出结果
toc
end