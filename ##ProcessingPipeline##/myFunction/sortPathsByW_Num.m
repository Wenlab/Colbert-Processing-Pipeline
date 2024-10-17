function sortedPaths = sortPathsByW_Num(pathCells)
    numbers = arrayfun(@(pathCell) extractW_NumFromPath(pathCell{1}), pathCells, 'UniformOutput', true);
    [~, sortedIdx] = sort(numbers);
    sortedPaths = pathCells(sortedIdx);
end

function w_num = extractW_NumFromPath(path)
    str = split(path, '\');
%     str = str(end);
%     str = split(str, '.');
%     str = str{1}; % 仅提取文件名部分，不包括扩展名

    w_num = regexp(str, 'w(\d+)', 'tokens');
    w_num=w_num(~cellfun(@isempty, w_num));
    if isempty(w_num) || isempty(w_num{1})
        w_num = -1; % 如果没有匹配，返回 -1
    else
        w_num=w_num(end);
        w_num = str2double(w_num{1}{1}{1}); % 将提取的字符串转换为数字
    end
end