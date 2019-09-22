function [x, converged, k, res_total] = conjugate_gradient_CSR(rb, c, v, b, x0, tol, maxiters)

%% Initalise
n = length(rb) - 1;
x = x0;
A_x = zeros(n,1);
for i = 1:n
    A_x(i) = v(rb(i):(rb(i + 1) - 1)) * x(c(rb(i):(rb(i + 1) - 1)));
end
r = b - A_x;
d = r;
rTr = r' * r;
beta = 1 / rTr;
k = 0;
normb = norm(b);
res = norm(b - A_x) / normb;
res_total = res;
Ad = zeros(n,1);

while res > tol && k < maxiters
    for i = 1:n
        Ad(i) = v(rb(i):(rb(i + 1) - 1)) * d(c(rb(i):(rb(i + 1) - 1)));
    end
    alpha = rTr / (d' * Ad);
    x = x + alpha * d;
    r = r - alpha * Ad;
    beta = 1/rTr;
    rTr = r'*r;
    beta = beta * rTr;
    d = r + beta * d;
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