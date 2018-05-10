function [R,UR_tol,DR_tol,PM,PU_tol,PD_tol,PX,PX_tol,Profile,Profile_tol] = Geometric(Bias,Biastol,PartNum)%��������\��װ����\װ�����ƽ���\ƽ�ж�\������
%% ����Բ��
R=zeros(PartNum,1);%���Բ��
for i=1:PartNum
    biasUR=sqrt(Bias{i}(1:15:81*3,1).^2+Bias{i}(3:15:81*3,1).^2);
    biasDR=sqrt(Bias{i}(13:15:end,1).^2+Bias{i}(15:15:end,1).^2);
    UR=max(max(biasUR));
    DR=max(max(biasDR));
    R(i)=max(UR,DR);
end
biasUR_tol=sqrt(Biastol(1:15:316*3,1).^2+Biastol(3:15:316*3,1).^2);%װ����Բ�ȣ�ע�⣺����������㼸��ָ����Ҫָ��,�޸ģ�
biasDR_tol=sqrt(Biastol(13:15:end,1).^2+Biastol(15:15:end,1).^2);
UR_tol=max(biasUR_tol);
DR_tol=max(biasDR_tol);
%% ����ƽ���
PM=zeros(PartNum,1);%���ƽ���
biasU=cell(PartNum,1);
biasD=cell(PartNum,1);
for i=1:PartNum
    biasU{i}=Bias{i}(2:15:81*3,1);
    biasD{i}=Bias{i}(14:15:end,1);
    PU=max(biasU{i})-min(biasU{i});
    PD=max(biasD{i})-min(biasD{i});
    PM(i)=max(PU,PD);
end
biasU_tol=Biastol(2:15:316*3,1);%װ�����϶���ƽ��ȣ�ע�⣺����������㼸��ָ����Ҫָ��,�޸ģ�
PU_tol=max(biasU_tol)-min(biasU_tol);
biasD_tol=Biastol(14:15:end,1);%װ�����¶���ƽ���
PD_tol=max(biasD_tol)-min(biasD_tol);
%% ����ƽ�ж�
PX=zeros(PartNum,1);%���ƽ�ж�
for i=1:PartNum
    PX(i)=max(max(biasU{i})-min(biasD{i}),max(biasD{i})-min(biasU{i}));
end
PX_tol=max(max(biasU_tol)-min(biasD_tol),max(biasD_tol)-min(biasU_tol));%װ�������¶���ƽ�ж�
%% ����������/ĸ��ֱ�߶�
Profile=zeros(PartNum,1);%���������
for i=1:PartNum
    profile=sqrt(Bias{i}(1:3:end,1).^2+Bias{i}(2:3:end,1).^2+Bias{i}(3:3:end,1).^2);
    Profile(i)=max(profile);
end
profile_tol=sqrt(Biastol(1:3:end,1).^2+Biastol(2:3:end,1).^2+Biastol(3:3:end,1).^2);%װ����������
Profile_tol=max(profile_tol);
end

