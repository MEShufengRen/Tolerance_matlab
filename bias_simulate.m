function Bias = bias_simulate(a,PartNum,part_size,part_distribute)
Bias=cell(PartNum,1);
for i=1:PartNum %正态分布模拟偏差场
    k=part_distribute(i); %确定该零件类别
    Bias{i}=zeros(part_size(i),1);
    Bias{i}(1:3:part_size(i))=normrnd(0,a(k)/3,[part_size(i)/3,1])/sqrt(3); %按照轮廓度随机
    Bias{i}(2:3:part_size(i))=normrnd(0,a(k)/3,[part_size(i)/3,1])/sqrt(3); 
    Bias{i}(3:3:part_size(i))=normrnd(0,a(k)/3,[part_size(i)/3,1])/sqrt(3); 
end
end

