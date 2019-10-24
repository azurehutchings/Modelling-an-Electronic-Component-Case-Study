function [temperatures, flops, time] = full_storage_solution(A)
    load full_storage

    %Solving using cholesky factorisation, then forward and backward substitution
    tic;
    [A_cholesky, FullStorageFlops] = cholesky(A, 0);
    [temperatures, FullStorageFlops] = forward_substitution(A_cholesky', b, FullStorageFlops);
    [temperatures, FullStorageFlops] = backward_substitution(A_cholesky, temperatures, FullStorageFlops);
    time = toc;
    flops = FullStorageFlops;
end