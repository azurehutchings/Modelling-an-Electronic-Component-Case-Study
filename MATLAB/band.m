function A_BAND = band(A)

[n,~] = size(A);

m = bandwidth(A)+1;

A_BAND = zeros(n,m);

for i = 1:n
    for j = 1:m
        if (i + j < 35)
            A_BAND(i,j) = A(i,j+i-1);
        end
    end
end

end