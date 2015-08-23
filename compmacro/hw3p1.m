clear all
clc
n=100;
a=0.27;
b=0.994;
k_star=(a*b)^(1/(1-a));
k(1)=0.1*k_star;
c(1)=(1-(a*b))*k(1)^a;

for i = 1:(n-1)
    k(i+1)=a*b*(k(i)^a);
    c(i+1)=(1-(a*b))*k(i+1)^a;
end

hold on
plot(k,'g')
plot(c,'b')
title(sprintf('Plot of capital and consumption'))
xlabel('time')
hold off