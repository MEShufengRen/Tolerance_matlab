function [R,UR_tol,DR_tol,PM,PU_tol,PD_tol,PX,PX_tol,Profile,Profile_tol] = Assemble_Geometric(Node_Bias,Node_Biastol,PartNum)%��������\��װ����\װ�����ƽ���\ƽ�ж�\������
%% ����Բ��
R=zeros(PartNum,1);%���Բ��
for i=1:PartNum
    D1=Node_Bias{i}(1:1:16,:);
    D2=Node_Bias{i}(end-15:1:end,:);
    R(i)=max(yd(D1),yd(D2));
end
UR=Node_Biastol(305:1:320,:);%װ����Բ�ȣ�ע�⣺����������㼸��ָ����Ҫָ��,�޸ģ�
DR=Node_Biastol(end-15:1:end,:);
UR_tol=yd(UR);
DR_tol=yd(DR);
%% ����ƽ���
PM=zeros(PartNum,1);%���ƽ���
for i=1:PartNum
    biasU=Node_Bias{i}(1:1:16,:);
    biasD=Node_Bias{i}(end-15:1:end,:);
    PM(i)=max(pmd(biasU),pmd(biasD));
end
biasU_tol=Node_Biastol(305:1:320,:);%װ�����϶���ƽ��ȣ�ע�⣺����������㼸��ָ����Ҫָ��,�޸ģ�
PU_tol=pmd(biasU_tol);
biasD_tol=Node_Biastol(end-15:1:end,:);%װ�����¶���ƽ���
PD_tol=pmd(biasD_tol);
%% ����ƽ�ж�
PX=zeros(PartNum,1);%���ƽ�ж�
for i=1:PartNum
    PX(i)=pxd(Node_Bias{i}(1:1:16,:),Node_Bias{i}(end-15:1:end,:));
end
PX_tol=pxd(Node_Biastol(305:1:320,:),Node_Biastol(end-15:1:end,:));%װ�������¶���ƽ�ж�
%% ����������/ĸ��ֱ�߶�
Profile=zeros(PartNum,1);%���������
for i=[3,4,7,8]
    profile={Node_Bias{i}(1:16:end,:),Node_Bias{i}(5:16:end,:),Node_Bias{i}(9:16:end,:),Node_Bias{i}(13:16:end,:)};%����ĸ��ֱ��
    Profile(i)=zxd(profile{1});
end
profile_tol={Node_Biastol(65:16:225,:),Node_Biastol(69:16:229,:),Node_Biastol(73:16:233,:)};%װ����������(ѡȡ����ĸ�ߣ�
Profile_tol=zxd(profile_tol{1});
end

