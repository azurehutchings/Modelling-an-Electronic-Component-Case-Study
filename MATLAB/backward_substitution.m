function [X, flops] = backward_substitution(A, B, current_flops, divide)

if nargin == 3
    divide = true;
end

%flop count
flops = current_flops;

[~,n] = size(A);

X = B;

for i = n:-1:1
    for j = i+1:n
        X(i,:) = X(i,:) - A(i,j) * X(j,:);
        flops = flops + 2;
    end
    if divide
        X(i,:) = X(i,:) / A(i,i);
        flops = flops + 1;
    end
end

end