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
eta     =  1; 
theta   =  3.0956;
a       = 1.0034;
rho     = 0.945;
sigma   = 0.00677;


%----------------------------------------------------------------
% 3. Model
%----------------------------------------------------------------

model; 
  y = exp(z)*N^(1-alfa)*k(-1)^alfa;
  theta*c = (1-alfa)*(1-N)*y/N;
  c^(-eta)*(1-N)^(theta*(1-eta)) = bet*a^(-eta)*c(+1)^(-eta)*(1-N(+1))^(theta*(1-eta))*(R(+1));
  R = alfa*y/k(-1)+1-delta;
  a*k = y + (1-delta)*k(-1)-c;
  z = rho*z(-1)+sigma*e;
end;

%----------------------------------------------------------------
% 4. Steady-State
%----------------------------------------------------------------
zss = 0;
ykss = (1/alfa)*(1/bet-1+delta);
ckss = ykss + (1-delta) -a;
ycss = ykss/ckss;
Nss = (1-alfa)*ycss/(theta + (1-alfa)*ycss);
kss = (bet*alfa*exp(zss)*Nss^(1-alfa)/(1-bet*(1-delta)))^(1/(1-alfa));
css = ckss*kss;
Rss = 1/bet;
yss = ykss*kss;

%----------------------------------------------------------------
% 5. Computation
%----------------------------------------------------------------


initval;
  y = yss;
  k = kss;
  R = Rss;
  c = css;
  N = Nss;
  z = 0; 
  e = 0;
end;

shocks;
  var e = 1;
end;

steady;

stoch_simul(order = 1,periods=500,irf=40);
