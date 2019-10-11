Rb = @(s) ([s, 4*(s-0.5).^2-1]);
Rt = @(s) ([s, UM]);
Rl = @(s) ([ZERO, s]);
Rr = @(s) ([UM, s]);

build_tfi;

A = zeros(1,15);
B = zeros(1,15);
C = ones(1,15);
D = ones(1,15);


[P,Q] = PQ(eta,xi, A,B,C,D);