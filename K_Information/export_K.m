function Stiff = export_K(filename)
%��ȡabaqus����ĸնȾ��ļ��õ��նȾ���
k=importdata(filename);
row=k(:,1);
col=k(:,2);
val=k(:,3);
size=max(row);
temp=sparse(row,col,val,size,size);
K=full(temp);
K(6:6:end,:)=[];
K(5:5:end,:)=[];
K(4:4:end,:)=[];
K(:,6:6:end)=[];
K(:,5:5:end)=[];
K(:,4:4:end)=[];
Stiff=K;
end






























