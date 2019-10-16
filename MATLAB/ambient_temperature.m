for ambient_temp = 10:0.5:50
    
    [A, b] = ambient_temperature_matrix(ambient_temp);
    
    A = cholesky(A);
    temperatures = forward_substitution(A', b);
    temperatures = backward_substitution(A, temperatures);
    

   %Use ambient_temperature variable to reconstruct A matrix and b vector accordingly

   temperatures(22)

   %Check temperature at point (0.03, 0.03)

        %If it is close to 50 or 55 celcius return the temperature and

        %ambient temperature

        

        %Narrow down search for ambient temperature

end