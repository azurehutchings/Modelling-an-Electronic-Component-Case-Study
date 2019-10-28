function [temperatures, flops, time, k, res] = SOR_solution
% Load A and b
load full_storage

% Store A in CSR Storage
[rb, c, v, x0, tol, maxiters] = CSR_Storage(A);

% Calculating optimal value of w
w_opt = cal_w_opt(A);

tic; % start recording runtime
[temperatures, ~, k, res, flops] = sor_CSR(rb, c', v', b, x0, w_opt, tol, maxiters, 0);
time = toc; % end recording timing

end