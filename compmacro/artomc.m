function [P,Pi,y]=artomc(rho,s2,m,N)
% ====================================
% Approximation of an AR(1) model
% 
%   y(t) = rho y(t-1) + e(t) with e~N(0,s2)
%
% with a finite-state Markov chain
% 
% INPUT
%   rho : first-order autocorr coeff.
%   s2  : variance of e
%   m   : approx paramter suggested m=3
%   N   : Number of states for the MC suggested N=9
%
% OUTPUT
%   P   : Transition matrix
%   Pi  : Stationary distribution
%   y   : State space
%
% References: Tauchen (1986)
%
% (c) J Marcelo Ochoa 
% ======================================


% Calculate the grid

y = zeros(N,1);
y(N) = m*sqrt(s2/(1-rho));  % Calculate y_n
y(1) = -y(N);               % Set y_1 
w = (y(N)-y(1))/(N-1);      


for i=2:N-1;
   y(i)=y(i-1)+w;  % Fill y_2,...,y_{N-1}
end;

% Calculate the transition probabilities P(i,j)=Pr[y_t=j|y_{t-1}=i]

P = zeros(N,N);

for i=1:N;
    P(i,1) = cdf('norm',y(1)-rho*y(i)+w/2,0,sqrt(s2));
    P(i,N) = 1-cdf('norm',y(N)-rho*y(i)-w/2,0,sqrt(s2));
    for j=2:(N-1)
        P(i,j) = cdf('norm',y(j)-rho*y(i)+w/2,0,sqrt(s2))-cdf('norm',y(j)-rho*y(i)-w/2,0,sqrt(s2));
    end
end;

% Calcultae the ergodic probabilities for and N-state Markov Chain
% solving a linear set of equations

em = [zeros(N,1);1];
A = [eye(N)-P'; ones(1,N)];
Pi = inv(A'*A)*(A'*em);

 