function [V,F] =  RBF_implicito(P,N,h,k,X,Y,Z)
%Essa função implimenta o RBF implicito usando como RBF a poli-harmonica, 
%para saber qual grau da poli-harmonica se passa o valor k, onde o grau da poli-harmonica eh 2*k + 1, k deve ser natural.
%P e N são respectivamente os pontos e as normais da nossa nuvem de pontos
%h é o offset da RBF_implicita
% X, Y, Z são a malha gerada por um meshgrid para se colocar na funcao isosurface

num_v = size(V,1);

P_mais = V + N_V.*h;
P_menos = V - N_v*h;

P_new = [P;P_mais;P_menos];

f1 = zeros( num_v,1 );
f2 = ones( num_v,1 );
f3 = -1*ones( num_v,1 );

f = [f1;f2;f3];

%matriz com distancia
M_dist = pdist2(P_new,P_new);

M_dist = M_dist.^(2*k + 1);

lambdas = M_dist\f;

V_ = [X(:),Y(:),Z(:)]

dist_V_P =  pdist2( V_,P_new );
dist_V_P = dist_V_P.^(2*k + 1);

for i = 1:size(P_new,1)
  dist_V_P(:,i) = lambdas(i).*dist_V_P(:,i);
end

F_ = sum(dist_V_P,2);

F_ = reshape(F_, [ size(X,1),size(Y,2),size(Z,3) ]);

[F,V] = isosurface(X,Y,Z,F_,0);

