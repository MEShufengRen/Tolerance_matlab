function dr=yd(D)%求解圆度
%拟合基准平面
[m,~]=size(D);
%平面法向量
xyz0=mean(D,1);
centeredPlane=bsxfun(@minus,D,xyz0);
[~,~,V]=svd(centeredPlane);%平面方程ZFIT = -(d + a * XFIT + b * YFIT)/c
a=V(1,3);
b=V(2,3);
c=V(3,3);
d=-dot([a b c],xyz0);
DD=zeros(m,3);%求点到平面上的投影坐标
for i=1:m
    T=a^2+b^2+c^2;
    t=-(d+a*D(i,1)+b*D(i,2)+c*D(i,3))/T;
    DD(i,:)=[a*t+D(i,1),b*t+D(i,2),c*t+D(i,3)];
end
%最小二乘拟合圆心和半径
%（拟合平面坐标系原点设为xyz0，z轴方向为平面方向平移到全局坐标系原点）
Transfer=bsxfun(@minus,DD,xyz0);%平面平移
alpha=atan(b/a);%绕Z轴旋转
beta=atan(sqrt(b^2+a^2)/c);%绕y轴旋转
R1=[cos(alpha),-sin(alpha),0;sin(alpha),cos(alpha),0;0,0,1];%旋转矩阵1
R2=[cos(beta),0,sin(beta);0,1,0;-sin(beta),0,cos(beta)];%旋转矩阵2
DDD=(R2*R1*Transfer')';%z坐标旋转+平移，在拟合平面上建立坐标系
D_2=DDD(:,1:2);%获得二维数据点坐标
x=D_2(:,1);y=D_2(:,2);%圆方程为x^2+y^2+a1x+a2y+a3=0
xx=x.*x;
yy=y.*y;
xy=x.*y;
A=[sum(x),sum(y),m;sum(xy),sum(yy),sum(y);sum(xx),sum(xy),sum(x)];
B=[-sum(xx+yy);-sum(xx.*y+yy.*y);-sum(xx.*x+xy.*y)];
cenpoint=A\B;
xc=-0.5*cenpoint(1);%圆心x,y坐标
yc=-0.5*cenpoint(2);
R=sqrt((xc^2+yc^2)/4-cenpoint(3));%圆半径
pp=zeros(m,1);
for i=1:m
    pp(i)=sqrt((x(i)-xc)^2+(y(i)-yc)^2)-R;
end
dr=(max(pp)-min(pp));
end