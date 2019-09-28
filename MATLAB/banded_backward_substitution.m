function x = banded_backward_substitution(A, b, divide)

if nargin == 2
    divide = true;
end

[n,~] = size(A);

x = b;

for i = n:-1:1
    for j = i+1:n
       if((j-i+1)<8)
           x(i) = x(i) - A(i,j-i+1) * x(j);
       end
    end
    if divide
        x(i) = x(i) / A(i,1);
    end
end

end