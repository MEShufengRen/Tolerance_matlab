function pp_pmd=pmd(D)%ƽ��ȼ���
[m,~]=size(D);
%ƽ�淨����
p=pinv(D)*ones(m,1);
pp=zeros(m,1);
for i=1:m
    pp(i,1)=(D(i,:)*p-1)/(sqrt(p'*p));
end
pp_pmd=max(pp)-min(pp);
end