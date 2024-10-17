function copy_machine_label_folders(orifolderPath, newfolderPath)
    % 检查原始路径和目标路径是否存在
    if ~isfolder(orifolderPath)
        error('原始文件夹路径不存在：%s', orifolderPath);
    end
    if ~isfolder(newfolderPath)
        mkdir(newfolderPath);
        fprintf('新文件夹路径已创建：%s\n', newfolderPath);
    end

    % 搜索所有以'_machine_label'结尾的文件夹
    folders = dir(fullfile(orifolderPath, '**/*_machine_label'));
    folders = folders([folders.isdir]);  % 确保只处理文件夹

    % 遍历找到的文件夹
    for i = 1:length(folders)
        srcFolder = fullfile(folders(i).folder, folders(i).name);
        % 计算相对于原始路径的相对路径
        relPath = strrep(srcFolder, orifolderPath, '');
        % 创建目标路径
        destFolder = fullfile(newfolderPath, relPath);
        % 如果目标文件夹不存在，则创建
        if ~isfolder(destFolder)
            mkdir(destFolder);
        end
        % 复制文件夹及其内容
        copyfile(srcFolder, destFolder);
        fprintf('已复制：%s 到 %s\n', srcFolder, destFolder);
    end
    fprintf('所有相关文件夹都已成功迁移。\n');
end
