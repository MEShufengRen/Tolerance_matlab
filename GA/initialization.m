function pop = initialization(pop,Simulate_para,range,PartNum,part_distribute)
%种群初始化
pop.individual = round(rand(pop.size,10*Simulate_para));%生成初始种群,每个正态分布参数使用10位二进制表示

pop.solution = transform(pop.individual,Simulate_para,range);%二进制个体转实数解
pop.obj = fitness(pop.solution,PartNum,part_distribute);%计算目标函数值（输入模拟偏差场的参数和零件数量）

%------------------------------------------------------------

n = find(pop.obj == max(pop.obj),1);%当前种群最优解下标

%记录最优二进制个体和实数解，以及最佳及平均目标函数值
pop.bestIndividual = pop.individual(n,:);
pop.bestSolution = pop.solution(n,:);
pop.perfom = [max(pop.obj),mean(pop.obj)];