function pp_pxd=pxd(D1,D2)%ƽ�жȼ���
%����1��ϻ�׼��
%Э��������SVD�任�У���С����ֵ��Ӧ��������������ƽ��ķ���
xyz0=mean(D1,1);
centeredPlane=bsxfun(@minus,D1,xyz0);
[~,~,V]=svd(centeredPlane);%ƽ�淽��ZFIT = -(d + a * XFIT + b * YFIT)/c
a=V(1,3);
b=V(2,3);
c=V(3,3);
d=-dot([a b c],xyz0);
p=[a,b,c]';
%����2�ϵ㵽��1�ľ���
[m2,~]=size(D2);
pp=zeros(m2,1);
for i=1:m2
    pp(i,1)=(D2(i,:)*p+d)/(sqrt(p'*p));
end
pp_pxd=max(pp)-min(pp);
end