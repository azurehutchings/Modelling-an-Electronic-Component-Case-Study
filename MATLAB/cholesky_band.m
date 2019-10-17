function [A, flops] = cholesky_band(A, bandwidth, current_flops)
[n,~] = size(A);
flops = current_flops;
for j = 1:n
    for i = 1:j-1
        for k = 1:i-1
            if((j-i+1) < bandwidth && (i-k+1) < bandwidth && (j-k+1) < bandwidth)
                A(i,j-i+1) = A(i,j-i+1) - A(k,i-k+1) * A(k,j-k+1);
                flops = flops + 2;
            end
        end
        if((j-i+1)<8)
            A(i,j-i+1) = A(i,j-i+1) / A(i,1);
            A(j,1) = A(j,1) - A(i,j-i+1)^2;
            flops = flops + 3;
        end
    end
    A(j,1) = sqrt(A(j,1));
    flops = flops + 1;
end
