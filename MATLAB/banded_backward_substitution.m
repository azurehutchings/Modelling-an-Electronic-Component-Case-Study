function [x, flops] = banded_backward_substitution(A, b, current_flops, divide)

if nargin == 3
    divide = true;
end

%flop count
flops = current_flops;

[n,~] = size(A);

x = b;

for i = n:-1:1
    for j = i+1:n
       if((j-i+1)<8)
           x(i) = x(i) - A(i,j-i+1) * x(j);
           flops = flops + 2;
       end
    end
    if divide
        x(i) = x(i) / A(i,1);
        flops = flops + 1;
    end
end

end