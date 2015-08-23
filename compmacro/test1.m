clear all
clc

K_star = (1/(.97*.27))^(1/(.27-1));
C_star = K_star^.27 - K_star;

B=[(-1/.97) 1; 0 (-1/(C_star^2))];

blah=-.97*(1/C_star)*(.27^2-.27)*K_star^(.27-2);

A=[1 0; blah 1/C_star^2];

J=-inv(A)*B;

[T,S]=eig(J);

inv(T)