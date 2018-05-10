function pop = newPop(pop,Simulate_para,range,PartNum,part_distribute)

%ѡ�����Ӳ�������Ⱥ
pop = selection(pop,Simulate_para,range);

%ִ�н���ͱ�������
pop = crossover(pop);

%transform������������ת��Ϊʵ��
pop.solution = transform(pop.individual,Simulate_para,range);
%fitness������Ӧ������
pop.obj = fitness(pop.solution,PartNum,part_distribute);

%----------------------------------------------
n = find(pop.obj == max(pop.obj),1);%��ǰ��Ⱥ���Ž��±�

%��¼���Ŷ����Ƹ����ʵ���⣬�Լ���Ѽ�ƽ��Ŀ�꺯��ֵ
pop.bestIndividual(end+1,:) = pop.individual(n,:);
pop.bestSolution(end+1,:) = pop.solution(n,:);
pop.perfom(end+1,:) = [max(pop.obj),mean(pop.obj)];
end
