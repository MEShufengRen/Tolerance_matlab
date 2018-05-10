function [Bias,Bias_sub,Biastol] = FinalResult(finalsolution,PartNum,part_distribute)
global K Tran
%�����ά�ȶ�Ӧ�ն���洢����
part_size=zeros(PartNum);%��ʼ���������ά��/�ڵ���Ŀ
part_size(1)=length(K{1,1});part_size(2)=length(K{1,2});%�������ά��=�նȾ���ά��=�ڵ���Ŀ*3
for i=2:PartNum-1
    part_size(i+1)=length(K{i,2});
end
for i=1:1000
    Bias = bias_simulate(finalsolution,PartNum,part_size,part_distribute); %ģ�����ƫ�
    Bias_sub=cell(PartNum-1,1);%��ʼ����װ����ƫ� 
    % ���ձ���Э��������װ����/װ����ƫ�
    temp1=Tran{1,1}*K{1,1}*Bias{1};%�Ƚ���һ��װ��
    temp2=Tran{1,2}*K{1,2}*Bias{2};
    Bias_sub{1}=K{1,3}\(temp1+temp2);
    for j=2:PartNum-1  %���ʣ��װ��
        temp1=Tran{j,1}*K{j,1}*Bias_sub{j-1};
        temp2=Tran{j,2}*K{j,2}*Bias{j+1};
        Bias_sub{j}=K{j,3}\(temp1+temp2);
    end
    Biastol=Bias_sub{end}; %��װ����ƫ�
    %��������\��װ����\װ�����ƽ���\ƽ�ж�\������
    [R(:,i),UR_tol(i),DR_tol(i),PM(:,i),PU_tol(i),PD_tol(i),PX(:,i),PX_tol(i),Profile(:,i),Profile_tol(i)] = Geometric(Bias,Biastol,PartNum);
end
%�������ָ�꣨˳����װ��˳��
PM_qualify=mean(PM,2);%����ƽ����ÿһ�д���һ�������1000��ģ���еļ���ָ��
PX_qualify=mean(PX,2);
R_qualify=mean(R,2);
Profile_qualify=mean(Profile,2);
%װ���弸��ָ��
PU_tol_qualify=mean(PU_tol);PD_tol_qualify=mean(PD_tol);
PX_tol_qualify=mean(PX_tol);
UR_tol_qualify=mean(UR_tol);DR_tol_qualify=mean(DR_tol);
Profile_tol_qualify=mean(Profile_tol);

for i=1:PartNum
    fprintf(strcat('���',num2str(i)));   
    fprintf('\n'); 
    fprintf('����ƽ��ȣ�%1.2f\n',PM_qualify(i)); 
    fprintf('����ƽ�жȣ�%1.2f\n',PX_qualify(i));
    fprintf('�����ȣ�%1.2f\n', Profile_qualify(i));
    fprintf('Բ�ȣ�%1.2f\n',2*R_qualify(i));
end
fprintf('��װ����\n');                      
fprintf('�϶���ƽ��ȣ�%1.2f\n',PU_tol_qualify);  
fprintf('�¶���ƽ��ȣ�%1.2f\n',PD_tol_qualify);
fprintf('ǰ�����ƽ�жȣ�%1.2f\n',PX_tol_qualify);
fprintf('ĸ��ֱ�߶ȣ�%1.2f\n',Profile_tol_qualify);
fprintf('ǰ��Բ�ȣ�%1.2f\n',2*UR_tol_qualify);
fprintf('���Բ�ȣ�%1.2f\n',2*DR_tol_qualify);
end