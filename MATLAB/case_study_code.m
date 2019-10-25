format long
format compact

%%
%Storage and Solution
%Full Storage
load full_storage
spy(A)
title('Spy of A')

[temperatures, full_flops, ~] = full_storage_solution(A);
visualisation(temperatures, 'Full Storage Solution')

[temperatures, packed_flops, ~, A_packed] =  packed_storage_solution(A);
visualisation(temperatures, 'Packed Storage Solution')

[temperatures, band_flops, ~, A_band, cholBand] = band_storage_solution(A);
visualisation(temperatures, 'Band Storage Solution')
spy(A_band)
[temperatures, sparse_flops, ~, A_sparse] = sparse_storage_solution(A);
visualisation(temperatures, 'Sparse Storage Solution')
spy(A_sparse)
[temperatures, JacobiFlops, ~, jacobi_k, jacobi_res] = jacobi_solution(A);
visualisation(temperatures, 'Jacobi Solution')

[temperatures, GaussFlops, ~, gs_k, gs_res] = gauss_seidel_solution(A);
visualisation(temperatures, 'Gauss Seidel Solution')

[temperatures, ConjugateFlops, ~, conjugate_k, conjugate_res] = conjugate_gradient_solution(A);
visualisation(temperatures, 'Conjugate Gradient Solution')

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
%%
%Iterations
NumberIterations = [jacobi_k, gs_k, conjugate_k, SOR_k];
figure
bar(NumberIterations)
title('Number of Iterations for Iterative Methods', 'Interpreter', 'latex')
xtickangle(45)
set(gca,'xticklabel',{'Jacobi', 'Gauss Seidel', 'Conjugate Gradiant', 'SOR'})
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
text(1:length(NumberFlops),NumberFlops,num2str(NumberFlops'),'vert','bottom','horiz','center'); 
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