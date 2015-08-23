x = linspace(-1,1);
y = x.^2;
plot(x,y,'b')
hold on
y = linspace(-1,1);
x = y.^2;
plot(x,y,'g')
hold off
title(sprintf('Plot of y=x^2 (blue) and x=y^2 (green)'))
axis([-1,1,-1,1])
xlabel('x')
ylabel('y')
grid