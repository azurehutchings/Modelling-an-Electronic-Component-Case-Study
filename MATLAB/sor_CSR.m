function [x, converged, k, res_total, flops] = sor_CSR(rb, c, v, b, x0, w, tol, maxiters, current_flops)
%% Initialise
% flop count
flops = current_flops;

% n is the row length of matrix A
n = length(rb) - 1;
k = 0;
x = x0;
normb = norm(b);

% multiplying A by x
[A_x, flops] = multiAx(v, rb, c, x, flops);
res = norm(b - A_x) / normb;
res_total = res;

%% Perform the iteration until res <= tol or maximum iterations taken
while res > tol && k < maxiters
    xold = x;
    for i = 1:n
        x(i) = b(i);
        % iterating over the ith row with all the A values in that row
        for j = rb(i):(rb(i + 1) - 1)
            % checking if c(j) is the center value
            if c(j) ~= i
               x(i) = x(i) - v(j) * x(c(j));
               flops = flops + 2;
            else
                % assigning the center value
                center = j;
            end
        end
        x(i) = x(i) * w / v(center);
        x(i) = x(i) + (1 - w) * xold(i);
        flops = flops + 5;
    end
    k = k + 1;
    % multiplying A by x
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