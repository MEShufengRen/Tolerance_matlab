function pp_pxd=pxd(D1,D2)%ƽ�жȼ���
%����1��ϻ�׼��
[m1,~]=size(D1);
%ƽ�淨����
p=pinv(D1)*ones(m1,1);
%����2�ϵ㵽��1�ľ���
[m2,~]=size(D2);
pp=zeros(m2,1);
for i=1:m2
    pp(i,1)=(D2(i,:)*p-1)/(sqrt(p'*p));
end
pp_pxd=max(pp)-min(pp);
end