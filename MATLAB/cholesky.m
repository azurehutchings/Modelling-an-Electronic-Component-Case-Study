function A = cholesky(A)
[n,m] = size(A);
for j = 1:n
    for i = 1:j-1
        for k = 1:i-1
            A(i,j) = A(i,j) - A(k,i) * A(k,j);
        end
        A(i,j) = A(i,j) / A(i,i);
        A(j,j) = A(j,j) - A(i,j)^2;
    end
    A(j,j) = sqrt(A(j,j));
end
