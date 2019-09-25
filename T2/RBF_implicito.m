function [V_new,lambdas] =  RBF_implicito(V,N_V,h,k)
%Essa função implimenta o RBF implicito usando como RBF a poli-harmonica, 
%para saber qual grau da poli-harmonica se passa o valor k, onde o grau da poli-harmonica eh 2*k + 1, k deve ser natural.
%V e N_V são respectivamente os vértices e as normais da nossa nuvem de pontos
%h é o offset da RBF_implicita


num_v = size(V,1);

V_mais = V + N_V.*h;
V_menos = V - N_v*h;

V_new = [V;V_mais;V_menos];

f1 = zeros( num_v,1 );
f2 = ones( num_v,1 );
f3 = -1*ones( num_v,1 );

f = [f1;f2;f3];

%matriz com distancia
M_dist = pdist2(V_new,V_new);

M_dist = M_dist.^(2*k + 1);

lambdas = M_dist\f;
