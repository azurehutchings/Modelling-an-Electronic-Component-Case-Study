function [temperatures, flops, time, A_sparse, A_AMD_cholesky] = sparse_storage_solution(A)

    load full_storage;
    
    [A_sparse, b_sparse, reorder] = sparseStorage(A, b);

    tic;
    [A_AMD_cholesky, flops] = cholesky_sparse(A_sparse, 0);
    
    %solve with forward substitution and then backwards substitution
    
    [temperatures, flops] = forward_substitution(A_AMD_cholesky', b_sparse, flops);
    [temperatures, flops] = backward_substitution(A_AMD_cholesky, temperatures, flops);
    time = toc;
    temperatures = temperatures(reorder);

end