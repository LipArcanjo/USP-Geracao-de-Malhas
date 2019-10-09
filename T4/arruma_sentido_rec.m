function [Tri, Corner,Vet] = arruma_sentido_rec(Tri,Corner,Vet,i)

if Vet(i) == 1
%Vet serve para fazer a pilha recursiva
Vet(i) = 0;

for j = 1:3
    
    
    
	%quer dizer que o triangulo do corner oposto estava com o sentido errado, 
	%fazendo com que nao ache o triangulo pela minha implementacao corner table
	if Corner(3*(i-1) + j ,5) == 0
		nex = 0;
		v1 = Tri(i, mod(j,3) + 1 );
       	v2 = Tri(i, mod(j + 1,3) + 1);
		A  = find(Tri(:,1) == v1 & Tri(:,2) == v2, 1);
       	B  = find(Tri(:,2) == v1 & Tri(:,3) == v2, 1);
       	C  = find(Tri(:,3) == v1 & Tri(:,1) == v2, 1);
	
		
       	%significa nao estar vazio
        if isempty(B) == 0
            k = B(1)*3 - 2;
            nex = B(1);
            aux = Tri(B(1),3);
            Tri(B(3),1) = Tri(B(1),2);
            Tri(B(1),2) = aux;
            Corner( 3*(i-1) + j ,5) = k;
        elseif isempty(C) == 0

           	k = C(1)*3 - 1;
            nex = C(1);
            aux = Tri(C(1),3);
			Tri(C(1),3) = Tri(C(1),1);
			Tri(C(1),1) = aux;
			Corner( 3*(i-1) + j ,5) = k;
       	elseif isempty(A) == 0
           	k = A(1)*3;
			nex = A(1);
			aux = Tri(A(1),1);
			Tri(A(1),1) = Tri(A(1),2);
			Tri(A(1),2) = aux;
			Corner( 3*(i-1) + j ,5) = k;
        end

		%ja arrumei o triangulo, falta arrumar a corner_table, este for seve para isto
		for m = 1:3
			%achando o corner oposto, eh mais complexo do que achar as outras
       			%informações
        
       			v1 = Tri(nex, mod(m,3) + 1 );
       			v2 = Tri(nex, mod(m + 1,3) + 1);
       			A  = find(Tri(:,1) == v2 & Tri(:,2) == v1, 1);
       			B  = find(Tri(:,2) == v2 & Tri(:,3) == v1, 1);
       			C  = find(Tri(:,3) == v2 & Tri(:,1) == v1, 1);
       
       			%significa nao estar vazio
       			if isempty(B) == 0
           			Corner( 3*(nex-1) + m ,5) = B(1)*3 - 2;
      			elseif isempty(C) == 0
           			Corner( 3*(nex-1) + m ,5) = C(1)*3 - 1;
       			elseif isempty(A) == 0
           			Corner( 3*(nex-1) + m ,5) = A(1)*3;
       			end
		end

		%se o triangulo ja foi arrumado em uma recursao mais interior, vai passar direto
		%mas o corner oposto ainda vai ficar com 0, para arrumar isto procuro o corner 
		%oposto denovo do jeito padrao
		A  = find(Tri(:,1) == v2 & Tri(:,2) == v1, 1);
       		B  = find(Tri(:,2) == v2 & Tri(:,3) == v1, 1);
       		C  = find(Tri(:,3) == v2 & Tri(:,1) == v1, 1);
		%significa nao estar vazio
       		if isempty(B) == 0
           		Corner( 3*(i-1) + j ,5) = B(1)*3 - 2;
      		elseif isempty(C) == 0
           		Corner( 3*(i-1) + j ,5) = C(1)*3 - 1;
       		elseif isempty(A) == 0
           		Corner( 3*(i-1) + j ,5) = A(1)*3;
       		end

	end
	%fim da parte onde o corner esta errado
	nex = Corner(Corner( 3*(i-1) + j ,5),2);
	[Tri, Corner,Vet] = arruma_sentido_rec(Tri,Corner,Vet,nex);

end
end