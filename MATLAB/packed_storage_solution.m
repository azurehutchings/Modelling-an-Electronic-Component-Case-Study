function [temperatures, flops, time, A_packed, A_packed_chol] = packed_storage_solution

    load full_storage
    
    A_packed = packed_storage(A);
    
    tic;
    [A_packed_chol, flops] = Cholesky_Packed(A_packed, 0);
    [temperatures, flops] = packed_forward_substitution(A_packed_chol, b, flops);
    [temperatures, flops] = packed_backward_substitution(A_packed_chol, temperatures, flops);
    time = toc;
end