function reversedArray = reversePairs(inputArray)
% 检查输入矩阵是否是1xN的向量
if ~isvector(inputArray)
    error('输入必须是一个1xN的向量。');
end

% 检查元素数量是否是偶数
if mod(numel(inputArray), 2) ~= 0
    error('元素数量必须是偶数，以便可以成对反转。');
end

% 重构矩阵为2x(N/2)
reshapedArray = reshape(inputArray, 2, []);

% 沿第二维度（列）进行反转
reshapedArray = fliplr(reshapedArray);

% 将矩阵展平为1xN
reversedArray = reshape(reshapedArray, 1, []);
end
