function N_V = normal_vertices( V,Tri,Corner )
%Esta funcao retorna as normais dos vertices calculadas atraves de Gouraud,
%passando como parametros os vertices V, os triangulos Tri, e a corner
%table Corner

N_V = zeros( size(V,1),3 );

num_tri = size(Tri,1);


for i = 1:num_tri
    
    ind_v1 = Corner( 3*i - 2 ,1);
    ind_v2 = Corner( 3*i - 1 ,1);
    ind_v3 = Corner( 3*i ,1);
    
    ver_1 = V(ind_v1 ,:);
    ver_2 = V(ind_v2, :);
    ver_3 = V(ind_v3, :);
    
    normal = triangulo_normal(ver_1, ver_2, ver_3);
    normal = normal*triangulo_area(ver_1,ver_2,ver_3);
    
    
    N_V( ind_v1, : ) = N_V(ind_v1,:) + normal;
    N_V( ind_v2, : ) = N_V(ind_v2,:) + normal;
    N_V( ind_v3, : ) = N_V(ind_v3,:) + normal;
    
end

for i = 1: size(V,1)
    N_V(i,:) = N_V(i,:)./norm(N_V(i,:));
end