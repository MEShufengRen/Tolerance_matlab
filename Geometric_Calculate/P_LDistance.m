function juli=P_LDistance(xyz0,n,D)%�㵽ֱ�ߵľ������
t=(n(1)*(D(1)-xyz0(1))+n(2)*(D(2)-xyz0(2))+n(3)*(D(3)-xyz0(3)))/(n'*n);%��ⴹ��λ��
chuizu=zeros(1,3);
for i=1:3 %��������
    chuizu(i)=xyz0(i)+t*n(i);
end
juli=norm(chuizu-D);
end