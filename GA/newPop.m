function pop = newPop(pop,Simulate_para,range,PartNum,part_distribute)

%选择算子产生新种群
pop = selection(pop,Simulate_para,range);

%执行交叉和变异算子
pop = crossover(pop);

%transform函数将二进制转化为实数
pop.solution = transform(pop.individual,Simulate_para,range);
%fitness函数适应度评价
pop.obj = fitness(pop.solution,PartNum,part_distribute);

%----------------------------------------------
n = find(pop.obj == max(pop.obj),1);%当前种群最优解下标

%记录最优二进制个体和实数解，以及最佳及平均目标函数值
pop.bestIndividual(end+1,:) = pop.individual(n,:);
pop.bestSolution(end+1,:) = pop.solution(n,:);
pop.perfom(end+1,:) = [max(pop.obj),mean(pop.obj)];
end
