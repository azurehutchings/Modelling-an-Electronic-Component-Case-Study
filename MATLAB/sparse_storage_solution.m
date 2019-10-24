function [temperatures, flops, time] = sparse_storage_solution

    load full_storage;
    [A_sparse, b_sparse, reorder] = sparseStorage(A, b);

    tic;
    [A_AMD_cholesky, SparseFlops] = cholesky_sparse(A_sparse, 0);
    %solve with forward substitution and then backwards substitution
    [temperatures, SparseFlops] = forward_substitution(A_AMD_cholesky', b_sparse, SparseFlops);
    [temperatures, SparseFlops] = backward_substitution(A_AMD_cholesky, temperatures, SparseFlops);
    time = toc;
    temperatures = temperatures(reorder);
    flops = SparseFlops;

end