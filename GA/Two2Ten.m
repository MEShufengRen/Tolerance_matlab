function y = Two2Ten(x)
% 二进制转十进制整数
n = length(x);
for i = 1:n
    mu(i) = 2^(i-1);
end
mu = mu(end:-1:1);
y = sum(x.*mu);