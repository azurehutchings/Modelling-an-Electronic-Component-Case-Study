function [A_sparse, b_sparse, reorder] = sparseStorage(A, b)
% Storing matrix A in Sparse Storage

AMD = symamd(A);
A_AMD = A(AMD,AMD);
A_sparse = sparse(A_AMD);
b_sparse = b(AMD);
reorder = reorder_vector(AMD);

end