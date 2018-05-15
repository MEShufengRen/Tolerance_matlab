function pp_pxd=pxd(D1,D2)%平行度计算
%以面1拟合基准面
[m1,~]=size(D1);
%平面法向量
p=pinv(D1)*ones(m1,1);
%求面2上点到面1的距离
[m2,~]=size(D2);
pp=zeros(m2,1);
for i=1:m2
    pp(i,1)=(D2(i,:)*p-1)/(sqrt(p'*p));
end
pp_pxd=max(pp)-min(pp);
end