% 使用Machine_Label_of_Colbert后重构文件夹，将生成的内容移动到新的位置，以保证文件夹的独立

close all;clear;clc;

%loading filepath of the code.m
cdpath = mfilename('fullpath');
cdpath = fileparts(cdpath);
cd(cdpath);%enter .m filepath
addpath(genpath('..\'));

orifolderPath = uigetdir('','选择原始文件夹路径');
newfolderPath = uigetdir('','选择新建文件夹路径');

%删除多余文件
fileName1='head_tail_human_flip.csv';
delectFileWithTheSameName(orifolderPath,fileName1);
fileName2='*_mcd_corred_swapped.txt';
delectFileWithTheSameName(orifolderPath,fileName2);

%复制文件夹到新的目录下
copy_machine_label_folders(orifolderPath, newfolderPath);

%删除原目录下的文件夹
folderName='*_mcd_corred_swapped_machine_label';
delectFolderWithTheSameName(orifolderPath,folderName);

disp('<<<END>>>')
