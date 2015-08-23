%
% Basic stochastic Ramsey  Model
%

%----------------------------------------------------------------
% 0. Housekeeping
%----------------------------------------------------------------

close all

%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------

var y i c k z;
varexo e;

parameters alfa delta bet gama theta a rho sigma; 

%----------------------------------------------------------------
% 2. Calibration
%----------------------------------------------------------------

alfa=0.27;
bet=0.97;
delta=1;
gama=5;
rho = 0.94;
sigma = 0.0067;


%----------------------------------------------------------------
% 3. Model
%----------------------------------------------------------------

model; 
     y = exp(z)*k(-1)^alfa;
     k = i + (1-delta)*k(-1);
     y = c + i;
     c^(-gama) = bet*c(+1)^(-gama)*(exp(z(+1))*alfa*k^(alfa-1) + 1 -delta);
     z=rho*z(-1)+sigma*e;
end;

%----------------------------------------------------------------
% 4. Steady-State
%----------------------------------------------------------------

zss = 0;
Kss = (exp(zss)*alfa*bet/(1-bet*(1-delta)))^(1/(1-alfa));    % Capital stock at the steady state
Css = exp(zss)*Kss^alfa - delta*Kss;                         % Consumption at the steady state
Yss = exp(zss)*Kss^alfa;
Iss = delta*Kss;

%----------------------------------------------------------------
% 5. Computation
%----------------------------------------------------------------


initval;
  k = Kss;
  c = Css;
  y = Yss;
  i = Iss;
  z = 0; 
  e = 0;
end;

shocks;
  var e = 1;
end;

steady;

stoch_simul(order = 2) z c i y;
