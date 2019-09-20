function V_new = suavizacao_vertices(V,Tri,Corner, N_V)
%esta funcao suaviza os vertices para melhorar as qualidades dos
%triangulos,passando como parametros os vertices V, os triangulos Tri, a
%corner table Corner, e as normais dos vertices N_V

V_new = V;

alfa = 0.01;

for i = 1: size(V,1)
    %corner que o vertice esta ligado
    Cs = find(Corner(:,1) == i);
    um_anel = zeros(1,2*size(Cs,1) );

    for j = 1:size(Cs,1)
        %adicionando o vertice do proximo corner
        um_anel(j*2 - 1) = Corner( Corner(Cs(j),3) ,1);
        %adicionando o vertice do corner anterior
        um_anel(j*2) = Corner( Corner(Cs(j),4) ,1);
    end
    %removendo os repetidos, para um vertice do 1 anel nao acabar tendo
    %mais peso que outros na suavizacao

    um_anel = unique(um_anel);

    %calculando o baricentro
    b = zeros(1,3);
    for j = 1:size(um_anel,2)
        b = b + V_new( um_anel(j) ,:);
    end
    b = b./size(um_anel,2);
    
    d = b - V_new(i,:);
    V_new(i,:) = V_new(i,:) + alfa*( d - dot(d,N_V(i,:).*N_V(i,:) ) );
end