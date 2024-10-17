function [weighted_mean, weighted_std] = weighted_mean_std(index, duration)
    % index: 每个个体的指数值
    % duration: 每个个体的数据时长

    % 计算权重
    weights = duration / sum(duration);

    % 计算加权均值
    weighted_mean = sum(index .* weights);

    % 计算加权标准差
    weighted_std = sqrt(sum(weights .* (index - weighted_mean).^2));
end
