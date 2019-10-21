
for ambient_temp = 0:0.00001:2
    
    [A,b] = full_storage;
    b(33) = (0.2*sqrt(2)/3)*ambient_temp;
    b(29) = (0.2*sqrt(2)/3)*ambient_temp;
    b(24) = (0.2*sqrt(2)/3)*ambient_temp;
    [cholmat,~] = cholesky(A, 0);
    [temperatures,~] = forward_substitution(cholmat', b, 0);
    [temperatures,~] = backward_substitution(cholmat, temperatures, 0);
    
   %Use ambient_temperature variable to reconstruct A matrix and b vector accordingly
   tol = 1e-6;
   if abs(temperatures(22)-50) < tol
      ambient_temp, temperatures(22)
   end
   if abs(temperatures(22)-55) < tol
      ambient_temp, temperatures(22)
   end
end