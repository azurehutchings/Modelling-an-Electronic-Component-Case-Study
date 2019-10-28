function [x, converged, k, res_total, flops] = jacobi_CSR(rb, c, v, b, x0, tol, maxiters, current_flops)
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
normb = norm(b);

%flop count
flops = current_flops;

%Multiplying A by x
[A_x, flops] = multiAx(v, rb, c, x, flops);

res = norm(b - A_x) / normb;
res_total = res;
%% Perform the iteration until res <= tol or maximum iterations taken
while res > tol && k < maxiters
    xold = x;
    for i = 1:n
        x(i) = b(i);
        for j = rb(i):(rb(i + 1) - 1)
            if c(j) ~= i
               x(i) = x(i) - v(j) * xold(c(j));
               flops = flops + 2;
            else
                center = j;
            end
        end
        x(i) = x(i) / v(center);
        flops = flops + 1;
    end
    k = k + 1;
    
    [A_x, flops] = multiAx(v, rb, c, x, flops);
    
    res = norm(b - A_x) / normb;
    res_total(k + 1) = res;
    flops = flops + 2;
end

%% Check whether we converged
if res <= tol
    converged = true;
else
    converged = false;
end

end