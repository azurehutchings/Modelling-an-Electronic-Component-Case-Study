function visualisation(temperatures, graphTitle)
%visualisation framework

%temperatures = A\b;
[X, Y] = meshgrid(0:0.01:0.06, 0:0.01:0.06);
%create rectangular mesh
Temps = zeros(7,7);

Temps(1,1:6) = temperatures(1:6);
Temps(1,7) = 40;
Temps(2,1:6) = temperatures(7:12);
Temps(2,7) = 40;
Temps(3,1:6) = temperatures(13:18);
Temps(3,7) = 40;
Temps(4,1:6) = temperatures(19:24);
Temps(4,7) = 40;
Temps(5,1:5) = temperatures(25:29);
Temps(6,1:4) = temperatures(30:33);
Temps(5,6:7) = nan;
Temps(6,5:7) = nan;
Temps(7,5:7) = nan;
Temps(7,1:4) = 70;

temperatures = Temps(~isnan(Temps));

x = X(~isnan(Temps));
y = Y(~isnan(Temps));

tri = delaunay(x, y);

tri(44,:) =[];
tri(43,:) =[];
tri(42,:) =[];

% Visualising the Temperatures
figure;
trisurf(tri, x, y, temperatures)
view(2)
shading interp
colormap hot
axis image
title(graphTitle, 'Interpreter', 'latex')
set(gca,'TickLabelInterpreter','latex')
colorbar
end
