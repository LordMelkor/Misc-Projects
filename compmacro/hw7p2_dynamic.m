function [residual, g1, g2, g3] = hw7p2_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(4, 1);
T14 = exp(y(6))*y(1)^params(1);
T31 = params(3)*y(7)^(-params(4));
lhs =y(3);
rhs =T14;
residual(1)= lhs-rhs;
lhs =y(4);
rhs =T14+(-y(5))+y(1)*(1-params(2));
residual(2)= lhs-rhs;
lhs =y(4)^(-params(4));
rhs =T31*(1-params(2)+params(1)*exp(y(8))*y(5)^(params(1)-1));
residual(3)= lhs-rhs;
lhs =y(6);
rhs =params(5)*y(2)+params(6)*x(it_, 1);
residual(4)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(4, 9);

%
% Jacobian matrix
%

g1(1,3)=1;
g1(1,1)=(-(exp(y(6))*getPowerDeriv(y(1),params(1),1)));
g1(1,6)=(-T14);
g1(2,4)=1;
g1(2,1)=(-(1-params(2)+exp(y(6))*getPowerDeriv(y(1),params(1),1)));
g1(2,5)=1;
g1(2,6)=(-T14);
g1(3,4)=getPowerDeriv(y(4),(-params(4)),1);
g1(3,7)=(-((1-params(2)+params(1)*exp(y(8))*y(5)^(params(1)-1))*params(3)*getPowerDeriv(y(7),(-params(4)),1)));
g1(3,5)=(-(T31*params(1)*exp(y(8))*getPowerDeriv(y(5),params(1)-1,1)));
g1(3,8)=(-(T31*params(1)*exp(y(8))*y(5)^(params(1)-1)));
g1(4,2)=(-params(5));
g1(4,6)=1;
g1(4,9)=(-params(6));
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],4,81);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],4,729);
end
end
