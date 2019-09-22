function lambdas =  RBF_implicito(V,N_V,h,k)

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
