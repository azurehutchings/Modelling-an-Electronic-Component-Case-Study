function [temperatures, flops, time, A_sparse, A_AMD_cholesky] = sparse_storage_solution
% Solving Sparse Storage using Cholesky, Forwards and Backwards
% Substitution

% Loading A and b
load full_storage;

% Store A in Sparse Storage
[A_sparse, b_sparse, reorder] = sparseStorage(A, b);

tic; % start recording runtime
[A_AMD_cholesky, flops] = cholesky_sparse(A_sparse, 0);

% Solve with forward substitution and then backwards substitution
[temperatures, flops] = forward_substitution(A_AMD_cholesky', b_sparse, flops);
[temperatures, flops] = backward_substitution(A_AMD_cholesky, temperatures, flops);
time = toc; % stop recording runtime

% Reorder Temperatures
temperatures = temperatures(reorder);

end