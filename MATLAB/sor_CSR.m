function [x, converged, k, res_total, flops] = sor_CSR(rb, c, v, b, x0, w, tol, maxiters, current_flops)
%% Initialise
%flop count
flops = current_flops;

n = length(rb) - 1;
k = 0;
x = x0;
normb = norm(b);
A_x = zeros(n,1);
for i = 1:n
    A_x(i) = v(rb(i):(rb(i + 1) - 1)) * x(c(rb(i):(rb(i + 1) - 1)));
    flops = flops + 1;
end
res = norm(b - A_x) / normb;
res_total = res;

%% Perform the iteration until res <= tol or maximum iterations taken
while res > tol && k < maxiters
    xold = x;
    for i = 1:n
        x(i) = b(i);
        for j = rb(i):(rb(i + 1) - 1)
            if c(j) ~= i
               x(i) = x(i) - v(j) * x(c(j));
               flops = flops + 2;
            else
                center = j;
            end
        end
        x(i) = x(i) * w / v(center);
        x(i) = x(i) + (1 - w) * xold(i);
        flops = flops + 5;
    end
    k = k + 1;
    for i = 1:n
        A_x(i) = v(rb(i):(rb(i + 1) - 1)) * x(c(rb(i):(rb(i + 1) - 1)));
        flops = flops + 1;
    end
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