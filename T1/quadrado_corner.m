V = zeros(4,3);

V(1,:) = [ 0,0,0 ];
V(2,:) = [ 1,0,0 ];
V(3,:) = [ 0,1,0 ];
V(4,:) = [ 1,1,0 ];

Tri = zeros(2,3);

Tri(1,:) = [ 1,2,3 ];
Tri(2,:) = [4,3,2];

Corner = corner_table(V,Tri);

trimesh(Tri, V(:,1),V(:,2), V(:,3),'FaceAlpha',0.5,'FaceColor','c');