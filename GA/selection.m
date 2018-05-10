function pop = selection(pop,Simulate_para,range)
%选择函数
if max(pop.obj)>1
    p = pop.obj/sum(pop.obj);%计算生存概率
    pp = cumsum(p);%计算累计概率

    for i = 1:pop.size
        r = rand;%产生一个随机数
        k(i) = find(pp>=r,1);%随机数落在哪个累积概率区间，即对应的个体被选中，记录下标
    end
    %把选中的个体放入新种群
    pop.individual = pop.individual(k,:);
    pop.solution = pop.solution(k,:);
    pop.obj = pop.obj(k,:);
else
     pop.solution = pop.solution.*0.9; %如果种群内适应度没有大于1的，那么正态分布标准差参数缩小为0.9
     temp_solution = (pop.solution-0.45*ones(pop.size,Simulate_para)).*(2^10-1)/range;%
     for i=1:pop.size
        for j=1:Simulate_para
            pop.individual(i,10*(j-1)+1:10*j)=dec2bin(temp_solution(i,j),10);
        end
     end
     pop.individual=pop.individual-48*ones(pop.size,10*Simulate_para);%dec2bin处理后，1显示49，0显示48
end
end