n1 = 30; n2 = 30; n3 = 30;
a = linspace(-3,3,n1); b = linspace(-3,3,n2); c = linspace(-3,3,n3);
[X,Y,Z] = meshgrid(a,b,c);

%F = @(X,Y,Z) ( 2*X.^2 + Y.^2 + Z.^2 -1  ).^3 - (0.1.*X.^2 + Y.^2).*(Z.^3);
F = @(X,Y,Z) ( 2*X.^2 + Y.^2 + Z.^2 - 2 );
F_V = F(X,Y,Z);

[Tri,V] = marching_tetrahedra(X,Y,Z,F_V);
Corner = corner_table(V,Tri);
N_V = normal_vertices( V,Tri,Corner );

V_new = suavizacao_vertices(V,Tri,Corner, N_V);

trimesh(Tri, V_new(:,1),V_new(:,2),V_new(:,3),'FaceAlpha',1,'FaceColor','c');




