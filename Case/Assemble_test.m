function pop= Assemble_test(Part_sort,generation,part_distribute,Index_Geometry)
% Part_sort��ʾ������� range��̬�ֲ�ģ��ƫ��ķ�Χ generation ��Ⱥ��������
% part_distribute�ǰ���װ��˳����������ֲ�����[1,3,2,2,3,1,4,4]��ʾ�������� 1-��� 2-Ͳ�� 3-Y�ͻ� 4-�̿�
tic
warning('off')
global Index
Index=Index_Geometry;
%% ��ȡ�ڵ�������Ϣ�͸նȾ���
K_Path_tol='C:\Users\Shufeng Ren\Desktop\V2_td_Test\K_Information\Assemble_STIF'; %���봢��ն����ļ���λ��
Node_Path_tol='C:\Users\Shufeng Ren\Desktop\V2_td_Test\K_Information\Assemble_Node'; %���봢��ڵ��������ļ���λ��
global K Tran Node_Coordinate
[K,Tran,Node_Coordinate,FileNum_tol]=information(K_Path_tol,Node_Path_tol);%����նȾ����ת������FileNum_tol��ʾװ�����
PartNum=FileNum_tol+1;%�õ����������װ�����+1��=ģ��ƫ�����
Simulate_para=Part_sort;%ÿ�����ʹ��1����̬�ֲ���׼�����ģ��ƫ�
pop.size = 200;%��Ⱥ��ģ
pop.cr = 0.6;%�������
range=max(Index_Geometry); %�޶���̬�ֲ�������Χ(0.5~0.5+range)
pop = initialization(pop,Simulate_para,range,PartNum,part_distribute);%��ʼ����Ⱥ
for i = 1:generation %�Ŵ�����
    pop = newPop(pop,Simulate_para,range,PartNum,part_distribute);%������һ����Ⱥ   
end
if max(abs(pop.bestSolution(end,:)-pop.bestSolution(end-1,:)))<0.1 %�����Ƿ�����
    fprintf('���Ž���Ϻ�\n');
else
    fprintf('���Ž����̫��\n');
end
finalsolution=pop.bestSolution(end,:);
FinalResult(finalsolution,PartNum,part_distribute); %������
toc
end