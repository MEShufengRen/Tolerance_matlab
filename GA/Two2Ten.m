function y = Two2Ten(x)
% ������תʮ��������
n = length(x);
for i = 1:n
    mu(i) = 2^(i-1);
end
mu = mu(end:-1:1);
y = sum(x.*mu);