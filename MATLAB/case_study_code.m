format long
format compact

%%
% Storage and Solution
% Full Storage
load full_storage
spy(A)
title('Spy of A')

% Full Storage (solved using Cholesky)
[temperatures, full_flops, ~] = full_storage_solution(A);
visualisation(temperatures, 'Full Storage Solution')

% Packed Storage (solved using Cholesky) 
[temperatures, packed_flops, ~, A_packed] =  packed_storage_solution(A);
visualisation(temperatures, 'Packed Storage Solution')

[temperatures, band_flops, ~, A_RCM, A_band, cholBand] = band_storage_solution(A);
% Banded Storage (solved using Cholesky)
visualisation(temperatures, 'Band Storage Solution')
figure
spy(A_band)
title('A$_\mathrm{Band}$', 'Interpreter', 'latex')
figure
spy(cholBand)
title('chol(A$_\mathrm{Band}$)', 'Interpreter', 'latex')
figure
spy(A_RCM)
title('A$_\mathrm{RCM}$', 'Interpreter', 'latex')
% Sparse Storage (solved using Cholesky)
%%
[temperatures, sparse_flops, ~, A_sparse, sparseBand] = sparse_storage_solution(A);
visualisation(temperatures, 'Sparse Storage Solution')
figure
spy(A_sparse)
title('A$_\mathrm{Sparse}$', 'Interpreter', 'latex')
figure
spy(sparseBand)
title('chol(A$_\mathrm{Sparse}$)', 'Interpreter', 'latex')
%%
% CSR Storage (solved using Jacobi)
[temperatures, JacobiFlops, ~, jacobi_k, jacobi_res] = jacobi_solution(A);
visualisation(temperatures, 'Jacobi Solution')

% CSR Storage (solved using Gauss Seidel)
[temperatures, GaussFlops, ~, gs_k, gs_res] = gauss_seidel_solution(A);
visualisation(temperatures, 'Gauss Seidel Solution')

% CSR Storage (solved using Conjugate Gradient)
[temperatures, ConjugateFlops, ~, conjugate_k, conjugate_res] = conjugate_gradient_solution(A);
visualisation(temperatures, 'Conjugate Gradient Solution')

% CSR Storage (solved using SOR)
[temperatures, SORFlops, ~, SOR_k, SOR_res] = SOR_solution(A);
visualisation(temperatures, 'SOR Solution')

%%
%Efficiency Comparison
%Memory
S = whos('A', 'A_packed', 'A_band', 'A_sparse');
Direct_Method_Bytes = [S(1).bytes, S(2).bytes, S(3).bytes, S(4).bytes];
figure
bar(Direct_Method_Bytes)
title('Storage Size in Bytes for Direct Methods', 'Interpreter', 'latex')
xtickangle(45)
set(gca,'xticklabel',{'Full Storage', 'Packed Storage', 'Band Store', 'Sparse Storage'})
text(1:length(Direct_Method_Bytes),Direct_Method_Bytes,num2str(Direct_Method_Bytes'),'vert','top','horiz','center');
%%
%Iterations
NumberIterations = [jacobi_k, gs_k, conjugate_k, SOR_k];
figure
bar(NumberIterations)
title('Number of Iterations for Iterative Methods', 'Interpreter', 'latex')
xtickangle(45)
set(gca,'xticklabel',{'Jacobi', 'Gauss Seidel', 'Conjugate Gradiant', 'SOR'})
text(1:length(NumberIterations),NumberIterations,num2str(NumberIterations'),'vert','top','horiz','center')
%%
%Average runtime
runtimes = AverageRunTime;



%%
%Floating Point Operations
NumberFlops = [full_flops, packed_flops, band_flops, sparse_flops, ...
    JacobiFlops, GaussFlops, ConjugateFlops, SORFlops];
figure
bar(NumberFlops)
title('Number of Flops for Direct and Iterative Methods', 'Interpreter', 'latex')
xtickangle(45)
set(gca,'xticklabel',{'Full Storage Flops', 'Packed Storage Flops',...
    'Band Storage Flops', 'Sparse Storage Flops', 'Jacobi Iteration Flops',...
    'Gauss Seidel Iteration Flops', 'Conjugate Gradient Iteration Flops', 'SOR Iteration Flops'})
text(1:length(NumberFlops),NumberFlops,num2str(NumberFlops'),'vert','top','horiz','center'); 
%%

figure
hold on
set(gca, 'Yscale', 'log');
ylim([1e-6 10]);
plot(0:jacobi_k, jacobi_res, 'b.');
plot(0:gs_k, gs_res, 'g.');
plot(0:conjugate_k, conjugate_res, 'r.');
plot(0:SOR_k, SOR_res, 'y.');
title('Residual Norm', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')

lgd = legend('Jacobi', 'Gauss-Seidel', 'SOR(optimal $\omega$)', 'Conjugate gradient');
lgd.Interpreter = 'latex';

ylabel('$||b-A*x^{(k)}|| / ||b||$', 'Interpreter','latex')
xlabel('k', 'Interpreter','latex')

%Tolerance
tolVec = [1e-10, 1e-5, 1e-3, 2e-3, 1e-2, 1e-1, 0.5, 1];
tolerance_efficiency(A, b, tolVec)

%Effect of w on the rate of convergence of the SOR method.
w_efficiency(A, b)