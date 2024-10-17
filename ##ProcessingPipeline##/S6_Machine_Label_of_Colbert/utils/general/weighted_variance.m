function w_var = weighted_variance(data)
Delta_data = data(:,1) - weighted_mean(data);
Delta_data_square = Delta_data.^2;
Delta_data_square_with_weight = [Delta_data_square data(:,2)];
w_var = weighted_mean(Delta_data_square_with_weight);
end