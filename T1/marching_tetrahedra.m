n1 = 20;
n2 = 20;
n3 = 20;

a = linspace(-3,3,m);
[X,Y,Z] = meshgrid(a);

X = X(:);
Y = Y(:);
Z = Z(:);
%eh V_M por ser os vertices do meshgrid para o marching tetrahedra, e nao
%os vertices finais da nossa isosurfice
V_M = [X,Y,Z ];

F = @(X,Y,Z) ( X.^2 + Y.^2 + Z.^2 - 2  );
F_V = F(X,Y,Z);

%faco isso para nao ter o problema de um V ser exatamento 0, que seria um
%problema da forma que implemento
F_V(F_V == 0) = 1e-15;

%aqui vai ser guardado os vertices da nossa isosurfice, vou adicionando
%vertices com o tempo;
V = zeros(0,3);
num_v = 0;

%aqui vai ser guardado os triangulos da nossa isosurfice, vou adicionando
%triangulos com o tempo;
Tri = zeros(0,3);
num_tri = 0;


%indexacao de um vertice i,j,k para seu indice em V_M, R_IND eh o inverso,
%dado o indice em V_M, retorna i,j,k;
IND = @(i,j,k) ( (i-1)*n1 + j + (k-1)*n1*n3 );
R_IND = @(p) [  floor( mod( p,(n1*n3) )/n1 ) , mod(p,n1) ,  floor( p/(n1*n3) ) ];

%cada posicao arestas(p,:) representa os vertices (indice do vertice em V)
%que estao ligados ao vertice p ( IND(i,j,k)) tais que os indices (p,k)
%representam os vertices: 
% arestas(p,1) -> (i,j+1,k)   % arestas(p,5) -> (i,j+1,k+1)
% arestas(p,2) -> (i+1,j,k)   % arestas(p,6) -> (i+1,j,k+1)
% arestas(p,3) -> (i+1,j+1,k) % arestas(p,7) -> (i,j+1,k+1)
% arestas(p,4) -> (i,j,k+1)
arestas = zeros( size(V_M,1),7 );
IND_ARESTA = @(i,j,k) (i*2 + j + 4*k);
R_IND_ARESTA = @(p) [  floor( mod(p,4)/2 ) , mod(p,2) , floor(p/4) ];

%Esta parte do codigo calcula os vetor arestas e o V
for i = 1:n1-1
for j = 1:n2-1
for k = 1:n3-1  
    p = IND(i,j,k);
    for b = 1:7
                
    	q_ = [i,j,k] + R_IND_ARESTA(p);
    	q = IND( q_(1), q_(2), q_(3) );
        if F(p)*F(q) < 0
                    
        	t = F(p)/( F(p)-F(q) );
                    
            num_v = num_v + 1;
        	V(num_v,:) = (1 - t)*V_M(p,:) + t*V_M(q,:);
        	arestas(p, b) = num_v;
                    
        end
    end  
end
end
end

for i = 1:n1-1
for j = 1:n2-1
for k = 1:n3-1 
    %os tetraedros
    Tetra = zeros(6,4);
    
    for u = 1:6
        Tetra(u,1) = IND(i,j,k);
        Tetra(u,4) = IND(i+1,j+1,k+1);
    end
    
    Tetra(1,2) = IND(i,j,k+1);
    Tetra(1,3) = IND(i+1,j,k+1);
    
    Tetra(2,2) = IND(i,j,k+1);
    Tetra(2,3) = IND(i,j+1,k+1);
    
    Tetra(3,2) = IND(i+1,j,k);
    Tetra(3,3) = IND(i+1,j,k+1);
    
    Tetra(4,2) = IND(i+1,j,k);
    Tetra(4,3) = IND(i+1,j+1,k);
    
    Tetra(5,2) = IND(i,j+1,k);
    Tetra(5,3) = IND(i,j+1,k+1);
    
    Tetra(6,2) = IND(i,j+1,k);
    Tetra(6,3) = IND(i+1,j+1,k);
    %passando pelos tetraedros criando os triangulos
    for u = 1:6
        
        IND_POS = Tetra(u, F_V(Tetra(u,:) ) > 0 );
        IND_NEG = Tetra(u, F_V(Tetra(u,:) ) < 0 );
        
        %caso onde ha dois triangulos no tetraedro
        if size(IND_POS,1) == 2
        
            
        %caso onde a apenas um triangulo no tetraedro
        elseif size(IND_POS,1) == 1 || size(IND_POS,1) == 3
            
            %serve para ver se o triangulo serve a regra da mao direita
            pivo = V(IND_POS(1),:);
            
            %tratando para o caso ==3 ficar igual ao ==1. ja que eles ja
            %sao parecidos
            if size(IND_POS,1) == 3
                pivo = -1*V(IND_NEG(1),:);
                aux = IND_POS;
                IND_POS = IND_NEG;
                IND_NEG = aux;
            end
            %acaba tratamento
            
            Tri_temp = zeros(1,3);
            
            for b = 1:3
                mi = min( IND_POS(1),IND_NEG(b) );
                ma = max( IND_POS(1),IND_NEG(b) );
                
                dif = R_IND(ma) - R_IND(mi);
                q = IND_ARESTA( def(1),def(2),def(3) );
                
                Tri_temp(b) = arestas(mi,q);
            end
            
            %fazendo o triangulo seguir a regra da mão direita
            %para ver se o triangulo esta na ordem certa, basta apenas
            %fazer o produto interno da normal do triangulo com o vetor
            %(pivo - C), onnde C é o centro do triangulo, e ver o sinal
            v1 = V(Tri_temp(1),:); 
            v2 = V(Tri_temp(2),:);
            v3 = V(Tri_temp(3),:);
            
            normal = triangulo_normal( v1,v2,v3 );
            
            C = (v1 + v2 + v3)./3;
            %significa que a ordem esta errada, estao da um swap entre o
            %primeiro e o segundo vertice do triangulo
            if dot(normal,pivo - C) < 0
                aux = Tri_temp(1);
                Tri_temp(1) = Tri_temp(2);
                Tri_temp(2) = aux;
            end
            
            num_tri = num_tri + 1;
            Tri(num_tri,:) = Tri_temp;
            
        end
        
    end
    
end
end
end



