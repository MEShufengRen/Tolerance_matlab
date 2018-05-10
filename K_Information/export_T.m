function [Tran1,Tran2]=export_T(filename1,filename2,filename12,K1,K2,K12)
m=importdata(filename1);
P1B=m(:,2:4);
m=importdata(filename2);
P2B=m(:,2:4);
m=importdata(filename12);
P12B=m(:,2:4);


P1BB=P1B;
P2BB=P2B;
P12BB=P12B;

[m1,~]=size(P12BB);
[m,~]=size(P1BB);
t1=[];
a=1;
for i=1:m
    aa=P1BB(i,:);    
     for i2=1:m1
        b(i2,1)=norm(P12BB(i2,1:3)-aa,2);
    end
    [i1,~]=find(b<=10e-3);
    if isempty(i1)
    else
    t1(a,1)=i1;
	a=a+1;
    end    
end

[m,~]=size(P2BB);
t2=[];
a=1;
for i=1:m
    aa=P2BB(i,:);
    for i2=1:m1
        b(i2,1)=norm(P12BB(i2,1:3)-aa,2);
    end
    [i1,~]=find(b<=10e-3);
    if isempty(i1)
    else
    t2(a,1)=i1;
	a=a+1;
    end  
end

[m1,~]=size(K1);
[m2,~]=size(K2);
[m3,~]=size(K12);

T1=zeros(m3,m1);
[m,~]=size(t1);
TT1=mat2cell(T1,3*ones(1,m3/3),3*ones(1,m1/3));
for i=1:m
    TT1{t1(i,1),i}=eye(3,3);
end
Tran1=cell2mat(TT1);

T2=zeros(m3,m2);
[m,~]=size(t2);
TT2=mat2cell(T2,3*ones(1,m3/3),3*ones(1,m2/3));
for i=1:m
    TT2{t2(i,1),i}=eye(3,3);
end
Tran2=cell2mat(TT2);

