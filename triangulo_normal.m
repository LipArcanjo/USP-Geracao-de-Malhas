function normal = triangulo_normal(ver_1, ver_2, ver_3)
%Esta funcao retorna a normal da fase do triangulo, passando como parametro os seus
%tres vertices
%Os vertices ver_x devem ter dimensao (3);

normal = cross( ver_2 - ver_1,ver_3 - ver_1 );
normal = normal./norm(normal);