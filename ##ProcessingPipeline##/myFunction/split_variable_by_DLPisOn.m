function split_variable_by_DLPisOn(variable)
    % 假设你的变量是一个结构体或者表格，其中包含'DLPisOn'属性
    % 如果你的变量是一个矩阵或其他类型的数据结构，你可能需要适当调整代码
    
    % 获取变量名
    varname = inputname(1);
    
    % 获取 DLPisOn 列
    n = length(variable); % 变量的长度
    for i = 1:n
        DLPisOn(i) = variable(i).DLPisOn;
    end

    % 初始化片段的开始索引和结束索引
    startIdx = 1;

    % 遍历 DLPisOn 列，找到值变化的地方
    for i = 2:n
        if DLPisOn(i) ~= DLPisOn(i - 1)
            % 当 DLPisOn 值发生变化时，将前面的片段提取出来
            endIdx = i - 1;
            extract_and_rename(variable, varname,startIdx, endIdx, DLPisOn(startIdx));
            startIdx = i; % 更新下一个片段的开始索引
        end
    end

    % 处理最后一个片段
    extract_and_rename(variable, varname, startIdx, n, DLPisOn(startIdx));
end

function extract_and_rename(variable, varname, startIdx, endIdx, DLPisOn_value)
    % 提取片段
    segment = variable(startIdx:endIdx);

    % 生成新的变量名
    new_var_name = sprintf('%s_%d_%d_DLP_%d', varname, startIdx, endIdx, DLPisOn_value);

    % 将片段保存为新的变量
    assignin('base', new_var_name, segment);

    % 显示生成的变量名，方便用户检查
    fprintf('Created variable: %s\n', new_var_name);
end
