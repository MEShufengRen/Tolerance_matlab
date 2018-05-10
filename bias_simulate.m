function Bias = bias_simulate(a,PartNum,part_size,part_distribute)
Bias=cell(PartNum,1);
for i=1:PartNum %��̬�ֲ�ģ��ƫ�
    k=part_distribute(i); %ȷ����������
    Bias{i}=zeros(part_size(i),1);
    Bias{i}(1:3:part_size(i))=normrnd(0,a(k)/3,[part_size(i)/3,1])/sqrt(3); %�������������
    Bias{i}(2:3:part_size(i))=normrnd(0,a(k)/3,[part_size(i)/3,1])/sqrt(3); 
    Bias{i}(3:3:part_size(i))=normrnd(0,a(k)/3,[part_size(i)/3,1])/sqrt(3); 

%     Bias{i}(2:3:48)=normrnd(0,a(2*k)/3,[16,1]); %����ƽ��������������������Ҫɾ��
%     Bias{i}(end-46:3:end)=normrnd(0,a(2*k)/3,[16,1]);
end
end

