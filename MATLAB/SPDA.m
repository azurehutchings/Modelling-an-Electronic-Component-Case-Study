%Prove SPD
load full_storage
%Is A symmetric?
figure
spy(A-A')
title('Spy of A-A''')
%All of the values are zero, therefore it is symmetric
figure
%Check to see if A is Positive Definite by inspecting all the eigenvalues
plot(eig(A))
title('Eigenvalues of A')
ylabel('Value of Eigenvalue')
xlabel('nth Eigenvalue')
%All of the eigenvalues are positive, therefore A is Postive Definite