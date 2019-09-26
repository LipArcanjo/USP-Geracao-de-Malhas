n = 40;
t = linspace(-1,1,n);

[X,Y,Z] = meshgrid(t);

h = 0.01;
k = 1;

[V,F] =  RBF_implicito(P,N,h,k,X,Y,Z);

trimesh(F,V(:,1),V(:,2),V(:,3),'FaceColor','b','FaceAlpha',1)