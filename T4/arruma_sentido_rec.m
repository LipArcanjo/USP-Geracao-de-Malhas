function Tri = arruma_sentido_rec(Tri,V,Corner)

C = sum(V,1)./3;

for i = 1:size(Tri,1)
    
    v1 = V(Corner( 3*(i-1) + 1,1 ),:);
    v2 = V(Corner( 3*(i-1) + 2,1 ),:);
    v3 = V(Corner( 3*(i-1) + 3,1 ),:);
    
    if volume( v1,v2,v3, C ) < 0
        
        aux = Tri(i,1);
        Tri(i,1) = Tri(i,2);
        Tri(i,2) = aux;
        
    end
    
end