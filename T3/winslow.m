% Mesh Generation -- SME5827 -- ICMC-USP
% Author: Afonso Paiva -- apneto@icmc.usp.br
% Date: 2013/09/11
%
% Winslow Equations with Gauss-Seidel Method
%

build_tfi;



% Equacoes de Winslow
err = inf;
tol = 1e-4;
iter = 0;

while (err > tol)
    err = 0;
    iter = iter + 1;
    for j=2:m-1
       for i=2:n-1
            
            % Tensores metricos
            c = (X(i+1,j)-X(i-1,j))^2 + (Y(i+1,j)-Y(i-1,j))^2 ;
            a = (X(i,j+1)-X(i,j-1))^2 + (Y(i,j+1)-Y(i,j-1))^2 ;
            b = (X(i+1,j)-X(i-1,j)) * (X(i,j+1)-X(i,j-1)) + (Y(i+1,j)-Y(i-1,j)) * (Y(i,j+1)-Y(i,j-1));
            
            xtemp = 1/(2*(a+c))*(...
                a*X(i+1,j) - 0.5*b*X(i+1,j+1) + 0.5*b*X(i+1,j-1)+ ...
                c*X(i,j+1) + c*X(i,j-1) + ...
                a*X(i-1,j) - 0.5*b*X(i-1,j-1) + 0.5*b*X(i-1,j+1) );
            
            ytemp = 1/(2*(a+c))*(...
                a*Y(i+1,j) - 0.5*b*Y(i+1,j+1) + 0.5*b*Y(i+1,j-1)+ ...
                c*Y(i,j+1) + c*Y(i,j-1) + ...
                a*Y(i-1,j) - 0.5*b*Y(i-1,j-1) + 0.5*b*Y(i-1,j+1) );
            
            err = err + (X(i,j)-xtemp)^2 + (Y(i,j)-ytemp)^2;
            
            X(i,j) = xtemp;
            Y(i,j) = ytemp;
      end
   end
   err = sqrt(err);
end

fprintf(1,'Numero de iteracoes de Gauss-Seidel: %d\n',iter);

% Plotando
figure
plot_grid(X,Y)
