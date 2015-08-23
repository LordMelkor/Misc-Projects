clear all
clc
a=0.27;
b=0.97;
d=0.5;
k_star=(a*b)^(1/(1-a));

c_star = k_star^a - k_star;
B=[(-1/b) 1; 0 (-1/(c_star^2))];
blah=-b*(1/c_star)*(a^2-a)*k_star^(a-2);
A=[1 0; blah 1/c_star^2];
J=-inv(A)*B;
[T,S]=eig(J);
T1=inv(T);

kt=.5*k_star:k_star/10:1.5*k_star;
k0=(b*a*d/(1-b*(1-d)))^d;

figure
hold on
plot(kt,c_star-(T1(2,1)/T1(2,2))*(kt-k_star),'g')
plot(kt,(1-k0^(1/d))*kt.^a,'b')
title(sprintf('Plots of Capital vs Consumption; Green=Approx., Blue=Closed-form, d=0.5'))
xlabel('K_{t}')
hold off

d=1;
k0=(b*a*d/(1-b*(1-d)))^d;

figure
hold on
plot(kt,c_star-(T1(2,1)/T1(2,2))*(kt-k_star),'g')
plot(kt,(1-k0^(1/d))*kt.^a,'b')
title(sprintf('Plots of Capital vs Consumption; Green=Approx., Blue=Closed-form, d=1'))
xlabel('K_{t}')
hold off