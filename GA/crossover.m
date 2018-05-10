function pop = crossover(pop)
%交叉算子
for i = 1:pop.size/2%遍历每一对个体
    if rand<pop.cr%依交叉概率执行交叉操作
        %提取待交叉个体
        a1 = pop.individual(2*(i-1)+1,:);
        a2 = pop.individual(2*i,:);

        %单点交叉，随机选择基因互换的基因位，1《=k《=基因数量-1
        k = ceil(rand*(size(pop.individual,2)-1));
        %执行交叉
        pop.individual(2*(i-1)+1,:) = [a1(1:k),a2(k+1:end)];
        pop.individual(2*i,:) = [a2(1:k),a1(k+1:end)];

    end
end