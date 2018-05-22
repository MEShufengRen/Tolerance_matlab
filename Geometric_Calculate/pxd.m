function pp_pxd=pxd(D1,D2)%平行度计算
%以面1拟合基准面
%协方差矩阵的SVD变换中，最小奇异值对应的奇异向量就是平面的方向
xyz0=mean(D1,1);
centeredPlane=bsxfun(@minus,D1,xyz0);
[~,~,V]=svd(centeredPlane);%平面方程ZFIT = -(d + a * XFIT + b * YFIT)/c
a=V(1,3);
b=V(2,3);
c=V(3,3);
d=-dot([a b c],xyz0);
p=[a,b,c]';
%求面2上点到面1的距离
[m2,~]=size(D2);
pp=zeros(m2,1);
for i=1:m2
    pp(i,1)=(D2(i,:)*p+d)/(sqrt(p'*p));
end
pp_pxd=max(pp)-min(pp);
end