function [K,Tran,Node_Coordinate,FileNum_tol]=information(K_Path_tol,Node_Path_tol)
%% 将刚度矩阵按照装配顺序存入胞元数组
List_tol=dir(K_Path_tol);
FileNum_tol=size(List_tol,1)-2;
K=cell(FileNum_tol,3);
for i=1:FileNum_tol
    path=strcat(K_Path_tol,'\',List_tol(i+2).name);
    list=dir(path);
    for j=3:size(list,1)
        Name=list(j).name;
        Name=strcat(path,'\',Name);
        K{i,j-2}=export_K(Name);
    end 
end
%% 将转换矩阵矩阵按照装配顺序存入胞元数组,输出各个零件节点坐标矩阵
List_tol=dir(Node_Path_tol);
FileNum_tol=size(List_tol,1)-2;
Tran=cell(FileNum_tol,2);
Node_Coordinate=cell(FileNum_tol,3);
for i=1:FileNum_tol
    path=strcat(Node_Path_tol,'\',List_tol(i+2).name);
    list=dir(path);
    Name1=strcat(path,'\',list(3).name);Name2=strcat(path,'\',list(4).name);Name3=strcat(path,'\',list(5).name);
    [Tran{i,1},Tran{i,2},Node_Coordinate{i,1},Node_Coordinate{i,2},Node_Coordinate{i,3}]=export_T(Name1,Name2,Name3,K{i,1},K{i,2},K{i,3});
end