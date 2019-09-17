function [temperatures] = sparseStorage(A, b)

AMD = symamd(A);
A_AMD = A(AMD,AMD);
A_sparse = sparse(A_AMD);
b_sparse = b(AMD);

reorder = reorder_vector(AMD);

A_AMD_cholesky = cholesky(A_AMD);

%solve with forward substitution and then backwards substitution

temperatures = forward_substitution(A_AMD_cholesky', b_sparse);
temperatures = backward_substitution(A_AMD_cholesky, temperatures);
temperatures = temperatures(reorder);

end