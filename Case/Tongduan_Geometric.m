function [R,UR_tol,DR_tol,PM,PU_tol,PD_tol,PX,PX_tol,Profile,Profile_tol] = Tongduan_Geometric(Node_Bias,Node_Biastol,PartNum)%��������\��װ����\װ�����ƽ���\ƽ�ж�\������
%% ����Բ��
R=zeros(PartNum,1);%���Բ��
for i=1:PartNum
    D1=Node_Bias{i}(1:6:end,:);
    D2=Node_Bias{i}(6:6:end,:);
    R(i)=max(yd(D1),yd(D2));
end
UR=Node_Biastol(1:6:end,:);%װ����Բ�ȣ�ע�⣺����������㼸��ָ����Ҫָ��,�޸ģ�
DR=Node_Biastol(6:6:end,:);
UR_tol=yd(UR);
DR_tol=yd(DR);
%% ����ƽ���
PM=zeros(PartNum,1);%���ƽ���
for i=1:PartNum
    biasU=Node_Bias{i}(1:6:end,:);
    biasD=Node_Bias{i}(6:6:end,:);
    PM(i)=max(pmd(biasU),pmd(biasD));
end
biasU_tol=Node_Biastol(1:6:end,:);%װ�����϶���ƽ��ȣ�ע�⣺����������㼸��ָ����Ҫָ��,�޸ģ�
PU_tol=pmd(biasU_tol);
biasD_tol=Node_Biastol(6:6:end,:);%װ�����¶���ƽ���
PD_tol=pmd(biasD_tol);
%% ����ƽ�ж�
PX=zeros(PartNum,1);%���ƽ�ж�
for i=1:PartNum
    PX(i)=pxd(Node_Bias{i}(1:6:end,:),Node_Bias{i}(6:6:end,:));
end
PX_tol=pxd(Node_Biastol(1:6:end,:),Node_Biastol(6:6:end,:));%װ�������¶���ƽ�ж�
%% ����������/ĸ��ֱ�߶�
Profile=zeros(PartNum,1);%���������
for i=1:PartNum
    profile={Node_Bias{i}(1:6,:),Node_Bias{i}(49:54,:)};%����ĸ��ֱ��
    Profile(i)=zxd(profile);
end
profile_tol={Node_Biastol(1:6,:),Node_Biastol(49:54,:),Node_Biastol(97:102,:),Node_Biastol(145:150,:)};%װ����������(ѡȡ����ĸ�ߣ�
Profile_tol=zxd(profile_tol);
end

