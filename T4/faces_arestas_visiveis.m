function [F_v,A_v] = faces_arestas_visiveis(F,V,P)
%Esta funcao retorna as fases e arestas visiveis de um fecho convexo em
%relação a um ponto passado
% param - F,V são as faces e vertices do fecho convexo
% param - P eh o ponto ao qual queremos saber que fases são visiveis

% retorno - F_V - faces visiveis ao ponto
% retorno - A_v - arestas que eh compartilhada por faces visiveis e nao
% visiveis

Corner = corner_table(V,F);

F = arruma_sentido_rec(F,V,Corner);
%descobrindo as fases que estao na
F_v = [];
cont_fases = 0;

for i = 1:size(F,1)
    
    v1 = V(F(i,1),:);
    v2 = V(F(i,2),:);
    v3 = V(F(i,3),:);

    %quer dizer que o ponto consegue ver a aresta
    if volume(v1,v2,v3,P) < 0
        cont_fases = cont_fases + 1;
        F_v(cont_fases) = i;
    end
end
%aqui esta so os indices do triangulos em F_v, agr coloco os proprios
%triangulos em F_v;
ind_F_v = F_v;
F_v = F(F_v,:);

A_v = zeros(0,2);
cont_aresta = 0;
for p = 1:size(F_v,1)
    i = ind_F_v(p);
    for j = 1:3
        %pegando o triangulo que o corner oposto esta contido
        k = Corner(Corner( 3*(i-1) + j, 5),2);
        v1 = V(F(k,1),:);
        v2 = V(F(k,2),:);
        v3 = V(F(k,3),:);
        %quer dizer que o ponto nao consegue ver o triangulo, significando
        %que o triangulo representado por i tem uma aresta de retorno
        if volume(v1,v2,v3,P) > 0
            
            aux = [ F(i, mod(j,3) + 1),F(i, mod(j + 1,3)  + 1) ];
            cont_aresta = cont_aresta + 1;
            A_v(cont_aresta,:) = aux;
            
        end
        
    end
    
end
