function y = transform(x,Simulate_para,range)
%�����Ƹ���תʵ����,Simulate_para���Ŵ��㷨ҪѰ�ŵĲ���������range�޶��˲�����Χ
y = zeros(size(x,1),Simulate_para);%��ʼ��ʵ����
for i = 1:size(x,1)
    a = x(i,:);
    a1=zeros(1,Simulate_para);
    b=zeros(1,Simulate_para);
    for j=1:Simulate_para
        a1(j) = Two2Ten(a(10*(j-1)+1:10*j));%ÿ10λ������Ϊһ��������תΪʮ����
        b(j) = 0.5+a1(j)*(range/(2^10-1));%����ʵ����һ���߱���(��Χ��0.5~0.5+range��   
    end
    y(i,:) =b;%���������
end