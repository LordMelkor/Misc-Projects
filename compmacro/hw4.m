clear all
clc

alfa=0.27;      % Production function
bet=0.97;       % Subjective discount factor
delta=1;        % Capital Depreciation
rho = 0.9;      % Persitence of productuvity stochastic component
sigma = 0.0072; % Standard Deviation of epsilon

% Characterize the steady state
Zss = 1;
Kss = (Zss*alfa*bet/(1-bet*(1-delta)))^(1/(1-alfa));    % Capital stock at the steady state
Css = Zss*Kss^alfa - delta*Kss;                         % Consumption at the steady state

T=1000;          %iterations

k(1)=Kss/T;
lnZ(1)=log(Zss/T);

eps=randn(1,T);

c(1)=0.761*(k(1)-Kss) +0.45*(exp(lnZ(1))-Zss)+Kss;

for i = 1:(T-1)
    lnZ(i+1)=rho*lnZ(i)+sigma*eps(i);
    k(i+1)=0.27*(k(i)-Kss) +0.16*(exp(lnZ(i))-Zss)+Kss;
    c(i+1)=0.761*(k(i+1)-Kss) +0.45*(exp(lnZ(i+1))-Zss)+Css;
end

meanK=mean(k);
varK=var(k);
fprintf('Mean of Capital = %6.3f and Variance of Capital = %6.3f \n',meanK,varK)

meanC=mean(c);
varC=var(c);
fprintf('Mean of Consumption = %6.3f and Variance of Consumption = %6.3f \n',meanC,varC)

T=0:1:T-1;

figure
plot(T,k)
title('Path of Capital Policy function over time')

figure
plot(T,c)
title('Path of Consumption Policy function over time')