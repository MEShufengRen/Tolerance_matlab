function y = transform(x,Simulate_para,range)
%二进制个体转实数解,Simulate_para是遗传算法要寻优的参数数量，range限定了参数范围
y = zeros(size(x,1),Simulate_para);%初始化实数解
for i = 1:size(x,1)
    a = x(i,:);
    a1=zeros(1,Simulate_para);
    b=zeros(1,Simulate_para);
    for j=1:Simulate_para
        a1(j) = Two2Ten(a(10*(j-1)+1:10*j));%每10位二进制为一个变量，转为十进制
        b(j) = 0.5+a1(j)*(range/(2^10-1));%计算实数第一决策变量(范围是0.5~0.5+range）   
    end
    y(i,:) =b;%组成完整解
end