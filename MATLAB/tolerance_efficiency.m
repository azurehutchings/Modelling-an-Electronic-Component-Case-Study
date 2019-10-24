function tolerance_efficiency(A, b, tolVec)
w_opt = cal_w_opt(A);

[~,n] = size(tolVec);

[rb, c, v, x0, ~, maxiters] = CSR_Storage(A);

figure;
for i = 1:n
    [temperatures, ~, ~, ~, ~] = jacobi_CSR(rb, c', v', b, x0, tolVec(i), maxiters, 0);
    graphTitle = ['Solving A and b using tol ', num2str(tolVec(i)), ' for Jacobi Method'];
    visualisation(temperatures, graphTitle, true, n, i)
end

figure;
for i = 1:n
    [temperatures, ~, ~, ~, ~] = gauss_seidel_CSR(rb, c', v', b, x0, tolVec(i), maxiters, 0);
    graphTitle = ['Solving A and b using tol ', num2str(tolVec(i)), ' for Gauss Seidel Method'];
    visualisation(temperatures, graphTitle, true, n, i)
end

figure;
for i = 1:n
    [temperatures, ~, ~, ~, ~] = conjugate_gradient_CSR(rb, c', v', b, x0, tolVec(i), maxiters, 0);
    graphTitle = ['Solving A and b using tol ', num2str(tolVec(i)), ' for Conjugate Gradient Method'];
    visualisation(temperatures, graphTitle, true, n, i)
end

figure;
for i = 1:n
    [temperatures, ~, ~, ~, ~] = sor_CSR(rb, c', v', b, x0, w_opt, tolVec(i), maxiters, 0);
    graphTitle = ['Solving A and b using tol ', num2str(tolVec(i)), ' for SOR Method'];
    visualisation(temperatures, graphTitle, true, n, i)
end
