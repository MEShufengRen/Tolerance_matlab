function pop = selection(pop,Simulate_para,range)
%ѡ����
if max(pop.obj)>1
    p = pop.obj/sum(pop.obj);%�����������
    pp = cumsum(p);%�����ۼƸ���

    for i = 1:pop.size
        r = rand;%����һ�������
        k(i) = find(pp>=r,1);%����������ĸ��ۻ��������䣬����Ӧ�ĸ��屻ѡ�У���¼�±�
    end
    %��ѡ�еĸ����������Ⱥ
    pop.individual = pop.individual(k,:);
    pop.solution = pop.solution(k,:);
    pop.obj = pop.obj(k,:);
else
     pop.solution = pop.solution.*0.9; %�����Ⱥ����Ӧ��û�д���1�ģ���ô��̬�ֲ���׼�������СΪ0.9
     temp_solution = (pop.solution-0.45*ones(pop.size,Simulate_para)).*(2^10-1)/range;%
     for i=1:pop.size
        for j=1:Simulate_para
            pop.individual(i,10*(j-1)+1:10*j)=dec2bin(temp_solution(i,j),10);
        end
     end
     pop.individual=pop.individual-48*ones(pop.size,10*Simulate_para);%dec2bin�����1��ʾ49��0��ʾ48
end
end