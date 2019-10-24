average_run_time = [0, 0, 0, 0, 0] %Average runtime 

% Run the code 1000 times, then average the runtimes
for i = 1:100
    [~, ~, time] = full_storage_solution;
    average_run_time(1) = average_run_time(1) + time;
    
    [~, ~, time] = packed_storage_solution;
    average_run_time(2) = average_run_time(2) + time;

    [~, ~, time] = band_storage_solution;
    average_run_time(3) = average_run_time(3) + time;
    
    [~, ~, time] = sparse_storage_solution;
    average_run_time(4) = average_run_time(4) + time;
    
end

average_run_time./100