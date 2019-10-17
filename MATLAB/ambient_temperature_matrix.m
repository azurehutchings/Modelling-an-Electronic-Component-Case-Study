function [A, b] = ambient_temperature_matrix(x)

%6 nodes along each row
n = 6;
nOnes = ones(n,1);
T = diag(4*nOnes,0) + diag(-1*nOnes(1:n-1), -1) + diag(-1*nOnes(1:n-1),1);
I = -1*eye(6);
Z = zeros(6,6);
A = [T I Z Z Z Z; I T I Z Z Z; Z I T I Z Z; Z Z I T I Z; Z Z Z I T I; Z Z Z Z I T];
b = [0; 0; 0; 0; 0; 40; 0; 0; 0; 0; 0; 40; 0; 0; 0; 0; 0; 40; 0; 0; 0; 0; 0; 40+(0.2/3)*x ; 0; 0; 0; 0; 0.2*sqrt(2)/3*x; 70; 70; 70; 70+(0.2/3)*x];

%make changes for insulated boundary
A(1,1) = 2;
A(2,2) = 3;
A(3,3) = 3;
A(4,4) = 3;
A(5,5) = 3;
A(6,6) = 3;

A(7,7) = 3;
A(13,13) = 3;
A(19,19) = 3;
A(25,25) = 3;
A(31,31) = 3;

%changes along convective boundary
A(24,24) = (3+0.2/3); 
A(29,29) = (2-0.2*sqrt(2)/3);
A(34,34) = (3+0.2/3);

%nothing should rely on u(4,5) which is row and column 30
A(:,30) = [];
A(30,:) = [];
%same for columns/rows 35 and 36 (but because we've already deleted
%values, they're now rows 34 then 34 again)
A(:,34) = [];
A(34,:) = [];
A(:,34) = [];
A(34,:) = [];

end 


