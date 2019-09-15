[V,Tri] = read_obj('bunny.obj');

Corner = corner_table(V,Tri);

N_V = normal_vertices( V,Tri,Corner );

quiver3( V(:,1),V(:,2),V(:,3),N_V(:,1),N_V(:,2),N_V(:,3) );



