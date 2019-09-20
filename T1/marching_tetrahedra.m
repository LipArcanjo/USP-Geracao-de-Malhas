function [Tri,V] = marching_tetrahedra(X,Y,Z,F)
%Esta funcao gera um Shared Vertex de uma isosuperfice, para isto passe os
%pontos gerados pelo meshgrid ( passe direto o que saiu no mesh grid nao
%altere!!), e o valor da isosurfice no pontos.
%Exemplo de como gerar os pontos pelo meshgrid:
%
%n1 = 40; n2 = 50; n3 = 30;
%a = linspace(-3,3,n1); b = linspace(-3,3,n2); c = linspace(-3,3,n3);
%[X,Y,Z] = meshgrid(a,b,c);
%
%F = @(X,Y,Z) ( 2*X.^2 + Y.^2 + Z.^2 -1  ).^3 - (0.1.*X.^2 + Y.^2).*(Z.^3);
%F_V = F(X,Y,Z);
%
%[Tri,V] = marching_tetrahedra(X,Y,Z,F_V); %chamada da funcao

n1 = size(X,2);
n2 = size(Y,1);
n3 = size(Z,3); 

X = X(:);
Y = Y(:);
Z = Z(:);
F = F(:);
%eh V_M por ser os vertices do meshgrid para o marching tetrahedra, e nao
%os vertices finais da nossa isosurfice
V_M = [X,Y,Z ];

%faco isso para nao ter o problema de um V ser exatamento 0, que seria um
%problema da forma que implemento
F(F == 0) = 1e-15;

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
IND = @(i,j,k) ( (i-1)*n2 + j + (k-1)*n1*n2 );
R_IND = @(p) [  floor( mod( p,(n1*n2) )/n2 ) , mod(p,n2) ,  floor( p/(n1*n2) ) ];

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
for i = 1:n1
for j = 1:n2
for k = 1:n3  
    p = IND(i,j,k);
    for b = 1:7
                
    	q_ = [i,j,k] + R_IND_ARESTA(b);
        
        if( q_(1) <= n1 && q_(2) <= n2 && q_(3)<= n3 )
        
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
        
        IND_POS = Tetra(u, F(Tetra(u,:) ) > 0 );
        IND_NEG = Tetra(u, F(Tetra(u,:) ) < 0 );
        
        %caso onde ha dois triangulos no tetraedro
        if size(IND_POS,2) == 2
            
            Tris = zeros(2,3);
            
            for b = 1:2
            for c = 1:2
                mi = min( IND_POS(b),IND_NEG(c) );
                ma = max( IND_POS(b),IND_NEG(c) );
                
                
                dif = R_IND(ma) - R_IND(mi);
                q = IND_ARESTA( dif(1),dif(2),dif(3) );
                
                Tris(b,c) = arestas(mi,q);
            end    
            end
            
            for b = 1:2
                mi = min( IND_POS(3 - b), IND_NEG(3 - b) );
                ma = max( IND_POS(3 - b), IND_NEG(3 - b) );
                
                dif = R_IND(ma) - R_IND(mi);
                q = IND_ARESTA( dif(1),dif(2),dif(3) );
                
                Tris(b, 3) = arestas(mi,q);
            end
            
            %aqui os dois triangulos estao com os vertices, so falta fazer
            %os triangulos seguir a regra da mao direita, uso o for a
            %seguir para fazer isto e ja guardar no vetor de triangulos
            for b = 1:2
                
                pivo = V_M(IND_POS(b),:);
                
                %fazendo o triangulo seguir a regra da mão direita
                %para ver se o triangulo esta na ordem certa, basta apenas
                %fazer o produto interno da normal do triangulo com o vetor
                %(pivo - C), onnde C é o centro do triangulo, e ver o sinal
                v1 = V(Tris(b,1),:); 
                v2 = V(Tris(b,2),:);
                v3 = V(Tris(b,3),:);

                normal = triangulo_normal( v1,v2,v3 );

                C = (v1 + v2 + v3)./3;
                %significa que a ordem esta errada, estao da um swap entre o
                %primeiro e o segundo vertice do triangulo
                if dot(normal,pivo - C) < 0
                    aux = Tris(b,1);
                    Tris(b,1) = Tris(b,2);
                    Tris(b,2) = aux;
                end

                num_tri = num_tri + 1;
                Tri(num_tri,:) = Tris(b,:);
            end
        
            
        %caso onde a apenas um triangulo no tetraedro
        elseif size(IND_POS,2) == 1 || size(IND_POS,2) == 3
            
            %serve para ver se o triangulo serve a regra da mao direita
            pivo = V_M(IND_POS(1),:);
            alf = 1;
            %tratando para o caso ==3 ficar igual ao ==1. ja que eles ja
            %sao parecidos
            if size(IND_POS,2) == 3
                pivo = V_M(IND_NEG(1),:);
                alf = -1;
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
                q = IND_ARESTA( dif(1),dif(2),dif(3) );
                
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
            if dot(normal,  alf*(pivo - C)  ) < 0
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
