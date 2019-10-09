load('F_elipse')
load('V_elipse')

P = [2,2,2];

[F_v,A_v] = fases_arestas_visiveis(Tri,V_new,P);

trimesh(Tri, V_new(:,1),V_new(:,2),V_new(:,3),'FaceAlpha',1,'FaceColor','k','LineWidth',0.1,'LineStyle',':');
hold on;
trimesh(F_v, V_new(:,1),V_new(:,2),V_new(:,3),'FaceAlpha',1,'FaceColor','c','LineWidth',0.1,'LineStyle',':');
%plotando as arestas
for i = 1:size(A_v,1)
    X = [ V(A_v(i,1),1),V(A_v(i,2),1) ];
    Y = [ V(A_v(i,1),2),V(A_v(i,2),2) ];
    Z = [ V(A_v(i,1),3),V(A_v(i,2),3) ];
    hold on;
    plot3(X,Y,Z,'LineWidth',3,'Color','m');
end