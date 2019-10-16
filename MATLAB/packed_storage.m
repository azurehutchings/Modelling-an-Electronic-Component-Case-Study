function a = packed_storage(A)
[~,n] = size(A);
a = zeros(1,nchoosek(n + 1,2));
for j = 1:n
    for i = 1:j
       a(i + j * (j - 1)/2) = A(i,j);
    end
end
