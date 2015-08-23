clear all;
clc;

alfa=0.3;
bet=0.95;
del=0.1;
gam=1;
rho=0.9;
sig=0.01;
th=[0.4;-0.4;-0.1;-0.5;-0.1;0.1];
T=1000;
tbar=floor(0.1*T);
tol=1e-6;

ep=randn(1,T);

k(1) = 2.57;
z(1) = 0;

checkn=1;

while checkn>tol
    for t=2:T
        z(t,1)=rho*z(t-1)+sig*ep(t);
    end

    for t=1:T
       Phi=exp(th(1)+th(2)*log(k(t))+th(3)*log(k(t))^2+th(4)*z(t)+th(5)*z(t)^2+th(5)*z(t)*log(k(t)));
       c(t,1)=Phi^(-1/gam);
       k(t+1,1)=exp(z(t))*k(t)^alfa+(1-del)*k(t)-c(t);
    end

    k(T+1)=[];

    for i=1:T
        y(i,1)=bet*(c(i)^(-gam))*((alfa*k(i)^(alfa-1))*exp(z(i))+1-del);
    end

    ybar=y(tbar+1:T);
    kbar=k(tbar:T-1);
    zbar=z(tbar:T-1);

    x=[[ones(T-tbar,1)],[log(kbar)],[log(kbar).^2],[zbar],[zbar.^2],[zbar.*log(kbar)]];

    th1=x\log(ybar);

    checkn=max(abs(th1-th));
    
    th=th1;
end