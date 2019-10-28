format long
format compact
%%
%Check SPD
load full_storage
spy(A-A')
title('A-A''')

eigens = eig(A);
plot(eigens)
title('nth Eigenvalues of A')
xlabel('n')
ylabel('Eigenvalue')

%%
% Storage and Solution
% Full Storage
load full_storage
figure
spy(A)
title('Spy of A', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')

% Full Storage (solved using Cholesky)
[temperatures, full_flops, ~, A_cholesky] = full_storage_solution;
visualisation(temperatures, 'Full Storage Solution')
fill_in_full = nnz(A_cholesky) - nnz(A);
figure
spy(A_cholesky)
title('chol(A)', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')

% Packed Storage (solved using Cholesky) 
[temperatures, packed_flops, ~, A_packed, A_packed_chol] =  packed_storage_solution;
visualisation(temperatures, 'Packed Storage Solution')
fill_in_packed = nnz(A_packed_chol) - nnz(A_packed);
[temperatures, band_flops, ~, A_RCM, A_band, cholBand] = band_storage_solution;
% Banded Storage (solved using Cholesky)
visualisation(temperatures, 'Band Storage Solution')
fill_in_band = nnz(cholBand) - nnz(A_band);
figure
spy(A_band)
title('A$_\mathrm{Band}$', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')

figure
spy(cholBand)
title('chol(A$_\mathrm{Band}$)', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')

figure
spy(A_RCM)
title('A$_\mathrm{RCM}$', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')


% Sparse Storage (solved using Cholesky)
[temperatures, sparse_flops, ~, A_sparse, sparseChol] = sparse_storage_solution;
visualisation(temperatures, 'Sparse Storage Solution')
fill_in_sparse = nnz(sparseChol) - nnz(A_sparse);
bandwidth_sparse = bandwidth(sparse);
figure
spy(A_sparse)
title('A$_\mathrm{Sparse}$', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')

figure
spy(sparseChol)
title('chol(A$_\mathrm{Sparse}$)', 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')
%%
% CSR Storage (solved using Jacobi)
[temperatures, JacobiFlops, ~, jacobi_k, jacobi_res] = jacobi_solution;
visualisation(temperatures, 'Jacobi Solution')

% CSR Storage (solved using Gauss Seidel)
[temperatures, GaussFlops, ~, gs_k, gs_res] = gauss_seidel_solution;
visualisation(temperatures, 'Gauss Seidel Solution')

% CSR Storage (solved using Conjugate Gradient)
[temperatures, ConjugateFlops, ~, conjugate_k, conjugate_res] = conjugate_gradient_solution;
visualisation(temperatures, 'Conjugate Gradient Solution')

% CSR Storage (solved using SOR)
[temperatures, SORFlops, ~, SOR_k, SOR_res] = SOR_solution;
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
set(gca,'TickLabelInterpreter','latex')
text(1:length(Direct_Method_Bytes),Direct_Method_Bytes,num2str(Direct_Method_Bytes'),'vert','top','horiz','center');
%%
%Iterations
NumberIterations = [jacobi_k, gs_k, conjugate_k, SOR_k];
figure
bar(NumberIterations)
title('Number of Iterations for Iterative Methods', 'Interpreter', 'latex')
xtickangle(45)
set(gca,'xticklabel',{'Jacobi', 'Gauss Seidel', 'Conjugate Gradiant', 'SOR'})
set(gca,'TickLabelInterpreter','latex')
text(1:length(NumberIterations),NumberIterations,num2str(NumberIterations'),'vert','top','horiz','center')
%%
%Average runtime
runtimes = AverageRunTime;
figure
bar(runtimes)
title('Average run time for direct methods (in seconds)', 'Interpreter', 'latex')
xtickangle(45)
set(gca,'TickLabelInterpreter','latex')
set(gca, 'xticklabel', {'Full Solution', 'Packed Solution', 'Band Solution', 'Sparse Solution', 'Jacobi Solution', 'Gauss-Seidel Solution', 'Conjugate Gradient Solution', 'SOR Solution'})
text(1:length(runtimes'),runtimes',num2str(runtimes),'vert','bottom','horiz','center'); 
%%
%Floating Point Operations
NumberFlops = [full_flops, packed_flops, band_flops, sparse_flops, ...
    JacobiFlops, GaussFlops, ConjugateFlops, SORFlops];
figure
bar(NumberFlops)
title('Number of Flops for Direct and Iterative Methods', 'Interpreter', 'latex')
xtickangle(45)
set(gca,'TickLabelInterpreter','latex')
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