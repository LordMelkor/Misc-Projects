clear all;
clc;

alfa=0.27;      % Production function
beta =0.97;     % Subjective discount factor
delta =0.05;        % Capital Depreciation
gama = 1.5;
rho  = 0.9;      % Persitence of productuvity stochastic component
sigma = 0.0067; % Standard Deviation of epsilon

T=1000;
Tbar=0.1*T;
e = randn(T,1);
kss=5.209578;
hkk= 0.920484;
hkz= 0.889531;


css= 1.301002;
hck= 0.110444;
hcz= 0.515802;

z(1)=0;
k(1)=kss;
c(1)=css;

for t=1:T-1
    y(t+1,1) = beta*c(t)^(-gama)*(exp(z(t))*alfa*k(t)^(alfa-1)+1-delta);
    z(t+1,1) = rho*z(t) + e(t);
    k(t+1,1)=kss + hkk*k(t) + hkz*z(t) + 0.006622*e(t);
    c(t+1,1)=css + hck*k(t) + hcz*z(t) + 0.003840*e(t);
end

x = [ones(T,1) log(k) log(k).^2 z z.^2 z.*log(k)];

ybar=y(Tbar+1:T);
xbar=x(Tbar+1:T,:);

theta0 = xbar\log(ybar)