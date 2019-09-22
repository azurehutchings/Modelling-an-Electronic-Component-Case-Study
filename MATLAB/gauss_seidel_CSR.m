function [x, converged, k, res_total] = gauss_seidel_CSR(rb, c, v, b, x0, tol, maxiters)
% JACOBI Jacobi method
% [x, converged, k] = jacobi(A, b, x0, tol, maxiters) performs Jacobi
% iteration iteration to solve A*x=b, starting with x = x0 and iterating
% until either the number of iterations k equals maxiters, or until
% norm(b-A*x)/norm(b) <= tol. The value of converged is true if the method
% converged, or false otherwise.

%% Initialise
n = length(rb) - 1;
k = 0;
x = x0;
A_x = zeros(n,1);
normb = norm(b);
for i = 1:n
    A_x(i) = v(rb(i):(rb(i + 1) - 1)) * x(c(rb(i):(rb(i + 1) - 1)));
end
res = norm(b - A_x) / normb;
res_total = res;

%% Perform the iteration until res <= tol or maximum iterations taken
while res > tol && k < maxiters
    for i = 1:n
        x(i) = b(i);
        for j = rb(i):(rb(i + 1) - 1)
            if c(j) ~= i
               x(i) = x(i) - v(j) * x(c(j));
            else
                center = j;
            end
        end
        x(i) = x(i) / v(center);
    end
    k = k + 1;
    for i = 1:n
        A_x(i) = v(rb(i):(rb(i + 1) - 1)) * x(c(rb(i):(rb(i + 1) - 1)));
    end
    res = norm(b - A_x) / normb;
    res_total(k + 1) = res;
end

%% Check whether we converged
if res <= tol
    converged = true;
else
    converged = false;
end

end