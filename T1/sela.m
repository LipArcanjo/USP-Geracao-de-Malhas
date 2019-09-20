n1 = 30; n2 = 30; n3 = 30;
a = linspace(-3,3,n1); b = linspace(-3,3,n2); c = linspace(-3,3,n3);
[X,Y,Z] = meshgrid(a,b,c);

F = @(X,Y,Z) ( X.^2 - Y.^2 - Z );
F_V = F(X,Y,Z);

[Tri,V] = marching_tetrahedra(X,Y,Z,F_V);
Corner = corner_table(V,Tri);
N_V = normal_vertices( V,Tri,Corner );

Rs = zeros(1,10);

V_old = V;
Rs(1) = razao_aspectos_tri(V,Tri);

for i = 2:10
    V_new = suavizacao_vertices(V,Tri,Corner, N_V);
    Rs(i) = razao_aspectos_tri(V_new,Tri);
    V = V_new;
    N_V = normal_vertices( V_new,Tri,Corner );
    
end

trimesh(Tri, V_new(:,1),V_new(:,2),V_new(:,3),'FaceAlpha',1,'FaceColor','c');




