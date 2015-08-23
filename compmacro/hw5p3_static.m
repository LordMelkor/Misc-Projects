function [residual, g1, g2] = hw5p3_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 8, 1);

%
% Model equations
%

T18 = exp(y(5))*y(7)^params(1)*y(3)^(1-params(1));
T37 = (y(2)+params(11)*y(4))^(-params(4));
T40 = (1-y(7))^(params(5)*(1-params(4)));
T44 = T40*T37*params(3);
T50 = 1-params(2)+y(1)*(1-params(1))*(1-params(10))/y(3);
T89 = getPowerDeriv(y(2)+params(11)*y(4),(-params(4)),1);
lhs =y(1);
rhs =T18;
residual(1)= lhs-rhs;
lhs =params(5)*(y(2)+params(11)*y(4));
rhs =params(1)*(1-params(10))*(1-y(7))*y(1)/y(7);
residual(2)= lhs-rhs;
lhs =T37*T40;
rhs =T44*T50;
residual(3)= lhs-rhs;
lhs =y(3);
rhs =y(1)*(1-params(10))+y(3)*(1-params(2))-y(2)+y(8);
residual(4)= lhs-rhs;
lhs =y(1)*params(10);
rhs =y(4)+y(8);
residual(5)= lhs-rhs;
lhs =y(4);
rhs =exp(y(6))*params(12);
residual(6)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(6)+params(8)*x(1);
residual(7)= lhs-rhs;
lhs =y(6);
rhs =y(6)*params(7)+params(9)*x(2);
residual(8)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(8, 8);

%
% Jacobian matrix
%

  g1(1,1)=1;
  g1(1,3)=(-(exp(y(5))*y(7)^params(1)*getPowerDeriv(y(3),1-params(1),1)));
  g1(1,5)=(-T18);
  g1(1,7)=(-(y(3)^(1-params(1))*exp(y(5))*getPowerDeriv(y(7),params(1),1)));
  g1(2,1)=(-(params(1)*(1-params(10))*(1-y(7))*1/y(7)));
  g1(2,2)=params(5);
  g1(2,4)=params(5)*params(11);
  g1(2,7)=(-(y(1)/y(7)*(-(params(1)*(1-params(10))))+params(1)*(1-params(10))*(1-y(7))*(-y(1))/(y(7)*y(7))));
  g1(3,1)=(-(T44*(1-params(1))*(1-params(10))/y(3)));
  g1(3,2)=T40*T89-T50*T40*params(3)*T89;
  g1(3,3)=(-(T44*(-(y(1)*(1-params(1))*(1-params(10))))/(y(3)*y(3))));
  g1(3,4)=T40*params(11)*T89-T50*T40*params(3)*params(11)*T89;
  g1(3,7)=T37*(-(getPowerDeriv(1-y(7),params(5)*(1-params(4)),1)))-T50*T37*params(3)*(-(getPowerDeriv(1-y(7),params(5)*(1-params(4)),1)));
  g1(4,1)=(-(1-params(10)));
  g1(4,2)=1;
  g1(4,3)=1-(1-params(2));
  g1(4,8)=(-1);
  g1(5,1)=params(10);
  g1(5,4)=(-1);
  g1(5,8)=(-1);
  g1(6,4)=1;
  g1(6,6)=(-(exp(y(6))*params(12)));
  g1(7,5)=1-params(6);
  g1(8,6)=1-params(7);
  if ~isreal(g1)
    g1 = real(g1)+imag(g1).^2;
  end
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],8,64);
end
end
