function Corner = corner_table(V,Tri)

num_tri = size(Tri,1);

Corner = zeros( num_tri*3, 5 );

for i = 1:num_tri
    
    for j = 1:3
       
       Corner( 3*(i-1) + j ,1) = Tri(i,j); %c.v
       Corner( 3*(i-1) + j ,2) = i; %c.t
       Corner( 3*(i-1) + j ,3) = 3*(i-1) + mod(j,3) + 1  ; %c.n
       Corner( 3*(i-1) + j ,4) = 3*(i-1) + mod(j + 1,3) + 1  ; %c.p
       
       %achando o corner oposto, eh mais complexo do que achar as outras
       %informações
        
       v1 = Tri(i, mod(j,3) + 1 );
       v2 = Tri(i, mod(j + 1,3) + 1);
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
       
      
       
       if Corner( 3*(i-1) + j,5 ) == 0
            
            A  = find(Tri(:,1) == v1 & Tri(:,2) == v2 & Tri(:,3) ~= Corner(3*(i-1) + j,1), 1);
            B  = find(Tri(:,2) == v1 & Tri(:,3) == v2 & Tri(:,1) ~= Corner(3*(i-1) + j,1), 1);
            C  = find(Tri(:,3) == v1 & Tri(:,1) == v2 & Tri(:,2) ~= Corner(3*(i-1) + j,1), 1);
           
            
           %significa nao estar vazio
           if isempty(B) == 0
               Corner( 3*(i-1) + j ,5) = B(1)*3 - 2;
           elseif isempty(C) == 0
               Corner( 3*(i-1) + j ,5) = C(1)*3 - 1;
           elseif isempty(A) == 0
               Corner( 3*(i-1) + j ,5) = A(1)*3;
           end
       end
    end
    
end