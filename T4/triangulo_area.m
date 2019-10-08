function area = triangulo_area(ver_1,ver_2, ver_3)
%Esta funcao retorna a area do triangulo, passando como parametro os seus
%tres vertices
%Os vertices ver_x devem ter dimensao (3);

a = sqrt( dot(ver_2 - ver_1,ver_2 - ver_1));
b = sqrt( dot(ver_3 - ver_2,ver_3 - ver_2));
c = sqrt( dot(ver_1 - ver_3,ver_1 - ver_3));

s = (a + b + c)/2;

area = sqrt( s*(s - a)*(s - b)*(s - c) );