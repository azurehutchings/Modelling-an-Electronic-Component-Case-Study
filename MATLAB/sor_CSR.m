function [x, converged, k, res_total] = sor_CSR(rb, c, v, b, x0, w, tol, maxiters)
%% Initialise
n = length(rb) - 1;
k = 0;
x = x0;
normb = norm(b);
A_x = zeros(n,1);
for i = 1:n
    A_x(i) = v(rb(i):(rb(i + 1) - 1)) * x(c(rb(i):(rb(i + 1) - 1)));
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
            else
                center = j;
            end
        end
        x(i) = x(i) * w / v(center);
        x(i) = x(i) + (1 - w) * xold(i);
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