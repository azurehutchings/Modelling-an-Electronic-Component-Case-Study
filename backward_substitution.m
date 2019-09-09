function X = backward_substitution(A, B, divide)

if nargin == 2
    divide = true;
end

[m,n] = size(A);

X = B;

for i = n:-1:1
    for j = i+1:n
        X(i,:) = X(i,:) - A(i,j) * X(j,:);
    end
    if divide
        X(i,:) = X(i,:) / A(i,i);
    end
end

end