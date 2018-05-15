function zhixiandu=zxd(D_metrix)%计算直线度(可以输入多条直线，D_metrix是胞元数组）
for j=1:length(D_metrix)
    D=D_metrix{j};
    [m1,~]=size(D);
    x=D(:,1);
    y=D(:,2);
    z=D(:,3);
    T=[x';y']*pinv([ones(1,m1);z']);
    x0=T(1,1);
    y0=T(2,1);
    m=T(1,2);
    n=T(2,2);
    d=zeros(m1,1);
    for i=1:m1
        t=(D(i,3)+m*(D(i,1)-x0)+n*(D(i,2)-y0))/(m^2+n^2+1);
        d(i,1)=sqrt((m*t+x0-D(i,1))^2+(n*t+y0-D(i,2))^2+(t-D(i,3))^2);
    end
    d_zxd(j)=max(d);
end
zhixiandu=min(d_zxd);
end