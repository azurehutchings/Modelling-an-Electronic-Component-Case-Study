function [X, flops] = forward_substitution(A, B, current_flops, divide)

if nargin == 3
    divide = true;
end

[~,n] = size(A);

X = B;

%flop count
flops = current_flops; 

for i = 1:n
    for j = 1:i-1
        X(i,:) = X(i,:) - A(i,j) * X(j,:);
        flops = flops + 2;
    end
    if divide
        X(i,:) = X(i,:) / A(i,i);
        flops = flops + 1;
    end
end

end