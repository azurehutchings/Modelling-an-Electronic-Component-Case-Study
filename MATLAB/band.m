function A_BAND = band(A)

[~,n] = size(A);

m = bandwidth(A)+1;

A_BAND = zeros(m,n);

for i = 1:n
    for j = 1:m
        if (i + j < 34)
            A_BAND(j,i) = A(i,j+i-1);
        end
    end
end

end