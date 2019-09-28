function A = cholesky_band(A)
[n,~] = size(A);
for j = 1:n
    for i = 1:j-1
        for k = 1:i-1
            if((j-i+1)<8 && (i-k+1)<8 && (j-k+1)<8)
                A(i,j-i+1) = A(i,j-i+1) - A(k,i-k+1) * A(k,j-k+1);
            end
        end
        if((j-i+1)<8)
            A(i,j-i+1) = A(i,j-i+1) / A(i,1);
            A(j,1) = A(j,1) - A(i,j-i+1)^2;
        end
    end
    A(j,1) = sqrt(A(j,1));
end
