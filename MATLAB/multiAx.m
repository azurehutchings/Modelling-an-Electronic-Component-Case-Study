function [A_x, flops] = multiAx(v, rb, c, x, current_flops)

n = length(rb) - 1;
A_x = zeros(n,1);

%flop count
flops = current_flops;

for i = 1:n
    %A * x
    A_x(i) = v(rb(i):(rb(i + 1) - 1)) * x(c(rb(i):(rb(i + 1) - 1)));
    flops = flops + 1; %flop count
end