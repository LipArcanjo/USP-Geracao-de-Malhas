
RRb = @(s,ZERO,UM) ([s, ZERO]);
RRt = @(s,ZERO,UM) ([s, 1-3*s+3*s.^2]);
RRl = @(s,ZERO,UM) ([ZERO, s]);
RRr = @(s,ZERO,UM) ([1+2*s-2*s.^2, s]);
build_tfi;

A1 = zeros(1,15);
B1 = zeros(1,15);
C1 = ones(1,15);
D1 = ones(1,15);
A2 = zeros(1,15);
B2 = zeros(1,15);
C2 = ones(1,15);
D2 = ones(1,15);

%temp = [12,13,14];
%A2(temp) = 1;
%B2(temp) = 1;
%temp = [1,2,3,4,5,6,7];
%A2(temp) = -1;
%A2(temp) = -1;
%A2(15) = 5;
%B2(15) = 3;


[P,Q] = PQ(eta,xi, A1,B1,C1,D1, A2,B2,C2,D2);

gauss;
%SOR;
%jacobi;