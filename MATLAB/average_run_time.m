average_run_time = [0, 0, 0, 0, 0]; %Average runtime 


for i = 1:1000
    load full_storage;
    %Solving using cholesky factorisation, then forward and backward substitution
    tic;
    [A_cholesky, FullStorageFlops] = cholesky(A, 0);
    [temperatures, FullStorageFlops] = forward_substitution(A_cholesky', b, FullStorageFlops);
    [temperatures, FullStorageFlops] = backward_substitution(A_cholesky, temperatures, FullStorageFlops);
    Cholesky_Full_Storage_Runtime = toc;
    average_run_time(1) = average_run_time + Cholesky_Full_Storage_Runtime;

end

average_run_time./1000;