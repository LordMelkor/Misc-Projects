%
% Basic RBC Model
%

%----------------------------------------------------------------
% 0. Housekeeping
%----------------------------------------------------------------

close all

%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------

var Y C K G z g N tau;
varexo ez eg;

parameters alfa del bet gam th rhoz rhog sigz sigg psi TR gparam; 

%----------------------------------------------------------------
% 2. Calibration
%----------------------------------------------------------------

bet=    0.99;
alfa=   0.6;
rhoz=   0.9;
rhog=   0.95;
gam=    2;
del=    0.02;
sigz=   0.007;
sigg=   0.01;
psi=    0.5;
TR=     0;
th=     1.6294;
gparam = 0.290085;


%----------------------------------------------------------------
% 3. Model
%----------------------------------------------------------------

model;
  Y = exp(z)*N^(alfa)*K(-1)^(1-alfa);
  th*(C+psi*G) = alfa*(1-tau)*(1-N)*(Y/N);
  ((C+psi*G)^(-gam))*(1-N)^(th*(1-gam)) = bet*(C(+1)+psi*G(+1))^(-gam)*(1-N(+1))^(th*(1-gam))*(1-del+(1-tau)*(1-alfa)*Y(+1)/K);
  K = (1-tau)*Y+(1-del)*K(-1)-C+TR;
  tau*Y = G+TR;
  G = exp(g)*gparam;
  z = rhoz*z(-1)+sigz*ez;
  g = rhog*g(-1)+sigg*eg;
end;

%----------------------------------------------------------------
% 4. Steady-State
%----------------------------------------------------------------
zss = 0;
tss = 0.2;
ykss = (1/((1-tss)*(1-alfa)))*(1/bet-1+del);
ckss = ykss*(1.2-2*tss) + (1-del) -1;
ycss = ykss/ckss;
Nss = (((ycss^-1)*th+th*psi*0.2)/(alfa*(1-tss))+1)^-1;
kss = (((1/bet)+del-1)/((1-tss)*(1-alfa)*Nss^alfa))^(-1/alfa);
css = ckss*kss;
yss = ykss*kss;

%----------------------------------------------------------------
% 5. Computation
%----------------------------------------------------------------


initval;
  Y = yss;
  K = kss;
  C = css;
  N = Nss;
  tau = tss;
  G = gparam;
  z = 0;
  g = 0;
  ez = 0;
  eg = 0;
end;

shocks;
  var eg = 1;
end;

steady;

stoch_simul(order = 1,periods=500,irf=40);