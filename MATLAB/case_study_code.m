format long
format compact

%Storage and Solution
%Full Storage
load full_storage
spy(A)
title('Spy of A')

[temperatures, full_flops, time] = full_storage_solution;
visualisation(temperatures, 'Full Storage Solution')


[temperatures, packed_flops, time] =  packed_storage_solution;
visualisation(temperatures, 'Packed Storage Solution')

[temperatures, band_flops, time] = band_storage_solution;
visualisation(temperatures, 'Band Storage Solution')


%Average runtime
AverageRunTime