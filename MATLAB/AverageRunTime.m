function average_run_time = AverageRunTime

average_run_time = zeros(8,1); %Average runtime 

% Run the code 1000 times, then average the runtimes
for i = 1:1000
    [~, ~, time] = full_storage_solution;
    average_run_time(1) = average_run_time(1) + time;
    
    [~, ~, time] = packed_storage_solution;
    average_run_time(2) = average_run_time(2) + time;

    [~, ~, time] = band_storage_solution;
    average_run_time(3) = average_run_time(3) + time;
    
    [~, ~, time] = sparse_storage_solution;
    average_run_time(4) = average_run_time(4) + time;
    
    [~, ~, time] = jacobi_solution;
    average_run_time(5) = average_run_time(5) + time;
    
    [~, ~, time] = gauss_seidel_solution;
    average_run_time(6) = average_run_time(6) + time;
    
    [~, ~, time] = conjugate_gradient_solution;
    average_run_time(7) = average_run_time(7) + time;
    
    [~, ~, time] = SOR_solution;
    average_run_time(8) = average_run_time(8) + time;
    
end

%average_run_time./100;