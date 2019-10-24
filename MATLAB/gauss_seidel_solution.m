function [temperatures, flops, time, k, res] = gauss_seidel_solution(A)

load full_storage

[rb, c, v, x0, tol, maxiters] = CSR_Storage(A);

tic;
[temperatures, ~, k, res, flops] = gauss_seidel_CSR(rb, c', v', b, x0, tol, maxiters, 0);
time = toc;

end