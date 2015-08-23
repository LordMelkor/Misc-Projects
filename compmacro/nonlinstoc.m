%%
% This script solves the deterministic Ramsey model
% 

% Administrative commands

clear all
clc

%%
% Initialize: set model's parameters

alfa=0.27;      % Production function
bet=0.97;     % Subjective discount factor
delta=1;        % Capital Depreciation
rho=0.9;
sig=0.0072;

%%
% Step 1: Characterize the steady state

Zss = 1;
Kss = (Zss*alfa*bet/(1-bet*(1-delta)))^(1/(1-alfa));    % Capital stock at the steady state
Css = Zss*Kss^alfa - delta*Kss;                         % Consumption at the steady state

%%
% Step 2: Approximate the non-linear equations
% characterizing the first-order conditions around the steady-state
%
% E_t |g1|  E_t |K(t+1) - (1-delta)*K(t) - K(t)^alfa + C                         |
%     |g2|=     |C(t)^(-1) - bet*C(t+1)^(-1)*(Z(t+1)*alfa*K(t+1)^(alfa-1)+ 1 -delta)|
% 
% such that we obtain a linear system of the form
% 
%   A E_t |K'(t+1)| = B E_t|K'(t)|
%         |C'(t+1)|        |C'(t)|
%
% where K'(t)=K(t)-Kss 

syms K Kp C Cp Z Zp    % Define the symbolic variables
                        % e.g., C = C(t); Cp=C(t+1)
                       
g1 = Kp - (1-delta)*K - Z*K^alfa + C;
g2 = C^(-1) - bet*Cp^(-1)*(Zp*alfa*Kp^(alfa-1) + 1 - delta);

dg1 = [diff(g1,K); diff(g1,C); diff(g1,Z)];     % Derivative w/r to [K(t),C(t),Z(t)]
dg1p = [diff(g1,Kp); diff(g1,Cp); diff(g1,Zp)]; % Derivative w/r to [K(t+1),C(t+1),Z(t+1)]

dg2 = [diff(g2,K); diff(g2,C); diff(g2,Z)];     % Derivative w/r to [K(t),C(t),Z(t)]
dg2p = [diff(g2,Kp); diff(g2,Cp); diff(g2,Zp)]; % Derivative w/r to [K(t+1),C(t+1),Z(t+1)]

% Evaluate derivatives at steady state
% and transform from symbolic to real matrix

dg1ss = double(subs(dg1,{K,C,Z,Kp,Cp,Zp},{Kss,Css,Zss,Kss,Css,Zss}));
dg1pss = double(subs(dg1p,{K,C,Z,Kp,Cp,Zp},{Kss,Css,Zss,Kss,Css,Zss}));
dg2ss = double(subs(dg2,{K,C,Z,Kp,Cp,Zp},{Kss,Css,Zss,Kss,Css,Zss}));
dg2pss = double(subs(dg2p,{K,C,Z,Kp,Cp,Zp},{Kss,Css,Zss,Kss,Css,Zss}));

% Construct A,B

A = [dg1pss(1:2)';dg2pss(1:2)'];
B = -[dg1ss(1:2)';dg2ss(1:2)'];
C1=-[dg1ss(3);dg2ss(3)];
C2=-[dg1pss(3);dg2pss(3)];

C=C1+rho*C2;

%%
%  Step 3: Re-arrange the model such that it has the form 
%
%     E_t |K'(t+1)| = W E_t|K'(t)|
%         |C'(t+1)|        |C'(t)|
%
% where K'(t)=K(t)-Kss 

W = inv(A)*B;
R = inv(A)*C;

%%
% Step 4: Decompose matrix W using Jordan decomposition

[T,S] = eig(W);     % Obtain Jordan decomposition such that
                    % W = T*S*T^{-1}
                    % S = diag{lambda_1,lambda_2} diagonal matrix 
                    % with the eigenvalues of S
                    
Tinv = inv(T);
lambda = diag(S);   % Store eigenvalues
Q=Tinv*R;

%%
% Step 5: Obtain the policy functions
% using the solution to the linear system 
% of differential equations

hkk = W(1,1) - W(1,2)*Tinv(2,1)/Tinv(2,2)
hkc = -Tinv(2,1)/Tinv(2,2)

hkz = -W(1,2)*Q(2)/(Tinv(2,2)*lambda(2))*(1/(1-(rho/lambda(2))))+R(1)
hcz = -Q(2)/(Tinv(2,2)*lambda(2))*(1/(1-(rho/lambda(2))))

%{
%%
% Print results
% 

fprintf('---------------------------------\n')
fprintf(' Steady state \n')
fprintf('---------------------------------\n')
fprintf(' Consumption %6.3f \n', Css)
fprintf(' Capital %6.3f \n', Kss)
fprintf('---------------------------------\n')
fprintf(' Policy functions \n')
fprintf('---------------------------------\n')
fprintf(' C(t)   = %6.3f K(t)  \n',hc)
fprintf(' K(t+1) = %6.3f K(t)  \n',hk)
fprintf('_________________________________\n')

%%
% Compare policy functions for K = [0,1]

Kmax=1.5*Kss;
Kmin=0.5*Kss
Kgrid = linspace(Kmin,Kmax, 100);
Koptimal = alfa*bet*Kgrid.^alfa;
Coptimal = (1-alfa*bet)*Kgrid.^alfa;

Kapprox = Kss + hk*(Kgrid-Kss);
Capprox = Css + hc*(Kgrid-Kss);

figure(1)
plot(Kgrid,Koptimal,Kgrid,Kapprox,'-.')
title('Policy function for Capital K_{t+1} around +/-50% from K^*')
legend('Closed-form','Approximation','Location','SouthEast')
xlabel('K_t')
ylabel('K_{t+1}')
figure(2)
plot(Kgrid,Coptimal,Kgrid,Capprox,'-.')
title('Policy function for Capital C_t  around +/-50% from K^*')
legend('Closed-form','Approximation','Location','SouthEast')
xlabel('K_t')
ylabel('C_t')

% save policy functions in policy_rules.mat
% save policy_rules hc_k hc_z hk_k hk_z
%}