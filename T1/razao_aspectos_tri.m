function R = razao_aspectos_tri(V,Tri)
%Esta funcao retorna a média da razão de aspecto de todos os triangulos
%passados, usando a desigualdade de Weizenbock de  passando como parametro
%os vertices V, e os triangulos Tri

R = 0;
for i = 1:size(Tri,1)
    ver_1 = V(Tri(i,1),:);
    ver_2 = V(Tri(i,2),:);
    ver_3 = V(Tri(i,3),:);
    
    a = sqrt( dot(ver_2 - ver_1,ver_2 - ver_1));
    b = sqrt( dot(ver_3 - ver_2,ver_3 - ver_2));
    c = sqrt( dot(ver_1 - ver_3,ver_1 - ver_3));

    s = (a + b + c)/2;

    area = sqrt( s*(s - a)*(s - b)*(s - c) );

    R = 4*sqrt(3)*area/( a^2 + b^2 + c^2 );
end

R = R/size(Tri,1);