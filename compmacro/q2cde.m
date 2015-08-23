%%
% This script solves the stochastic growth model
% using the parameterized expectation algorithm
%

% Administrative commands

clear all %T alpha beta c delta e gama k phi rho sigma t x z
clc

rand('state',1)

%%
% Initialize: set model's parameters

tic;            % Start Clock counter

alpha=0.27;      % Production function
beta =0.97;     % Subjective discount factor
delta =0.05;        % Capital Depreciation
gama = 1.5;
rho  = 0.9;      % Persitence of productuvity stochastic component
sigma = 0.0067; % Standard Deviation of epsilon

%%
% Characterize the steady state

zss = 0;
Kss = (alpha*beta/(1-beta*(1-delta)))^(1/(1-alpha));    % Capital stock at the steady state
Css = Kss^alpha - delta*Kss;  

%%
% Step 1. Initialize 

T=20000;         % Time periods to simulate
Tbar = 500;     % Time periods to discard
lambda=1;       % Smoothing parameter
tol = 1e-6;     % Tolerance level
crit=1;         % ||theta0-theta1|| stopping criterion

Tpick		= Tbar+1:T-1;   % Tbar+1,...,T-1
T1pick		= Tbar+2:T;     % Tbar+2,...,T

%We already have theta0, so no need to hard-code it
theta0 = [6.2710 -3.0238 0.1743 -0.0956 0.0224 0.0235]';

fprintf('---------------------------------\n')
fprintf(' Initial value for theta \n')
fprintf('---------------------------------\n')
for i=1:6
fprintf(' theta0(%g) = %6.3f  \n',i,theta0(i))
end
fprintf('---------------------------------\n')

%%
% Step 2: Generate a sequence for aggregate productivity

e		= sigma*randn(T,1);
z		= zeros(T,1);
z(1)	= e(1);
for i	= 2:T;
   z(i)=rho*z(i-1)+e(i);
end


iter	= 1;
while crit>tol;
   %
   % Simulated path
   %
   k		= zeros(T+1,1); % Kt
   lb		= zeros(T,1);   % Phi(K,z)
   X		= zeros(T,length(theta0));  % X vector
   k(1)	= Kss;
   for i	= 1:T;
      X(i,:)= [1 log(k(i)) z(i) log(k(i))*log(k(i)) z(i)*z(i) log(k(i))*z(i)];
      lb(i)	= exp(X(i,:)*theta0);
      k(i+1)=exp(z(i))*k(i)^alpha+(1-delta)*k(i)-lb(i)^(-1/gama);
      if k(i+1) < (1-delta)*k(i)    %Constrain investment to  be positive
          k(i+1) = (1-delta)*k(i)
      end
      I(i) = k(i+1)-(1-delta)*k(i);
   end
   y		= beta*lb(T1pick).*(alpha*exp(z(T1pick)).*k(T1pick).^(alpha-1)+1-delta);
   thetat		= X(Tpick,:)\log(y);
   theta1		= lambda*thetat+(1-lambda)*theta0;
   crit	= max(abs(theta1-theta0));
   theta0		= theta1;
    
   disp(sprintf('Iteration # %2d \tCriterion: %g',iter,crit))
   iter=iter+1;
end;

thetaopt = theta1;
fprintf('---------------------------------\n')
fprintf(' Final value for theta \n')
fprintf('---------------------------------\n')
for i=1:6
fprintf('theta(%g) = %6.3f  \n',i,thetaopt(i))
end
fprintf('\n')
fprintf('x = [1 log(k) z log(k)*log(k) z^2 log(k)*z] \n')
fprintf('---------------------------------\n')

%d.) Plot the policy functions for consumption, capital, and investment
kstate = [0.2*Kss:0.5:1.8*Kss];
zstate = [zss-2*sigma:0.005:zss+2*sigma];
for i = 1:size(kstate,2)
    for j = 1:size(zstate,2)
        cpolicy(i,j) = exp([1 log(kstate(i)) log(kstate(i))^2 z(j) z(j)^2 z(j)*log(kstate(i))]*thetaopt)^(-1/gama);
        kpolicy(i,j) = exp(z(j))*k(i)^alpha+(1-delta)*k(i)-cpolicy(i,j);
        ipolicy(i,j) = kpolicy(i,j)-(1-delta)*k(i);
    end
end
figure(1)
surf(zstate,kstate,cpolicy)
xlabel('Z')
ylabel('K')
zlabel('Consumption choice')
figure(2)
surf(zstate,kstate,kpolicy)
xlabel('Z')
ylabel('K')
zlabel('Capital choice for next period')
figure(3)
surf(zstate,kstate,ipolicy)
xlabel('Z')
ylabel('K')
zlabel('Investment choice')
%e.) For this we can simply use the last 3000 periods of the last
%simulation, since that will have used the correct policy function
iauto = corrcoef(k(17000:20000),k(16999:19999));
cauto = corrcoef(lb(17000:20000).^(-1/gama),lb(16999:19999).^(-1/gama));
iccorr = corrcoef(lb(17000:20000).^(-1/gama),I(17000:20000));
fprintf('Mean investment %1.5f \n',mean(I(17000:20000),2));
fprintf('Investment variance %1.5f \n',var(I(17000:20000)));
fprintf('Investment autocorrelation %1.5f \n',iauto(1,2));
fprintf('-----------------------------------------\n');
fprintf('Mean consumption %1.5f \n',mean(lb(17000:20000).^(-1/gama),1));
fprintf('Consumption variance %1.5f \n',var(lb(17000:20000).^(-1/gama)));
fprintf('Consumption autocorrelation %1.5f \n',cauto(1,2));
fprintf('-----------------------------------------\n');
fprintf('Consumption-investment correlation %1.5f \n',iccorr(1,2));
