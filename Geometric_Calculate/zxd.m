function p_zxd=zxd(D)%ֱ�߶ȼ���
[m,~]=size(D);
xyz0=mean(D,1);% ��ϵ�ֱ�߱ع��������������ƽ��ֵ
% Э�����������任�������ƽ�治ͬ����
% ����ֱ�ߵķ���ʵ�������������ֵ��Ӧ������������ͬ
centeredLine=bsxfun(@minus,D,xyz0);%ִ��D-xyz0�ļ���(D��ÿһ�м�ȥxyz0)`
[~,~,V]=svd(centeredLine);
n=V(:,1);
p=zeros(m,1);
for i=1:m
    p(i)=P_LDistance(xyz0,n,D(i,:));
end
p_zxd=max(p);
end