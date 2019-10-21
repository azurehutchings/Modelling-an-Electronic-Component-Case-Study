function [x, converged, k, res_total, flops] = gauss_seidel_CSR(rb, c, v, b, x0, tol, maxiters, current_flops)
%% Initialise
n = length(rb) - 1;
k = 0;
x = x0;
normb = norm(b);

%flop count
flops = current_flops;

[A_x, flops] = multiAx(v, rb, c, x, flops);

res = norm(b - A_x) / normb;
res_total = res;

%% Perform the iteration until res <= tol or maximum iterations taken
while res > tol && k < maxiters
    for i = 1:n
        x(i) = b(i);
        for j = rb(i):(rb(i + 1) - 1)
            if c(j) ~= i
               x(i) = x(i) - v(j) * x(c(j));
               flops = flops + 3;
            else
                center = j;
            end
        end
        x(i) = x(i) / v(center);
        flops = flops + 1;
    end
    k = k + 1;
    [A_x, flops] = multiAx(v, rb, c, x, current_flops);
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