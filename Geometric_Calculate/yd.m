function dr=yd(D)%���Բ��
%��ϻ�׼ƽ��
[m,~]=size(D);
%ƽ�淨����
xyz0=mean(D,1);
centeredPlane=bsxfun(@minus,D,xyz0);
[~,~,V]=svd(centeredPlane);%ƽ�淽��ZFIT = -(d + a * XFIT + b * YFIT)/c
a=V(1,3);
b=V(2,3);
c=V(3,3);
d=-dot([a b c],xyz0);
DD=zeros(m,3);%��㵽ƽ���ϵ�ͶӰ����
for i=1:m
    T=a^2+b^2+c^2;
    t=-(d+a*D(i,1)+b*D(i,2)+c*D(i,3))/T;
    DD(i,:)=[a*t+D(i,1),b*t+D(i,2),c*t+D(i,3)];
end
%��С�������Բ�ĺͰ뾶
%�����ƽ������ϵԭ����Ϊxyz0��z�᷽��Ϊƽ�淽��ƽ�Ƶ�ȫ������ϵԭ�㣩
Transfer=bsxfun(@minus,DD,xyz0);%ƽ��ƽ��
alpha=atan(b/a);%��Z����ת
beta=atan(sqrt(b^2+a^2)/c);%��y����ת
R1=[cos(alpha),-sin(alpha),0;sin(alpha),cos(alpha),0;0,0,1];%��ת����1
R2=[cos(beta),0,sin(beta);0,1,0;-sin(beta),0,cos(beta)];%��ת����2
DDD=(R2*R1*Transfer')';%z������ת+ƽ�ƣ������ƽ���Ͻ�������ϵ
D_2=DDD(:,1:2);%��ö�ά���ݵ�����
x=D_2(:,1);y=D_2(:,2);%Բ����Ϊx^2+y^2+a1x+a2y+a3=0
xx=x.*x;
yy=y.*y;
xy=x.*y;
A=[sum(x),sum(y),m;sum(xy),sum(yy),sum(y);sum(xx),sum(xy),sum(x)];
B=[-sum(xx+yy);-sum(xx.*y+yy.*y);-sum(xx.*x+xy.*y)];
cenpoint=A\B;
xc=-0.5*cenpoint(1);%Բ��x,y����
yc=-0.5*cenpoint(2);
R=sqrt((xc^2+yc^2)/4-cenpoint(3));%Բ�뾶
pp=zeros(m,1);
for i=1:m
    pp(i)=sqrt((x(i)-xc)^2+(y(i)-yc)^2)-R;
end
dr=(max(pp)-min(pp));
end