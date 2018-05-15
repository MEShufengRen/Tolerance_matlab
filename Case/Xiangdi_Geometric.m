function [R,UR_tol,DR_tol,PM,PU_tol,PD_tol,PX,PX_tol,Profile,Profile_tol] = Xiangdi_Geometric(Node_Bias,Node_Biastol,PartNum)%��������\��װ����\װ�����ƽ���\ƽ�ж�\������
%% ����Բ��
R=zeros(PartNum,1);%���Բ��
for i=1:PartNum
    D1=Node_Bias{i}(1:5:end,:);
    D2=Node_Bias{i}(5:5:end,:);
    R(i)=max(yd(D1),yd(D2));
end
UR=Node_Biastol(1:5:end,:);%װ����Բ�ȣ�ע�⣺����������㼸��ָ����Ҫָ��,�޸ģ�
DR=Node_Biastol(5:5:end,:);
UR_tol=yd(UR);
DR_tol=yd(DR);
%% ����ƽ���
PM=zeros(PartNum,1);%���ƽ���
for i=1:PartNum
    biasU=Node_Bias{i}(1:5:end,:);
    biasD=Node_Bias{i}(5:5:end,:);
    PM(i)=max(pmd(biasU),pmd(biasD));
end
biasU_tol=Node_Biastol(1:5:end,:);%װ�����϶���ƽ��ȣ�ע�⣺����������㼸��ָ����Ҫָ��,�޸ģ�
PU_tol=pmd(biasU_tol);
biasD_tol=Node_Biastol(5:5:end,:);%װ�����¶���ƽ���
PD_tol=pmd(biasD_tol);
%% ����ƽ�ж�
PX=zeros(PartNum,1);%���ƽ�ж�
for i=1:PartNum
    PX(i)=pxd(Node_Bias{i}(1:5:end,:),Node_Bias{i}(5:5:end,:));
end
PX_tol=pxd(Node_Biastol(1:5:end,:),Node_Biastol(5:5:end,:));%װ�������¶���ƽ�ж�
Profile=zeros(PartNum,1);Profile_tol=0;
end

