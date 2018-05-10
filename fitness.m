function fit= fitness(x,PartNum,part_distribute)
global K Tran
%�����ά�ȶ�Ӧ�ն���洢����
part_size=zeros(PartNum);%��ʼ���������ά��/�ڵ���Ŀ
part_size(1)=length(K{1,1});part_size(2)=length(K{1,2});%�������ά��=�նȾ���ά��=�ڵ���Ŀ*3
for i=2:PartNum-1
    part_size(i+1)=length(K{i,2});
end
fit=zeros(size(x,1),1);%��ʼ����Ⱥ��size(x,1)�����壩����Ӧ��ֵ
for i = 1:size(x,1)
    a = x(i,:);
    Bias = bias_simulate(a,PartNum,part_size,part_distribute); %ģ�����ƫ�
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
   [R,UR_tol,DR_tol,PM,PU_tol,PD_tol,PX,PX_tol,Profile,Profile_tol] = Geometric(Bias,Biastol,PartNum);
    % ����˴�ƫ��µ���Ӧ�Ⱥ���,��Ϊ����ָ��,fitΪ��Ӧ��
    a=1.6;   %�ӹ��ɱ�ϵ��  %     a1=1.6;a2=0.3;a3=2.0;a4=1.0;   %�ӹ��ɱ�ϵ��
    b=1.2;   %����ɱ�ϵ��  %     b1=1.2;b2=0.2;b3=1.6;b4=0.5;   %����ɱ�ϵ��
    c=1.2;   %������ʧϵ��  %     c1=1.2;c2=0.2;c3=1.6;c4=0.5;   %������ʧϵ��
    if PU_tol<=3 && PD_tol<=3 && PX_tol<=3 && UR_tol<=3 && DR_tol<=3 && Profile_tol<=3 %װ�����Ƿ�����Ҫ��,װ��������Ҫ�󣿣�ѡ����������Ƿ�����Ҫ��
        xp=zeros(PartNum,1);       %��ʼ�������������
        eval_PM=0;                 %��ʼ����Ӧ�Ⱥ��������֣��ӹ��ɱ�������ɱ���������ʧ��
        eval_xp=0;
        eval_profile=0;
        for k=1:PartNum
            if Profile(k)>=0.5     %���������������
                xp(k)=0;
            else
                xp(k)=0.5-Profile(k);
            end
            eval_PM=a/PM(k)+eval_PM;
            eval_xp=b*sqrt(xp(k))+eval_xp;
            eval_profile=c/4*sqrt(Profile(k))+eval_profile;
        end
        fit(i)=eval_PM+eval_xp+eval_profile;
    else
        fit(i)=20;
    end
    fit(i)=21-fit(i); %Ŀ�꺯��ֵС����Ӧ�ȴ�
end
end