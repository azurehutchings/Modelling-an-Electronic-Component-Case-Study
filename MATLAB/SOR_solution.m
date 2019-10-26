function [temperatures, flops, time, k, res] = SOR_solution

load full_storage

[rb, c, v, x0, tol, maxiters] = CSR_Storage(A);

D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);
T_J = - (D \ (L + U));
rhoT_J = max(abs(eig(T_J)));
w_opt = (2 /(1 + sqrt(1 - rhoT_J^2)));

tic;
[temperatures, ~, k, res, flops] = sor_CSR(rb, c', v', b, x0, w_opt, tol, maxiters, 0);
time = toc;

end