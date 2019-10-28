function tolerance_efficiency(A, b, tolVec)

% Calculating optimal w value
w_opt = cal_w_opt(A);

[~,n] = size(tolVec);

% Storing A in CSR to get rb, c, v
[rb, c, v, x0, ~, maxiters] = CSR_Storage(A);

% Visualising Temperatures solved by Jacobi for different Tolerances
for i = 1:n
    [temperatures, ~, ~, ~, ~] = jacobi_CSR(rb, c', v', b, x0, tolVec(i), maxiters, 0);
    graphTitle = ['Solving A and b using tol ', num2str(tolVec(i)), ' for Jacobi Method'];
    visualisation(temperatures, graphTitle)
end

% Visualising Temperatures solved by Gauss-Seidel for different Tolerances
for i = 1:n
    [temperatures, ~, ~, ~, ~] = gauss_seidel_CSR(rb, c', v', b, x0, tolVec(i), maxiters, 0);
    graphTitle = ['Solving A and b using tol ', num2str(tolVec(i)), ' for Gauss Seidel Method'];
    visualisation(temperatures, graphTitle)
end

% Visualising Temperatures solved by Conjugate Gradient for different Tolerances
for i = 1:n
    [temperatures, ~, ~, ~, ~] = conjugate_gradient_CSR(rb, c', v', b, x0, tolVec(i), maxiters, 0);
    graphTitle = ['Solving A and b using tol ', num2str(tolVec(i)), ' for Conjugate Gradient Method'];
    visualisation(temperatures, graphTitle)
end

% Visualising Temperatures solved by SOR for different Tolerances
for i = 1:n
    [temperatures, ~, ~, ~, ~] = sor_CSR(rb, c', v', b, x0, w_opt, tolVec(i), maxiters, 0);
    graphTitle = ['Solving A and b using tol ', num2str(tolVec(i)), ' for SOR Method'];
    visualisation(temperatures, graphTitle)
end
