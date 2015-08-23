% Solution of the non-stochastic Ramsey model
% using value function iteration
%
% (c) J Marcelo Ochoa 

% Administrative commands

clear all
%clc

%%
% Initialize: set model's parameters

tic;            % Start Clock counter
tol = 1e-7;      % Tolerance level

alfa=0.27;      % Production function
bet=0.97;     % Subjective discount factor

%
% Characterize the steady state

Kss = (alfa*bet)^(1/(1-alfa));    % Capital stock at the steady state
Css = Kss^alfa - Kss;                         % Consumption at the steady state

%%
% Value function iteration

% Step 1: Choose a grid of admissible values for the state variable
nk=100;                              % Number of grid points for the capital
Kmin=0.2*Kss;
Kmax=1.8*Kss;
K=(Kmin:(Kmax-Kmin)/(nk-1):Kmax)';  % Grid for capital
nk=size(K,1);                       % Number of grid points

% Step 2: Initialize the value function

v0 = ones(nk,1)*log(Css)/(1-bet);   % starting value function
v1 = [];                            % updated value function 
h1 = [];                            % updated policy function 
checkv = 1;

% Step 3. Compute a new value function and policy function

while checkv>=tol*(1-bet);
    % Compute v1 and h1 indexes for each 
    % initial capital stock in the K
    for i=1:nk
        C = K(i)^alfa - K;          % Consumption 
        C = (C>0).*C + (C<=0).*0;   % Replace C=0 if C<=0
        [v1(i,1) h1(i,1)]= max(log(C) + bet*v0);
    end

    % Step 4: Check for convergence/replace v0
    checkv = norm(v1-v0);
    v0 = v1;
end

toc;        % Stop clock

% Compute policy functions

hk = K(h1);
hc = (K.^alfa) - hk;

%%
% Plot the true and approximated policy functions

% Analytical value function policy functions

a = (1/(1-bet))* (log((1-alfa*bet))+alfa*bet*log(alfa*bet)/(1-alfa*bet));
b = alfa/(1- alfa*bet);
vk = a + b*log(K);

hka = (alfa*bet*(K.^alfa));                   % Capital
hca = ((1-alfa*bet)*(K.^alfa));               % Consumption 

%Make Plots

figure(1)
subplot(2,1,1)
plot(K,vk,'-',K,v1,'--');
title(sprintf('Value function approximation using %d grid points',nk))
legend('Analytical','Approximated','Location','Best')
xlabel('K')
ylabel('V(K)')
subplot(2,1,2)
plot(K,(vk-v1));
title('Value function error')
xlabel('K')

figure(2)
subplot(2,1,1)
plot(K,hka,'-',K,hk,'--');
title(sprintf('Capital policy function approximation using %d grid points',nk))
legend('Analytical','Approximated','Location','Best')
xlabel('K')
ylabel('h^K(K)')
subplot(2,1,2)
plot(K,hca,'-',K,hc,'--');
title(sprintf('Consumption policy function approximation using %d grid points',nk))
legend('Analytical','Approximated','Location','Best')
xlabel('K')
ylabel('h^C(K)')
%%
% Print results
% 

fprintf('---------------------------------\n')
fprintf(' Approximation Errors using %d grid points \n',nk)
fprintf('---------------------------------\n')
fprintf(' Value function \n')
fprintf(' v true - v approx  = %6.3f  \n',norm(vk-v1))
fprintf('---------------------------------\n')
fprintf(' Policy functions \n')
fprintf('---------------------------------\n')
fprintf(' hk true - hk approx  = %6.3f  \n',norm(hka-hk))
fprintf(' hc true - hc approx  = %6.3f  \n',norm(hca-hc))
fprintf('---------------------------------\n')
