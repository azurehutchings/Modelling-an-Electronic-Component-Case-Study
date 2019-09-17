function A = band_cholesky(A)
[n,m] = size(A);
for i = 1:m
   for j = 1:i-1
       if j < n
           for k = 1:n
               A(i,j)
           end
       end
   end
   A(1,i) = sqrt(A(1,i));
end

end
