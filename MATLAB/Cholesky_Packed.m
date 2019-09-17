function a = Cholesky_Packed(a)
[~,n] = size(a);
n = (-1+sqrt(1+8*n))/2;
for j = 1:n
    for i = 1:j-1
        for k = 1:i-1
            a(i+j*(j-1)/2) = a(i+j*(j-1)/2) - a(k+i*(i-1)/2)  * a(k+j*(j-1)/2);
        end
        a(i+j*(j-1)/2)=a(i+j*(j-1)/2) / a(i+i*(i-1)/2);
        a(j+j*(j-1)/2) = a(j+j*(j-1)/2) - a(i+j*(j-1)/2)^2;
    end
   a(j+j*(j-1)/2) = sqrt(a(j+j*(j-1)/2));
end 