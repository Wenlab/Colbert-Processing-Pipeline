function delectFolderWithTheSameName(folderPath,folderName)
%fileName='head_tail_human_flip.csv'

if ~exist(folderPath, 'dir')
    error('指定的文件夹路径不存在。');
end
% 递归地搜索所有匹配的文件
filePattern = fullfile(folderPath, '**', folderName); % 构建搜索模式
fileList = dir(filePattern);
% 遍历找到的文件列表并删除每个文件
for i = 1:length(fileList)
    filePath = fullfile(fileList(i).folder, fileList(i).name);
    rmdir(filePath,'s');
    fprintf('已删除文件夹: %s\n', filePath);
end
end