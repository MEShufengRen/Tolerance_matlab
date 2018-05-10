function pop = initialization(pop,Simulate_para,range,PartNum,part_distribute)
%��Ⱥ��ʼ��
pop.individual = round(rand(pop.size,10*Simulate_para));%���ɳ�ʼ��Ⱥ,ÿ����̬�ֲ�����ʹ��10λ�����Ʊ�ʾ

pop.solution = transform(pop.individual,Simulate_para,range);%�����Ƹ���תʵ����
pop.obj = fitness(pop.solution,PartNum,part_distribute);%����Ŀ�꺯��ֵ������ģ��ƫ��Ĳ��������������

%------------------------------------------------------------

n = find(pop.obj == max(pop.obj),1);%��ǰ��Ⱥ���Ž��±�

%��¼���Ŷ����Ƹ����ʵ���⣬�Լ���Ѽ�ƽ��Ŀ�꺯��ֵ
pop.bestIndividual = pop.individual(n,:);
pop.bestSolution = pop.solution(n,:);
pop.perfom = [max(pop.obj),mean(pop.obj)];