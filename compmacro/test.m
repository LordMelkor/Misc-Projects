B=[0.5,0.7;.2, .4]
eps=randn(2,100);

x=[0;0]

for i=1:100
    xt(:,i)=x
    x=B*x+eps(:,i);
end

plot(xt(1,:),'g')
hold on
plot(xt(2,:),'b')
hold off