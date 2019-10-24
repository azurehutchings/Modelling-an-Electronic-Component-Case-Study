function [temperatures, flops, time, A_packed] = packed_storage_solution(A)

    load full_storage
    
    A_packed = packed_storage(A);
    tic;
    [a, flops] = Cholesky_Packed(A_packed, 0);
    [temperatures, flops] = packed_forward_substitution(a, b, flops);
    [temperatures, flops] = packed_backward_substitution(a, temperatures, flops);
    time = toc;
end