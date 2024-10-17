% Make some small simulations to explore the property of t test.
% You can find that, multiply a const won't change the p-value while
% nomalize to z-score will change the p-value.
%
% Yixuan Li, 2024-01-03
%

clc;clear;close all;

%%
n_sample = 40;
data_1 = randn(n_sample,1) + 10; % Random data for group 1
data_2 = randn(n_sample,1) + 10.4; % Random data for group 2 (with a different mean)
two_sample_t_test(data_1,data_2)

%%
data_1_z_score = normalization_z_score(data_1);
data_2_z_score = normalization_z_score(data_2);
two_sample_t_test(data_1_z_score,data_2_z_score)

%%
n = 10;
two_sample_t_test(n*data_1,n*data_2)

%%
n = 1/10;
two_sample_t_test(n*data_1,n*data_2)

%%
n = 1/100;
two_sample_t_test(n*data_1,n*data_2)