clear all;
clc;

alpha=0.27;
beta=0.94;
m=100;

kss=(alpha*beta)^(1/(1-alpha));
css=kss^alpha-kss;

kmin=kss-0.8*kss;
kmax=kss+0.8*kss;
sp=(kmax-kmin)/(m-1);

Kgrid=kmin:sp:kmax;

Vgrid=(log(css)/(1-beta))*ones(1,m);

c=Kgrid(25)^alpha-Kgrid
[v,h]=max(log(c)+beta*Vgrid)

%[h(1) v(1)]=max(log(Kgrid(1)^alpha-Kgrid)+beta*Vgrid)