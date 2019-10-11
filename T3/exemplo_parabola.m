RRb = @(s,ZERO,UM)  ([s, 4*(s-0.5).^2-1]);
RRt = @(s,ZERO,UM) ([s, UM]);
RRl = @(s,ZERO,UM) ([ZERO, s]);
RRr = @(s,ZERO,UM) ([UM, s]);

build_tfi;

A1 = zeros(1,15);
B1 = zeros(1,15);
C1 = ones(1,15);
D1 = ones(1,15);
A2 = zeros(1,15);
B2 = zeros(1,15);
C2 = ones(1,15);
D2 = ones(1,15);

%A1(15) = 4;
%B1(15) = 4;

[P,Q] = PQ(eta,xi, A1,B1,C1,D1, A2,B2,C2,D2);

gauss;
%SOR;
%jacobi;