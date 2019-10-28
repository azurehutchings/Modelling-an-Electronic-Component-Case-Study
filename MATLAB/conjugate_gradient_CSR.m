function [x, converged, k, res_total, flops] = conjugate_gradient_CSR(rb, c, v, b, x0, tol, maxiters, current_flops)
%% Initalise
n = length(rb)-1;
x = x0;

%flop count
flops = current_flops;

[A_x, flops] = multiAx(v, rb, c, x, flops);

r = b - A_x;
flops = flops + n; %Vector-vector is n flops
d = r;
rTr = r' * r;
flops = flops + 2*n-1; %vector*vector is 2n-1 flops (n flops from multiplications, n-1 flops from additions)
beta = 1 / rTr;
flops = flops +1; %one division one flop
k = 0;
normb = norm(b);
res = norm(b - A_x) / normb;
flops = flops + n + 1; %vector subtration n flops, division 1 flop
res_total = res;

while res > tol && k < maxiters
    [Ad, flops] = multiAx(v, rb, c, d, flops);
    alpha = rTr / (d' * Ad);
    flops = flops + 2*n-1;
    x = x + alpha * d;
    flops = flops + 2*n;
    r = r - alpha * Ad;
    flops = flops + 2*n;
    beta = 1/rTr;
    flops = flops + 1;
    rTr = r'*r;
    flops = flops + 2*n-1;
    beta = beta * rTr;
    flops = flops + 1;
    d = r + beta * d;
    flops = flops + 2*n;
    k = k + 1;
    [A_x, flops] = multiAx(v, rb, c, x, flops);
    res = norm(b - A_x) / normb;
    flops = flops + n + 1;
    res_total(k + 1) = res;
end

%% Check whether we converged
if res <= tol
    converged = true;
else
    converged = false;
end

end