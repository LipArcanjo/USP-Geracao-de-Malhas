function [P,Q] = PQ(eta,xi, a,b,c,d)

eta_dif = repmat(eta(:,1),1,size(eta,1));
eta_dif = eta_dif - eta_dif';
eta_dif_mod = eta_dif;
eta_dif_mod(eta_dif_mod < 0) = eta_dif_mod(eta_dif_mod < 0)*-1;
eta_sin_ = eta_dif;
eta_sin_(eta_sin_ > 0) = 1;
eta_sin_(eta_sin_ < 0) = -1;

xi_dif = repmat(xi(1,:),size(xi,2),1);
xi_dif = xi_dif - xi_dif';
xi_dif_mod = xi_dif;
xi_dif_mod(xi_dif_mod < 0) = xi_dif_mod(xi_dif_mod < 0)*-1;
xi_sin_ = xi_dif;
xi_sin_(xi_sin_ > 0) = 1;
xi_sin_(xi_sin_ < 0) = -1;

m = size(xi,1);
n = size(xi,2);

P = zeros(n,m);
Q = zeros(n,m);

for k = 1:m
    
    for l = 1:n
        
        %fazendo o P
        eta_mod = eta_dif_mod(l,:);
        xi_mod = xi_dif_mod(k,:);
        eta_sin = eta_sin_(l,:);
        xi_sin = xi_sin_(k,:);
        
        size(xi_sin)
        P_first = sum( a.*xi_sin.*exp((-c).*xi_mod) );
        size(xi_sin)
        P_second = sum( b.*xi_sin.*exp( (-d).*sqrt( (xi_mod.^2)+( eta_mod.^2 )  ) ) );
        P(l,k) = P_first + P_second;
        
        Q_first = sum( a.*eta_sin.*exp((-c).*eta_mod) );
        Q_second = sum( b.*eta_sin.*exp( (-d).*sqrt( (xi_mod.^2)+( eta_mod.^2 )  ) ) );
        Q(l,k) = Q_first + Q_second;
        
    end
    
end


