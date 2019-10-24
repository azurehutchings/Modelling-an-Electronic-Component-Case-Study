function [temperatures, flops, time] = packed_storage_solution

    load full_storage
    A_packed = packed_storage(A);
    tic;
    [a, PackedFlops] = Cholesky_Packed(A_packed, 0);
    [temperatures, PackedFlops] = packed_forward_substitution(a, b, PackedFlops);
    [temperatures, PackedFlops] = packed_backward_substitution(a, temperatures, PackedFlops);
    time = toc;
    flops = PackedFlops;
end