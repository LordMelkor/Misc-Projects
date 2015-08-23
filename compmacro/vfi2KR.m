% Administrative commands

clear all
clc

%%
% Initialize: set model's parameters

tic;            % Start Clock counter
tol = 1e-7;      % Tolerance level

alfa=0.27;      % Production function
bet=0.97;     % Subjective discount factor
rho=0.9;
sig=0.0067;
m=9;            %Number of z grid points

%
% Characterize the steady state

Kss = (alfa*bet)^(1/(1-alfa));    % Capital stock at the steady state
Css = Kss^alfa - Kss;                         % Consumption at the steady state

%%
% Value function iteration

% Step 1: Choose a grid of admissible values for the state variable
nk=500;                             % Number of grid points for the capital
Kmin=0.2*Kss;
Kmax=1.8*Kss;
K=(Kmin:(Kmax-Kmin)/(nk-1):Kmax)';  % Grid for capital
nk=size(K,1);                       % Number of grid points
checkv = 1;

[P, pi, z] = artomc(rho,sig^2,3,m);

v0=ones(nk,m)*log(Css)/(1-bet);
v1 = [];                            % updated value function 
h1 = [];                            % updated policy function

while checkv>=tol*(1-bet);
    for j=1:m
        for i=1:nk
            C=exp(z(j))*K(i)^alfa-K;    % Consumption
            if C<0
                C=0;
            end
            [v1(i,j) h1(i,j)]= max(log(C)+bet*(v0*P(j,:)'));
        end
    end
    
    checkv = norm(v1-v0);
    v0 = v1;
end

toc;