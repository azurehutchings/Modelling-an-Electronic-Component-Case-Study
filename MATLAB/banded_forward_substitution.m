function x = banded_forward_substitution(A, b, divide)

if nargin == 2
    divide = true;
end

[n,~] = size(A);

x = b;

for i = 1:n
    for j = 1:i-1
        if((i-j+1)<8)
            x(i) = x(i) - A(j,i-j+1) * x(j);
        end
    end
    if divide
        x(i) = x(i) / A(i,1);
    end
end

end