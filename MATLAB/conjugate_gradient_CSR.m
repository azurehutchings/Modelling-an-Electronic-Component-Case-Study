function [x, converged, k, res_total, flops] = conjugate_gradient_CSR(rb, c, v, b, x0, tol, maxiters, current_flops)
%% Initalise
n = length(rb) - 1;
x = x0;

%flop count
flops = current_flops;

[A_x, flops] = multiAx(v, rb, c, x, flops);

r = b - A_x;
d = r;
rTr = r' * r;
beta = 1 / rTr;
k = 0;
normb = norm(b);
res = norm(b - A_x) / normb;
res_total = res;

while res > tol && k < maxiters
    [Ad, flops] = multiAx(v, rb, c, d, flops);
    alpha = rTr / (d' * Ad);
    x = x + alpha * d;
    r = r - alpha * Ad;
    beta = 1/rTr;
    rTr = r'*r;
    beta = beta * rTr;
    d = r + beta * d;
    k = k + 1;
    flops = flops + 11;
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