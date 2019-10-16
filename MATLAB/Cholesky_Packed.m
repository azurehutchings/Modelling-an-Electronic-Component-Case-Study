function [a, flops] = Cholesky_Packed(a, current_flops)
[~,n] = size(a);
n = (-1+sqrt(1+8*n))/2;

%flop count
flops = current_flops;

for j = 1:n
    for i = 1:j-1
        for k = 1:i-1
            a(i+j*(j-1)/2) = a(i+j*(j-1)/2) - a(k+i*(i-1)/2)  * a(k+j*(j-1)/2);
            flops = flops + 2;
        end
        a(i+j*(j-1)/2)=a(i+j*(j-1)/2) / a(i+i*(i-1)/2);
        a(j+j*(j-1)/2) = a(j+j*(j-1)/2) - a(i+j*(j-1)/2)^2;
        flops = flops + 3;
    end
   a(j+j*(j-1)/2) = sqrt(a(j+j*(j-1)/2));
   flops = flops + 1;
end 