function pp_pmd=pmd(D)%ƽ��ȼ���
[m,~]=size(D);
%Э��������SVD�任�У���С����ֵ��Ӧ��������������ƽ��ķ���
xyz0=mean(D,1);
centeredPlane=bsxfun(@minus,D,xyz0);
[~,~,V]=svd(centeredPlane);%ƽ�淽��ZFIT = -(d + a * XFIT + b * YFIT)/c
a=V(1,3);
b=V(2,3);
c=V(3,3);
d=-dot([a b c],xyz0);
p=[a,b,c]';
pp=zeros(m,1);
for i=1:m
    pp(i,1)=(D(i,:)*p+d)/(sqrt(p'*p));
end
pp_pmd=max(pp)-min(pp);
end