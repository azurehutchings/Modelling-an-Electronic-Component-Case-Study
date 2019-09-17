function x = packed_backward_substitution(a, b, divide)

if nargin == 2
    divide = true;
end

[~,n] = size(a);
n = (-1+sqrt(1+8*n))/2;
x = b;
for i = n:-1:1
    for j = i+1:n
        x(i) = x(i) - a(i+j*(j-1)/2) * x(j);
    end
    if divide
       x(i) = x(i) / a(i+i*(i-1)/2);
    end
end

end