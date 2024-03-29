% Metodo de Jacobi para itera��es
err = inf;
tol = 1e-4;
iter = 0;

while (err > tol)
    err = 0;
    iter = iter + 1;
    
    X_new = X;
    Y_new = Y;
    
    for j=2:m-1
       for i=2:n-1
            
            % Tensores metricos
            c = (X(i+1,j)-X(i-1,j))^2 + (Y(i+1,j)-Y(i-1,j))^2 ;
            a = (X(i,j+1)-X(i,j-1))^2 + (Y(i,j+1)-Y(i,j-1))^2 ;
            b = (X(i+1,j)-X(i-1,j)) * (X(i,j+1)-X(i,j-1)) + (Y(i+1,j)-Y(i-1,j)) * (Y(i,j+1)-Y(i,j-1));
            
            %determinante g
            g = a*c - (b.^2);
            
            %fazendo a parte do P e do Q
            kx_1 = P(i,j)*( X(i+1,j)-X(i-1,j) );
            kx_2 = Q(i,j)*( X(i,j+1)-X(i,j-1) );
            kx = g*( kx_1 + kx_2 );
            
            
            xtemp = 1/(2*(a+c))*(...
                a*X(i+1,j) - 0.5*b*X(i+1,j+1) + 0.5*b*X(i+1,j-1)+ ...
                c*X(i,j+1) + c*X(i,j-1) + ...
                a*X(i-1,j) - 0.5*b*X(i-1,j-1) + 0.5*b*X(i-1,j+1) - kx );
            
            %fazendo a parte do P e do Q
            kx_1 = P(i,j)*( Y(i+1,j)-Y(i-1,j) );
            kx_2 = Q(i,j)*( Y(i,j+1)-Y(i,j-1) );
            kx = g*( kx_1 + kx_2 );
            
            ytemp = 1/(2*(a+c))*(...
                a*Y(i+1,j) - 0.5*b*Y(i+1,j+1) + 0.5*b*Y(i+1,j-1)+ ...
                c*Y(i,j+1) + c*Y(i,j-1) + ...
                a*Y(i-1,j) - 0.5*b*Y(i-1,j-1) + 0.5*b*Y(i-1,j+1) - kx );
            
            err = err + (X(i,j)-xtemp)^2 + (Y(i,j)-ytemp)^2;
            
            X_new(i,j) = xtemp;
            Y_new(i,j) = ytemp;
      end
    end
   
    X = X_new;
    Y = Y_new;
    err = sqrt(err);
end

fprintf(1,'Numero de iteracoes de Jacobi: %d\n',iter);

% Plotando
figure
plot_grid(X,Y)