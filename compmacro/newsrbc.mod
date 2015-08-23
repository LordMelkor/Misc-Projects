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

var y c k R z N;
varexo e;

parameters alfa delta bet eta theta a rho sigma; 

%----------------------------------------------------------------
% 2. Calibration
%----------------------------------------------------------------

alfa    =  1-0.637;
delta   =  0.0195;
bet     =  0.994;
eta     =  2; 
theta   =  3.0956;
a       = 1.0034;
rho     = 0.999;
sigma   = 0.00677;


%----------------------------------------------------------------
% 3. Model
%----------------------------------------------------------------

model; 
  exp(y) = exp(z)*exp(N*(1-alfa))*exp(k(-1)*alfa);
  theta*exp(c) = (1-alfa)*(1-N)*exp(y)/exp(N);
  exp(-c*eta)*(1-exp(N))^(theta*(1-eta)) = bet*a^(-eta)*exp(-c(+1)*eta)*(1-exp(N(+1)))^(theta*(1-eta))*(exp(R(+1)));
  exp(R) = alfa*exp(y)/exp(k(-1))+1-delta;
  a*exp(k) = exp(y) + (1-delta)*exp(k(-1))-exp(c);
  z = rho*z(-1)+sigma*e(-3);
end;

%----------------------------------------------------------------
% 4. Steady-State
%----------------------------------------------------------------
zss = 0;
ykss = (1/alfa)*(1/(bet*a^(-eta))-1+delta);
ckss = ykss + (1-delta) -a;
ycss = ykss/ckss;
Nss = (1-alfa)*ycss/(theta + (1-alfa)*ycss);
kss = (bet*alfa*exp(zss)*Nss^(1-alfa)/(1-bet*(1-delta)))^(1/(1-alfa));
css = ckss*kss;
Rss = 1/(bet*a^(-eta));
yss = ykss*kss;

%----------------------------------------------------------------
% 5. Computation
%----------------------------------------------------------------


initval;
  y = log(yss);
  k = log(kss);
  R = log(Rss);
  c = log(css);
  N = log(Nss);
  z = 0; 
  e = 0;
end;

shocks;
  var e = 1;
end;

steady;

stoch_simul(order = 1,periods=500,irf=20);
