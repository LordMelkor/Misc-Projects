x = linspace(-1,1);
y = x.^2;
plot(x,y,'r')
title(sprintf('Graph 1.  Plot of y=x^2 from [-1:1]'))
axis([-2,2,-1,1])
xlabel('x')
ylabel('y')
grid