%get all yaml2matlab by chosing a filepath (include all subfolders)
clear;clc;close all;
warning off;

% %loading filepath of the code.m
% cdpath = mfilename('fullpath');
% cdpath = fileparts(cdpath);
% cd(cdpath);%enter .m filepath 
% addpath(genpath('..\'));

cd('D:\Nutcloud\lasio@mail.ustc.edu.cn\DATA_Wenlab\24.10.14 - WEN1145头部前端肌肉抑制光遗传\');

%chose the folder to analyze
path=uigetdir('data');

%get .yaml file location
list = GetAllSubfolderFilename(path,'*.yaml');

[indx,tf] = listdlg('ListString',list,'ListSize',[500,200],...
    'Name','Chose files to convert');%选择对话框

%Read .yaml
if tf==1
    for i = indx
        fname = list{i};
        [wormfilename,w_num] = GetLastFilenameWithoutExtension(fname);
        wormnum=['w' num2str(w_num)];
        disp([wormfilename '.yaml ==> ' wormnum '_mcd.mat']);

        mcd = Mcd_Frame;
        mcd = mcd.yaml2matlab(fname);
        %most time-consuming step
        eval([wormnum '_mcd = mcd;']);

        savepath = fullfile(GetFileUpperLevelDirectory(fname),[wormnum '_mcd.mat']);%保存到同目录下
        save(savepath,[wormnum '_mcd']);

    end
end

disp('<<<END>>>');
