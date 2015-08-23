function [residual, g1, g2, g3] = basicrbc_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(6, 1);
T18 = exp(y(7))*y(8)^(1-params(1))*y(1)^params(1);
T41 = params(3)*params(6)^(-params(4))*y(9)^(-params(4));
T45 = T41*(1-y(11))^(params(5)*(1-params(4)));
lhs =y(3);
rhs =T18;
residual(1)= lhs-rhs;
lhs =params(5)*y(4);
rhs =y(3)*(1-params(1))*(1-y(8))/y(8);
residual(2)= lhs-rhs;
lhs =y(4)^(-params(4))*(1-y(8))^(params(5)*(1-params(4)));
rhs =T45*y(10);
residual(3)= lhs-rhs;
lhs =y(6);
rhs =1+y(3)*params(1)/y(1)-params(2);
residual(4)= lhs-rhs;
lhs =params(6)*y(5);
rhs =y(3)+y(1)*(1-params(2))-y(4);
residual(5)= lhs-rhs;
lhs =y(7);
rhs =params(7)*y(2)+params(8)*x(it_, 1);
residual(6)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(6, 12);

%
% Jacobian matrix
%

g1(1,3)=1;
g1(1,1)=(-(exp(y(7))*y(8)^(1-params(1))*getPowerDeriv(y(1),params(1),1)));
g1(1,7)=(-T18);
g1(1,8)=(-(y(1)^params(1)*exp(y(7))*getPowerDeriv(y(8),1-params(1),1)));
g1(2,3)=(-((1-params(1))*(1-y(8))/y(8)));
g1(2,4)=params(5);
g1(2,8)=(-((y(8)*y(3)*(-(1-params(1)))-y(3)*(1-params(1))*(1-y(8)))/(y(8)*y(8))));
g1(3,4)=(1-y(8))^(params(5)*(1-params(4)))*getPowerDeriv(y(4),(-params(4)),1);
g1(3,9)=(-(y(10)*(1-y(11))^(params(5)*(1-params(4)))*params(3)*params(6)^(-params(4))*getPowerDeriv(y(9),(-params(4)),1)));
g1(3,10)=(-T45);
g1(3,8)=y(4)^(-params(4))*(-(getPowerDeriv(1-y(8),params(5)*(1-params(4)),1)));
g1(3,11)=(-(y(10)*T41*(-(getPowerDeriv(1-y(11),params(5)*(1-params(4)),1)))));
g1(4,3)=(-(params(1)/y(1)));
g1(4,1)=(-((-(y(3)*params(1)))/(y(1)*y(1))));
g1(4,6)=1;
g1(5,3)=(-1);
g1(5,4)=1;
g1(5,1)=(-(1-params(2)));
g1(5,5)=params(6);
g1(6,2)=(-params(7));
g1(6,7)=1;
g1(6,12)=(-params(8));
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],6,144);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],6,1728);
end
end
