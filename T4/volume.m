function v = volume(v1,v2,v3,v4)
%retorna o volume do tetraedro dado pelos 4 vertices dados

M = ones(4,4);

M(1,1) = v1(1);
M(1,2) = v1(2);
M(1,3) = v1(3);

M(2,1) = v2(1);
M(2,2) = v2(2);
M(2,3) = v2(3);

M(3,1) = v3(1);
M(3,2) = v3(2);
M(3,3) = v3(3);

M(4,1) = v4(1);
M(4,2) = v4(2);
M(4,3) = v4(3);
v = det(M)./6;
