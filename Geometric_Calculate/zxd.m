function p_zxd=zxd(D)%直线度计算
[m,~]=size(D);
xyz0=mean(D,1);% 拟合的直线必过所有坐标的算数平均值
% 协方差矩阵奇异变换，与拟合平面不同的是
% 所得直线的方向实际上与最大奇异值对应的奇异向量相同
centeredLine=bsxfun(@minus,D,xyz0);%执行D-xyz0的减法(D的每一行减去xyz0)`
[~,~,V]=svd(centeredLine);
n=V(:,1);
p=zeros(m,1);
for i=1:m
    p(i)=P_LDistance(xyz0,n,D(i,:));
end
p_zxd=max(p);
end