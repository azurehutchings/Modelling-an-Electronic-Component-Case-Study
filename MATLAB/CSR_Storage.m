function [rb, c, v, x0, tol, maxiters] = CSR_Storage(A)

[r,c,v] = find(A);
[r_sorted,order] = sort(r);
c = c(order);
v = v(order);

r_current = r_sorted(1);
count = 0;
rb = 1;

for i = 1:length(r_sorted)
    count = count + 1;
    if (r_sorted(i) ~= r_current)
        rb = [rb, count];
        r_current = r_sorted(i);
    end
end

% rb ends with nz + 1, where nz is the total number of nonzero elements in A.
rb = [rb, count + 1];

n = size(A, 1);
x0 = ones(n, 1)*10;
tol = 1e-5;
maxiters = 1000;

end
