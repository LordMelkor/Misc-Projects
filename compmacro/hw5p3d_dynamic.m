function [residual, g1, g2, g3] = hw5p3d_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(8, 1);
T18 = exp(y(8))*y(10)^params(1)*y(1)^(1-params(1));
T40 = (1-y(10))^(params(5)*(1-params(4)));
T51 = (1-y(15))^(params(5)*(1-params(4)));
T52 = params(3)*(y(13)+params(10)*y(14))^(-params(4))*T51;
T60 = 1-params(2)+(1-params(1))*(1-y(11))*y(12)/y(6);
lhs =y(4);
rhs =T18;
residual(1)= lhs-rhs;
lhs =params(5)*(y(5)+params(10)*y(7));
rhs =params(1)*(1-y(11))*(1-y(10))*y(4)/y(10);
residual(2)= lhs-rhs;
lhs =(y(5)+params(10)*y(7))^(-params(4))*T40;
rhs =T52*T60;
residual(3)= lhs-rhs;
lhs =y(6);
rhs =y(4)*(1-y(11))+y(1)*(1-params(2))-y(5)+params(11);
residual(4)= lhs-rhs;
lhs =y(4)*y(11);
rhs =y(7)+params(11);
residual(5)= lhs-rhs;
lhs =y(7);
rhs =exp(y(9))*params(12);
residual(6)= lhs-rhs;
lhs =y(8);
rhs =params(6)*y(2)+params(8)*x(it_, 1);
residual(7)= lhs-rhs;
lhs =y(9);
rhs =params(7)*y(3)+params(9)*x(it_, 2);
residual(8)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(8, 17);

%
% Jacobian matrix
%

g1(1,4)=1;
g1(1,1)=(-(exp(y(8))*y(10)^params(1)*getPowerDeriv(y(1),1-params(1),1)));
g1(1,8)=(-T18);
g1(1,10)=(-(y(1)^(1-params(1))*exp(y(8))*getPowerDeriv(y(10),params(1),1)));
g1(2,4)=(-(params(1)*(1-y(11))*(1-y(10))*1/y(10)));
g1(2,5)=params(5);
g1(2,7)=params(5)*params(10);
g1(2,10)=(-(y(4)/y(10)*(-(params(1)*(1-y(11))))+params(1)*(1-y(11))*(1-y(10))*(-y(4))/(y(10)*y(10))));
g1(2,11)=(-(y(4)/y(10)*(1-y(10))*(-params(1))));
g1(3,12)=(-(T52*(1-params(1))*(1-y(11))/y(6)));
g1(3,5)=T40*getPowerDeriv(y(5)+params(10)*y(7),(-params(4)),1);
g1(3,13)=(-(T60*T51*params(3)*getPowerDeriv(y(13)+params(10)*y(14),(-params(4)),1)));
g1(3,6)=(-(T52*(-((1-params(1))*(1-y(11))*y(12)))/(y(6)*y(6))));
g1(3,7)=T40*params(10)*getPowerDeriv(y(5)+params(10)*y(7),(-params(4)),1);
g1(3,14)=(-(T60*T51*params(3)*params(10)*getPowerDeriv(y(13)+params(10)*y(14),(-params(4)),1)));
g1(3,10)=(y(5)+params(10)*y(7))^(-params(4))*(-(getPowerDeriv(1-y(10),params(5)*(1-params(4)),1)));
g1(3,15)=(-(T60*params(3)*(y(13)+params(10)*y(14))^(-params(4))*(-(getPowerDeriv(1-y(15),params(5)*(1-params(4)),1)))));
g1(3,11)=(-(T52*y(12)*(-(1-params(1)))/y(6)));
g1(4,4)=(-(1-y(11)));
g1(4,5)=1;
g1(4,1)=(-(1-params(2)));
g1(4,6)=1;
g1(4,11)=y(4);
g1(5,4)=y(11);
g1(5,7)=(-1);
g1(5,11)=y(4);
g1(6,7)=1;
g1(6,9)=(-(exp(y(9))*params(12)));
g1(7,2)=(-params(6));
g1(7,8)=1;
g1(7,16)=(-params(8));
g1(8,3)=(-params(7));
g1(8,9)=1;
g1(8,17)=(-params(9));
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],8,289);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],8,4913);
end
end
