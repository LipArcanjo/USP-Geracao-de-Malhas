% Resolucao dos eixos xi e eta
m = 15 ;
n = 15 ;
ZERO = zeros(m*n,1);
UM = ones(m*n,1);

% Discretizando valores xi e eta
xi  = linspace(0,1,m);
eta = linspace(0,1,n);
[xi,eta] = meshgrid(xi,eta);
xi = xi(:); eta = eta(:);

% Fronteiras do dominio fisico
% Swan
Rb = @(s) ([s, ZERO]);
Rt = @(s) ([s, 1-3*s+3*s.^2]);
Rl = @(s) ([ZERO, s]);
Rr = @(s) ([1+2*s-2*s.^2, s]);
      
% TFI
XY = repmat(1-eta,[1,2]).*Rb(xi)+repmat(eta,[1,2]).*Rt(xi)...
   + repmat(1-xi,[1,2]).*Rl(eta)+repmat(xi,[1,2]).*Rr(eta)...
   - repmat(xi,[1,2]).*repmat(eta,[1,2]).*Rt(UM)...
   - repmat(xi,[1,2]).*repmat(1-eta,[1,2]).*Rb(UM)...
   - repmat(eta,[1,2]).*repmat(1-xi,[1,2]).*Rt(ZERO)...
   - repmat(1-xi,[1,2]).*repmat(1-eta,[1,2]).*Rb(ZERO);
    
X = reshape(XY(:,1),[n,m]);     
Y = reshape(XY(:,2),[n,m]);

eta = etaa;
xi = xii;
% Plotando
figure;
plot_grid(X,Y);