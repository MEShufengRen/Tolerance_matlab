function juli=P_LDistance(xyz0,n,D)%点到直线的距离计算
t=(n(1)*(D(1)-xyz0(1))+n(2)*(D(2)-xyz0(2))+n(3)*(D(3)-xyz0(3)))/(n'*n);%求解垂足位置
chuizu=zeros(1,3);
for i=1:3 %垂足坐标
    chuizu(i)=xyz0(i)+t*n(i);
end
juli=norm(chuizu-D);
end