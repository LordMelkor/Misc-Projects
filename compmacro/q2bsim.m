clear all
% Parameters
alpha=0.27;      % Production function
beta =0.97;     % Subjective discount factor
delta =0.05;        % Capital Depreciation
gama = 1.5;
rho  = 0.9;      % Persitence of productuvity stochastic component
sigma = 0.0067; % Standard Deviation of epsilon
%
T = 5000;
e = normrnd(0,1,T);
%Starting values - these are just eyeballed from graphs
z = e(1);
k = 70;
c = 10;
phi = c^-gama;
%Simulate z, c, k, and phi
for t = 2:T
    z(t,1) = rho*z(t-1) + e(t);
    c(t,1) = [1.301002 0.110444 0.487946 0.003632]*[1 k(t-1) z(t-1) e(t)]';
    k(t,1) = [5.209578 0.920484 0.917386 0.006829]*[1 k(t-1) z(t-1) e(t)]';
    phi(t,1) = beta*c(t)^(-gama)*(exp(z(t))*alpha*k(t)^(alpha-1)+1-delta);  %This is the quantity inside the conditional expectation
end
%Generate the x vector
x = [ones(5000,1) log(k) log(k).^2 z z.^2 z.*log(k)];
%Calculate theta0 as simply the OLS regression of x on phi
theta0 = inv(x'*x)*(x'*log(phi))