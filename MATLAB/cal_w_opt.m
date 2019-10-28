function w_opt = cal_w_opt(A)
%This function calculates the optimal omega value for the SOR method.

D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);
T_J = - (D \ (L + U));
rhoT_J = max(abs(eig(T_J)));
w_opt = (2 /(1 + sqrt(1 - rhoT_J^2)));

end