function w_efficiency(A, b)

%calculating w_opt
w_opt  = cal_w_opt(A);

% calculating the spectral radius for w_opt
D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);
T_SOR_opt = (D/w_opt + L) \ ((1-w_opt)/w_opt * D - U);
rhoT_SOR_opt = max(abs(eig(T_SOR_opt)));

wVec = linspace(1e-2,2,400);
rhoT_SOR = zeros(1,400);

% calculating the spectral radius for each w
for i = 1:400
    w = wVec(i);
    T_SOR = (D/w + L) \ ((1-w)/w * D - U);
    rhoT_SOR(i) = max(abs(eig(T_SOR)));
end

% Plotting the spectral radius against corresponding w values.
figure;
plot(wVec, rhoT_SOR, 'b')
hold on
% Plotting the w_opt value.
plot(w_opt, rhoT_SOR_opt,'r.','Markersize',20);
ylabel('$\rho(T_{SOR})$', 'Interpreter','latex')
xlabel('$\omega$', 'Interpreter','latex')

% Storing A in CSR to get rb, c, v
[rb, c, v, x0, tol, maxiters] = CSR_Storage(A);

kVec = zeros(1,400);

% calculating the iterations for w_opt
[~, ~, k_opt, ~, ~] = sor_CSR(rb, c', v', b, x0, w_opt, tol, maxiters, 0);

% calculating the number of iterations for each w
for i = 1:400
    [~, ~, kVec(i), ~, ~] = sor_CSR(rb, c', v', b, x0, wVec(i), tol, maxiters, 0);
end

% Plotting the number of iterations against corresponding w values.
figure;
plot(wVec, kVec, 'b')
hold on
% Plotting the w_opt value.
plot(w_opt, k_opt,'r.','Markersize',20);
ylabel('Number of Iterations', 'Interpreter','latex')
xlabel('$\omega$', 'Interpreter','latex')
set(gca,'TickLabelInterpreter','latex')

end