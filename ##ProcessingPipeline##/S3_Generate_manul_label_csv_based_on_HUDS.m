%跟据HUDS视频文件生成人工标记表格
clear;clc;close all;
warning off;

path=uigetdir('data');

%新生成的scv表格会在选定路径上创建一个新的文件进行保存
newpath = fullfile(path,'humanlable_scv');
if ~exist(newpath, 'dir')
    mkdir(newpath);
end

list = GetAllSubfolderFilename(path,'*HUDS.avi');%get the target files name list by traversing all the subfolders
list = sortPathsByW_Num(list);

indx=[];

indx = listdlg('ListString',list,'ListSize',[650,150],...
    'Name','correct axis','SelectionMode','multiple');


for i = 1:length(indx)
    
    [~, fileName, ~] = fileparts(list(indx(i)));
    
    % 找到"HUDS"前的字符串内容
    idx = strfind(fileName, 'HUDS');
    baseName = fileName(1:idx-1);
    
    % 在字符串后添加指定内容
    newName = [baseName, 'Manul_label_Head_and_the_Tail_Swapped'];
    
    % 使用正则表达式匹配文件名中的字符串片段
    expression = 'w(\d{1,2})';
    tokens = regexp(baseName, expression, 'tokens');
    
    % 如果匹配到字符串片段
    if ~isempty(tokens)
        % 提取数字部分
        numStr = tokens{1}{1};
        % 创建子文件夹
        subFolder = fullfile(newpath, ['w', numStr]);
        if ~exist(subFolder, 'dir')
            mkdir(subFolder);
        end
    else
        error('Can not find wormnum (like "w1") in file name')
    end
    
    % 创建 .csv 表格
    filePath = fullfile(subFolder, [newName '.csv']);
    fid = fopen(filePath, 'w');
    
    % 在表格中写入指定内容
    fprintf(fid, 'start_frame,end_frame,Is_Swapped\n');
    fprintf(fid, '1,,FALSE\n');
    fprintf(fid, ',,TRUE\n');
    
    fclose(fid);
    disp(['已创建文件：' filePath]);
    
end


disp('<<<End>>>');