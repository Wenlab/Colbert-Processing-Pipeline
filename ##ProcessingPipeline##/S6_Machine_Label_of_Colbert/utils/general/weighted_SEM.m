function w_SEM = weighted_SEM(data)
w_SEM = weighted_std(data)/sqrt(size(data,1));
end