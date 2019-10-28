function p = reorder_vector(b)
%Takes a reordering vector and outputs the reverse reordering vector
[~,n] = size(b);
p = zeros(n,1);
for i = 1:n
    p(b(i)) = i;
end

end