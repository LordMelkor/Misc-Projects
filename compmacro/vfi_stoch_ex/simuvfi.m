%%
% This script simulates the stochastic growth model
% using solutions from value function iteration
%
% (c) J Marcelo Ochoa 

% Administrative commands

clear all
clc
rand('state',283)

% Load results from policy function

load smp11

%%
% Simulate Markov chain

T=500;  % Periods to simulate
s0=1;   % Steady-state value of z 
[zsim,state]=simumarkov(P,Z,T,s0);

Ktindex = zeros(T+1,1);
Yt = zeros(T,1);
Ktindex(1) = 5;

for t=1:T
    Ktindex(t+1)=H1(Ktindex(t),state(t));
    Yt(t) = exp(zsim(t))*K(Ktindex(t))^alfa;
    Ct(t) = Yt(t) - K(Ktindex(t+1));
end
Kt = K(Ktindex);

%%
% Simulation results
% 

figure(1)
subplot(3,1,1)
plot(1:T,Kt(2:end))
title('Sample path for K_{t+1}')
subplot(3,1,2)
plot(1:T,Ct)
title('Sample path for C_{t}')
subplot(3,1,3)
plot(1:T,Yt)
title('Sample path for Y_{t}')

fprintf('---------------------------------\n')
fprintf(' Simulation Results for T= %g \n',T)
fprintf('---------------------------------\n')
fprintf(' Mean \n')
fprintf(' E(C)  = %6.3f  \n',mean(Ct))
fprintf(' E(K)  = %6.3f  \n',mean(Kt))
fprintf(' E(Y)  = %6.3f  \n',mean(Yt))
fprintf(' E(z)  = %6.3f  \n',mean(zsim))
fprintf('---------------------------------\n')
fprintf(' Std Dev \n')
fprintf(' std(C)  = %6.3f  \n',std(Ct))
fprintf(' std(K)  = %6.3f  \n',std(Kt))
fprintf(' std(Y)  = %6.3f  \n',std(Yt))
fprintf(' std(z)  = %6.3f  \n',std(zsim))
fprintf('---------------------------------\n')

%%
% Simulation using a polynomial approximation of the policy function


% Approximation of policy function using a polynomial
[ZZ,KK]=meshgrid(Z,K);
KK = log(KK);
Kopt = log(K(H1(:)));
State = [ones(size(Kopt,1),1) ZZ(:) ZZ(:).^2 KK(:) KK(:).^2 ZZ(:).*KK(:)];
bhat = (State'*State)\(State'*Kopt);

Kp = inline('exp([ones(size(k,1),1) z z.^2 log(k) log(k).^2 z.*log(k)]*bhat)','k','z','bhat');

splot=5;
figure(2)
plot(K,K(H1(:,splot)),'ro')
hold on
plot(K,Kp(K,Z(splot)*ones(size(K),1),bhat))
hold off
ylabel('Optimal capital choice');
xlabel('K_t Capital Stock Index');
title('Policy Function for z_t=z_2')
legend('Discrete approx.','Polynomial approx.')

splot=5;
Kopt = alfa*bet*K.^alfa*exp(Z(splot));
figure(3)
plot(K,Kopt,'-x')
hold on
plot(K,Kp(K,Z(splot)*ones(size(K),1),bhat),'r')
hold off
ylabel('Optimal capital choice');
xlabel('K_t Capital Stock Index');
title('Policy Function for z_t=z_5')
legend('Closed form solution','Polynomial approx.')

%%
% Simulation using the approximated policy function


% Simulate AR1 process
T=500;
eps = randn(T,1);
zt = 0;
for t=1:T-1
    zt(t+1)  = rho*zt(t)+sigma*eps(t+1);   % z_t 
end

% Starting values for K and Z
KKt = Kss;
for t=1:T;
    KKt(t+1) = Kp(KKt(t),zt(t),bhat); % k_{t+1}
    YYt(t) = exp(zt(t))*KKt(t)^alfa;
    CCt(t) = YYt(t)-KKt(t+1); % C_{t} 
end

figure(4)
subplot(3,1,1)
plot(1:T,KKt(2:end))
title('Sample path for K_{t+1}')
subplot(3,1,2)
plot(1:T,CCt)
title('Sample path for C_{t}')
subplot(3,1,3)
plot(1:T,YYt)
title('Sample path for Y_{t}')

fprintf('---------------------------------\n')
fprintf(' Simulation Results for T= %g \n',T)
fprintf('---------------------------------\n')
fprintf(' Mean \n')
fprintf(' E(C)  = %6.3f  \n',mean(CCt))
fprintf(' E(K)  = %6.3f  \n',mean(KKt))
fprintf(' E(Y)  = %6.3f  \n',mean(YYt))
fprintf(' E(z)  = %6.3f  \n',mean(zt))
fprintf('---------------------------------\n')
fprintf(' Std Dev \n')
fprintf(' std(C)  = %6.3f  \n',std(CCt))
fprintf(' std(K)  = %6.3f  \n',std(KKt))
fprintf(' std(Y)  = %6.3f  \n',std(YYt))
fprintf(' std(z)  = %6.3f  \n',std(zt))
fprintf('---------------------------------\n')

