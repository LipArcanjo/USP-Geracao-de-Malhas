[V,Tri] = read_obj('cow.obj');

Corner = corner_table(V,Tri);

[N_F,N_V] = normal_fases_vertices( V,Tri,Corner );

C = zeros( size(Tri,1),3 );
for i = 1:size(Tri,1)
    C(i,:) = (V(Tri(i,1),:) + V(Tri(i,2),:) + V(Tri(i,3),:) )./3;
end

% quiver3( C(:,1),C(:,2),C(:,3),N_F(:,1),N_F(:,2),N_F(:,3),'Color','r' );
quiver3( V(:,1),V(:,2),V(:,3),N_V(:,1),N_V(:,2),N_V(:,3),'Color','b' );