n1 = 200; n2 = 200; n3 = 200;
a = linspace(-3,3,n1); b = linspace(-3,3,n2); c = linspace(-3,3,n3);
[X,Y,Z] = meshgrid(a,b,c);

F = @(X,Y,Z) ( 2*X.^2 + Y.^2 + Z.^2 -1  ).^3 - (0.1.*X.^2 + Y.^2).*(Z.^3);
F_V = F(X,Y,Z);

[Tri,V] = marching_tetrahedra(X,Y,Z,F_V);
