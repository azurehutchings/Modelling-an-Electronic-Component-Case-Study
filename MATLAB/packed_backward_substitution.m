function [x, flops] = packed_backward_substitution(a, b, current_flops, divide)

if nargin == 3
    divide = true;
end

%flop count
flops = current_flops;

[~,n] = size(a);
n = (-1 + sqrt(1 + 8 * n))/2;
x = b;
for i = n:-1:1
    for j = i+1:n
        x(i) = x(i) - a(i+j*(j-1)/2) * x(j);
        flops = flops + 2;
    end
    if divide
       x(i) = x(i) / a(i+i*(i-1)/2);
       flops = flops + 1;
    end
end

end