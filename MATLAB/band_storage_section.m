%RCM Storage
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
G_Band_then_chol = cholesky_band(A_band);

%solve with forward substitution and then backwards substitution

temperatures = banded_forward_substitution(G_chol_then_band, b_rcm);
temperatures = banded_backward_substitution(G_chol_then_band, temperatures);
temperatures = temperatures(reorder);
%Visualisating the Temperature from Band Storage
visualisation(temperatures)