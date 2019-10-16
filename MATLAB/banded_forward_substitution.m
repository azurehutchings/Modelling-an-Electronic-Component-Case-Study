function [x, flops] = banded_forward_substitution(A, b, current_flops, divide)

if nargin == 3
    divide = true;
end

flops = current_flops;

[n,~] = size(A);

x = b;

for i = 1:n
    for j = 1:i-1
        if((i-j+1)<8)
            x(i) = x(i) - A(j,i-j+1) * x(j);
            flops = flops + 2;
        end
    end
    if divide
        x(i) = x(i) / A(i,1);
        flops = flops + 1;
    end
end

end