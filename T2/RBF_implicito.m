function lambdas =  RBF_implicito(V,N_V,h)

num_v = size(V,1);

V_mais = V + N_V.*h;
V_menos = V - N_v*h;

V_new = [V;V_mais;V_menos];

f1 = zeros( num_v,1 );
f2 = ones( num_v,1 );
f3 = -1*ones( num_v,1 );

f = [f1;f2;f3];

%matriz com distancia
M_dist = zeros( 3*num_v, 3*num_v );

for i = 1:num_v*3
    A1 = V_new(:,1) - V_new(i,1); 
    A2 = V_new(:,2) - V_new(i,2); 
    A3 = V_new(:,3) - V(i,3); 
    M_dist(:,i) = sqrt(A1.^2 + A2.^2 + A3.^2);
    
end

lambdas = M_dist\f;
