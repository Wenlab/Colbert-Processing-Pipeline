%Fix the problem of positive and negative coordinates
clear;clc;close all;
warning off;

% %loading filepath of the code.m
% cdpath = mfilename('fullpath');
% cdpath = fileparts(cdpath);
% cd(cdpath);%enter .m filepath
% addpath(genpath('..\'));

path=uigetdir('data');

list = GetAllSubfolderFilename(path,'*_mcd.mat');%get the target files name list by traversing all the subfolders
list = sortPathsByW_Num(list);

indx=[];

indx = listdlg('ListString',list,'ListSize',[650,150],...
    'Name','correct axis','SelectionMode','multiple');


for i = 1:length(indx)
    
    indxi = indx(i);
    fname=list{indxi};
    [fileoriname,w_num] = GetLastFilenameWithoutExtension(fname);
    orifilepath = GetFileUpperLevelDirectory(fname);
    
    disp(['loading ' fileoriname ' , plz wait...']);
    load(list{indxi});
    disp('loading finished.');
    
    eval(['mcdi=' fileoriname ';']);
    eval(['maxframe = length(' fileoriname ');']);
    
    for j=1:maxframe
        mcdi(j).Head(2)=-mcdi(j).Head(2);
        mcdi(j).Tail(2)=-mcdi(j).Tail(2);
        mcdi(j).BoundaryA(2:2:200)=-mcdi(j).BoundaryA(2:2:200);
        mcdi(j).BoundaryB(2:2:200)=-mcdi(j).BoundaryB(2:2:200);
        mcdi(j).SegmentedCenterline(2:2:200)=-mcdi(j).SegmentedCenterline(2:2:200);
        mcdi(j).StageFeedbackTarget(2)=-mcdi(j).StageFeedbackTarget(2);%小视野坐标
        mcdi(j).StagePosition(1)=-mcdi(j).StagePosition(1);
        
    end
    
    
    eval(['clear ' fileoriname]);
    eval([fileoriname '=mcdi;']);
    
    disp('saving new mcd...');
    
    savepath=fullfile(orifilepath,[fileoriname,'_corred.mat']);
    
    save(savepath,fileoriname);
    
    disp(['saved ' fileoriname '_corred.mat'  '   (' num2str(i) '/' num2str(length(indx)) ')']);
    
end

disp('<<<End>>>');