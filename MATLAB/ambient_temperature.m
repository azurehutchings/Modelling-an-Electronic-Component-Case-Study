function [lower_temp, lower_temps_vector, upper_temp, upper_temps_vector] = ambient_temperature
for ambient_temp = 0:0.01:60
    
    [A,b] = full_storage;
    b(33) = (0.2*sqrt(2)/3)*ambient_temp;
    b(29) = (0.2*sqrt(2)/3)*ambient_temp;
    b(24) = (0.2*sqrt(2)/3)*ambient_temp;
    [cholmat,~] = cholesky(A, 0);
    [temperatures,~] = forward_substitution(cholmat', b, 0);
    [temperatures,~] = backward_substitution(cholmat, temperatures, 0);
    
   %Use ambient_temperature variable to reconstruct A matrix and b vector accordingly
   if abs(temperatures(22)-50) < 1e-3
      lower_temp = ambient_temp;
      lower_temps_vector = temperatures;
   end
   if abs(temperatures(22)-55) < 1e-8
      upper_temp = ambient_temp;
      upper_temps_vector = temperatures;
   end
end
%%

for ambient_temp = 1.7:0.0000001:1.73
    
    [A,b] = full_storage;
    b(33) = (0.2*sqrt(2)/3)*ambient_temp;
    b(29) = (0.2*sqrt(2)/3)*ambient_temp;
    b(24) = (0.2*sqrt(2)/3)*ambient_temp;
    [cholmat,~] = cholesky(A, 0);
    [temperatures,~] = forward_substitution(cholmat', b, 0);
    [temperatures,~] = backward_substitution(cholmat, temperatures, 0);
    
   %Use ambient_temperature variable to reconstruct A matrix and b vector accordingly
   tol = 1e-8;
   if abs(temperatures(22)-50) < tol
      lower_temp = ambient_temp;
      lower_temps_vector = temperatures;
   end
end