function pop = crossover(pop)
%��������
for i = 1:pop.size/2%����ÿһ�Ը���
    if rand<pop.cr%���������ִ�н������
        %��ȡ���������
        a1 = pop.individual(2*(i-1)+1,:);
        a2 = pop.individual(2*i,:);

        %���㽻�棬���ѡ����򻥻��Ļ���λ��1��=k��=��������-1
        k = ceil(rand*(size(pop.individual,2)-1));
        %ִ�н���
        pop.individual(2*(i-1)+1,:) = [a1(1:k),a2(k+1:end)];
        pop.individual(2*i,:) = [a2(1:k),a1(k+1:end)];

    end
end