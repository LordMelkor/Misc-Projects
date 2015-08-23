%========================================
% Two-state model
% Referece: Mehra & Prescott results (1985)
% M.Ochoa (c)
%=======================================

clc;
clear all

%Calibration

gama=5.65;			% Risk aversion parameter
beta=0.93;			% Discount factor

pi=[0.428 0.569 0.003;0.569 0.428 0.003; 0.5 0.5 0];	% Transition matrix


Pi=(pi)^10000;				%Stationary distribution
P=Pi(1,1:3)';

l(1,1)=1.054;    %state-space
l(2,1)=0.982;
l(3,1)=0.5090;

%Calculation of price-dividend ratio w

A = [beta*l(1)^(1-gama)*pi(1,1) beta*l(2)^(1-gama)*pi(1,2) beta*l(3)^(1-gama)*pi(1,3); ... 
    beta*l(1)^(1-gama)*pi(2,1) beta*l(2)^(1-gama)*pi(2,2) beta*l(3)^(1-gama)*pi(2,3);
    beta*l(1)^(1-gama)*pi(3,1) beta*l(2)^(1-gama)*pi(3,2) beta*l(3)^(1-gama)*pi(3,3)];
I=ones(3,1);
II=eye(3);
z=inv(II-A)*(A*I);

% Conditional expected returns

Rstock(1) = pi(1,1)*l(1)*((1+z(1))/z(1)) + pi(1,2)*l(2)*((1+z(2))/z(1)) + pi(1,3)*l(3)*((1+z(3))/z(1));
Rstock(2) = pi(2,1)*l(1)*((1+z(1))/z(2)) + pi(2,2)*l(2)*((1+z(2))/z(2)) + pi(2,3)*l(3)*((1+z(3))/z(2));
Rstock(3) = pi(3,1)*l(1)*((1+z(1))/z(3)) + pi(3,2)*l(2)*((1+z(2))/z(3)) + pi(3,3)*l(3)*((1+z(3))/z(3));

% Unconditional return
ERstock = Rstock*P;

% Conditional risk-free rate
Rf(1) = (beta*l(1)^(-gama)*pi(1,1) + beta*l(2)^(-gama)*pi(1,2) + beta*l(3)^(-gama)*pi(1,3))^(-1);
Rf(2) = (beta*l(1)^(-gama)*pi(2,1) + beta*l(2)^(-gama)*pi(2,2) + beta*l(3)^(-gama)*pi(2,3))^(-1);
Rf(3) = (beta*l(1)^(-gama)*pi(3,1) + beta*l(2)^(-gama)*pi(3,2) + beta*l(3)^(-gama)*pi(3,3))^(-1);

% Unconditional risk-free rate
ERf = Rf*P;


% Print table of results
fprintf(1,'_____________________________________________________________________ \n');
disp('Simulation Results (yearly/ pp)');
disp(' ');
fprintf(1,' Statistic       \n');
fprintf(1,'_____________________________________________________________________ \n');
disp([' E[Re]           '               num2str((ERstock-1)*100)  ]);
disp([' E[Rf]           '               num2str((ERf-1)*100)  ]);
disp([' E[Re-Rf]        ' 	    num2str((ERstock-ERf)*100)  ]);
fprintf(1,'_____________________________________________________________________ \n');

