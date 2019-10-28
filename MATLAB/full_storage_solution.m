function [temperatures, flops, time, A_cholesky] = full_storage_solution
    load full_storage

    %Solving using cholesky factorisation, then forward and backward substitution
    tic;
    [A_cholesky, flops] = cholesky(A, 0);
    [temperatures, flops] = forward_substitution(A_cholesky', b, flops);
    [temperatures, flops] = backward_substitution(A_cholesky, temperatures, flops);
    time = toc;
end