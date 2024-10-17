function w_mean = weighted_mean(data)
w_mean = sum(data(:, 1) .* data(:, 2)) / sum(data(:, 2));
end