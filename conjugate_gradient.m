function [x, converged, k, res_total] = conjugate_gradient(A, b, x0, tol, maxiters)

x = x0;
r = b - A*x;
d = r;
rTr = r' * r;
beta = 1 / rTr;
k = 0;
normb = norm(b);
res = norm(b - A*x) / normb;
res_total = res;

while res > tol && k < maxiters
    Ad = A*d;
    alpha = rTr / (d' * Ad);
    x = x + alpha * d;
    r = r - alpha * Ad;
    beta = 1/rTr;
    rTr = r'*r;
    beta = beta * rTr;
    d = r + beta * d;
    k = k + 1;
    res = norm(b - A*x) / normb;
    res_total(k + 1) = res;
end

%% Check whether we converged
if beta <= tol
    converged = true;
else
    converged = false;
end

end