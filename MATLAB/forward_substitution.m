function X = forward_substitution(A, B, divide)

if nargin == 2
    divide = true;
end

[m,n] = size(A);

X = B;

for i = 1:n
    for j = 1:i-1
        X(i,:) = X(i,:) - A(i,j) * X(j,:);
    end
    if divide
        X(i,:) = X(i,:) / A(i,i);
    end
end

end