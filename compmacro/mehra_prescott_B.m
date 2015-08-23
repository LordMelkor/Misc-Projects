%========================================
% Two-state model
% Referece: Mehra & Prescott results (1985)
% M.Ochoa (c)
%=======================================

clc;
clear all

%Calibration

gama=1;			% Risk aversion parameter
beta=0.99;			% Discount factor

pi=[0.6 0.4;0.57 0.43];	% Transition matrix


Pi=(pi)^10000;				%Stationary distribution
P=Pi(1,1:2)';

mu = 0.018;
delta  = fsolve(@(x) (1+0.018+x)^2*P(1)+(1+0.018-x)^2*P(2)-((1+0.018+x)*P(1)+(1+0.018-x)*P(2))^2-0.036^2,0.5,optimset('Display','off'));

l(1,1)=1+mu+delta;			% State space
l(2,1)=1+mu-delta;

%Calculation of price-dividend ratio w

A = [beta*l(1)^(1-gama)*pi(1,1) beta*l(2)^(1-gama)*pi(1,2); ... 
    beta*l(1)^(1-gama)*pi(2,1) beta*l(2)^(1-gama)*pi(2,2)];
I=ones(2,1);
II=eye(2);
z=inv(II-A)*(A*I);

% Conditional expected returns

Rstock(1) = pi(1,1)*l(1)*((1+z(1))/z(1)) + pi(1,2)*l(2)*((1+z(2))/z(1));
Rstock(2) = pi(2,1)*l(1)*((1+z(1))/z(2)) + pi(2,2)*l(2)*((1+z(2))/z(2));  

% Unconditional return
ERstock = Rstock*P;

% Conditional risk-free rate
Rf(1) = (beta*l(1)^(-gama)*pi(1,1) + beta*l(2)^(-gama)*pi(1,2))^(-1);
Rf(2) = (beta*l(1)^(-gama)*pi(2,1) + beta*l(2)^(-gama)*pi(2,2))^(-1);

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

