function pp_pmd=pmd(D)%平面度计算
[m,~]=size(D);
%协方差矩阵的SVD变换中，最小奇异值对应的奇异向量就是平面的方向
xyz0=mean(D,1);
centeredPlane=bsxfun(@minus,D,xyz0);
[~,~,V]=svd(centeredPlane);%平面方程ZFIT = -(d + a * XFIT + b * YFIT)/c
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