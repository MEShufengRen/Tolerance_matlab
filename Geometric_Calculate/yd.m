function dr=yd(D)%���Բ��
%��ϻ�׼ƽ��
[m,~]=size(D);
%ƽ�淨����
p=pinv(D)*ones(m,1);
A=p(1,1);
B=p(2,1);
C=p(3,1);
%��㵽ƽ���ϵ�ͶӰ
DD=[];
for i=1:m
    T=[A B C;-B A 0;0 C -B];
    L=[-1;A*D(i,2)-B*D(i,1);C*D(i,2)-B*D(i,3)];
    DD(i,:)=(inv(T)*L)';
end
%��С�������Բ�ĺͰ뾶
B0=[];
TT=[];
for i=1:m
    B0(i,1)=-(DD(i,1)^2+DD(i,2)^2+DD(i,3)^2)-2/C*DD(i,3);
    TT(i,:)=[DD(i,1)-A/C*DD(i,3) DD(i,2)+B/C*DD(i,3) 1];
end
qq=pinv(TT)*B0;
M=qq(1,1);
N=qq(2,1);
G=qq(3,1);
x0=-M/2;
y0=-N/2;
z0=(A*M/2-B*N/2-1)/C;
R=sqrt(x0^2+y0^2+z0^2-G);
%��Բ��
RR=[];
for i=1:m
    RR(i,1)=sqrt((DD(i,1)-x0)^2+(DD(i,2)-y0)^2+(DD(i,3)-z0)^2)-R;
end
dr=max(RR)-min(RR);
end
    
