function [temperatures, flops, time, A_RCM, A_band, G_Band_then_chol] = band_storage_solution

    load full_storage

    %Create a new matrix to work with
    A_RCM = A;
    
    %create ordering vector
    p= symrcm(A_RCM);
    
    %order the A matrix and b vector according the RCM storage
    A_RCM = A_RCM(p,p);
    b_rcm = b(p);
    reorder = reorder_vector(p);
    
    %Create a band storage for A
    A_band = band(A_RCM);
    
    %Perform cholesky factorisation on the banded matrix
    tic;
    [G_Band_then_chol, flops] = cholesky_band(A_band, 8, 0);
    
    %solve with forward substitution and then backwards substitution
    [temperatures, flops] = banded_forward_substitution(G_Band_then_chol, b_rcm, flops);
    [temperatures, flops] = banded_backward_substitution(G_Band_then_chol, temperatures, flops);
    temperatures = temperatures(reorder);
    time = toc;
end