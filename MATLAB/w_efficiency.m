function w_efficiency(A, b)

w_opt  = cal_w_opt(A);
D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);

T_SOR_opt = (D/w_opt + L) \ ((1-w_opt)/w_opt * D - U);
rhoT_SOR_opt = max(abs(eig(T_SOR_opt)));

wVec = linspace(1e-2,2,200);
rhoT_SOR = zeros(1,200);

for i = 1:200
    w = wVec(i);
    T_SOR = (D/w + L) \ ((1-w)/w * D - U);
    rhoT_SOR(i) = max(abs(eig(T_SOR)));
end

figure;
plot(wVec, rhoT_SOR, 'b')
hold on
plot(w_opt, rhoT_SOR_opt,'r.','Markersize',20);
ylabel('$\rho(T_{SOR})$', 'Interpreter','latex')
xlabel('$\omega$', 'Interpreter','latex')

[rb, c, v, x0, tol, maxiters] = CSR_Storage(A);

kVec = zeros(1,200);
[~, ~, k_opt, ~, ~] = sor_CSR(rb, c', v', b, x0, w_opt, tol, maxiters, 0);

for i = 1:200
    [~, ~, kVec(i), ~, ~] = sor_CSR(rb, c', v', b, x0, wVec(i), tol, maxiters, 0);
end

figure;
plot(wVec, kVec, 'b')
hold on
plot(w_opt, k_opt,'r.','Markersize',20);
ylabel('Number of Iterations', 'Interpreter','latex')
xlabel('$\omega$', 'Interpreter','latex')
set(gca,'TickLabelInterpreter','latex')

end