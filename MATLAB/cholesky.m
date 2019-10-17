function [A, flops] = cholesky(A, current_flops)
[n,~] = size(A);

flops = current_flops;

for j = 1:n
    for i = 1:j-1
        for k = 1:i-1
            A(i,j) = A(i,j) - A(k,i) * A(k,j);
            flops = flops + 2;
        end
        A(i,j) = A(i,j) / A(i,i);
        A(j,j) = A(j,j) - A(i,j)^2;
        flops = flops + 3;
    end
    A(j,j) = sqrt(A(j,j));
    flops = flops + 1;
end
