%匹配mcd文件与scv人工标记头尾翻转表格，并按照表格内容修改和分割mcd

close all;clear;clc;

% %loading filepath of the code.m
% cdpath = mfilename('fullpath');
% cdpath = fileparts(cdpath);
% cd(cdpath);%enter .m filepath
% addpath(genpath('..\'));

cd('E:\Nutcloud\lasio@mail.ustc.edu.cn\DATA_Wenlab\24.10.14 - WEN1145头部前端肌肉抑制光遗传\')

matfolderPath = uigetdir('Data','选择mcd组文件夹路径（mcd文件）');
scvfolderPath= uigetdir('Data\humanlable_scv\','选择scv组文件夹路径（人工标记表格）');

%默认matfolderPath和scvfolderPath下文件名结构一致，比如以w+编号命名
items = dir(matfolderPath);
folders = items([items.isdir]); % 获取所有文件夹
folders = folders(~ismember({folders.name}, {'.', '..'})); % 移除.和..

for i=1:length(folders)
    %查找mcd文件
    mcddir=dir(fullfile(matfolderPath,folders(i).name,'*mcd_corred.mat'));%必须指向唯一结果
    if ~isempty(mcddir)
        disp(mcddir.name)
        %查找scv文件
        scvdir=dir(fullfile(scvfolderPath,folders(i).name,'*Swapped.csv'));%必须指向唯一结果
        if ~isempty(scvdir)
            disp(scvdir.name)
            disp('文件对匹配成功√ 开始处理...')
            %加载文件
            load(fullfile(mcddir.folder, mcddir.name));
            loadedData = load(fullfile(mcddir.folder, mcddir.name));
            mcdname = fieldnames(loadedData);%'w1_mcd'
            mcdname = mcdname{1};
            dataTable = readtable(fullfile(scvdir.folder, scvdir.name));

            %将结尾去掉10帧（以防colbert保存时最后一帧损坏）
            dataTable.end_frame(end)=dataTable.end_frame(end)-10;

            %头尾调转
            for is=1:length(dataTable.Is_Swapped)
                Is_Swapped=dataTable.Is_Swapped(is);
                Is_Swapped=Is_Swapped{1};
                switch Is_Swapped
                    case 'TRUE'
                        for frame=dataTable.start_frame(is):dataTable.end_frame(is)
                            newHead = eval([mcdname '(' num2str(frame) ').Tail']);
                            newTail = eval([mcdname '(' num2str(frame) ').Head']);
                            newBoundaryA = reversePairs(eval([mcdname '(' num2str(frame) ').BoundaryB']));
                            newBoundaryB = reversePairs(eval([mcdname '(' num2str(frame) ').BoundaryA']));

                            eval([mcdname '(' num2str(frame) ').Head = newHead;']);
                            eval([mcdname '(' num2str(frame) ').Tail = newTail;']);
                            eval([mcdname '(' num2str(frame) ').BoundaryA = newBoundaryA;']);
                            eval([mcdname '(' num2str(frame) ').BoundaryB = newBoundaryB;']);
                        end
                        disp(['翻转头尾<' mcdname '>:第'  num2str(dataTable.start_frame(is)) '帧到第' num2str(dataTable.end_frame(is)) '帧'])
                end
            end

            %重新生成centerline
            for frame=1:length(eval(mcdname))
                eval([mcdname '(' num2str(frame) ').SegmentedCenterline = (' mcdname '(' num2str(frame) ').BoundaryA + ' mcdname '(' num2str(frame) ').BoundaryB)/2;']);
            end

            %重新分割mcd开始结束（后续生成视频时需注意）
            istartframe=dataTable.start_frame(1);
            iendframe=dataTable.end_frame(end);
            eval([mcdname ' = ' mcdname '(' num2str(istartframe) ':' num2str(iendframe) ');']);
            disp(['切割始末<' mcdname '>:第'  num2str(istartframe) '帧到第' num2str(iendframe) '帧'])

            %save
            savepath = fullfile(mcddir.folder, [mcdname '_corred_swapped.mat']);
            save(savepath,mcdname);
            disp(['saved ' mcdname '_corred_swapped.mat']);

            eval(['clear ' mcdname]);
        end
    end

end


disp('<<<END>>>')




