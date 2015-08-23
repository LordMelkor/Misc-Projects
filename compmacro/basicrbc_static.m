function [residual, g1, g2] = basicrbc_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 6, 1);

%
% Model equations
%

T18 = exp(y(5))*y(6)^(1-params(1))*y(3)^params(1);
T30 = y(2)^(-params(4));
T33 = (1-y(6))^(params(5)*(1-params(4)));
T40 = T33*T30*params(3)*params(6)^(-params(4));
lhs =y(1);
rhs =T18;
residual(1)= lhs-rhs;
lhs =params(5)*y(2);
rhs =y(1)*(1-params(1))*(1-y(6))/y(6);
residual(2)= lhs-rhs;
lhs =T30*T33;
rhs =T40*y(4);
residual(3)= lhs-rhs;
lhs =y(4);
rhs =1+y(1)*params(1)/y(3)-params(2);
residual(4)= lhs-rhs;
lhs =y(3)*params(6);
rhs =y(1)+y(3)*(1-params(2))-y(2);
residual(5)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(7)+params(8)*x(1);
residual(6)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(6, 6);

%
% Jacobian matrix
%

  g1(1,1)=1;
  g1(1,3)=(-(exp(y(5))*y(6)^(1-params(1))*getPowerDeriv(y(3),params(1),1)));
  g1(1,5)=(-T18);
  g1(1,6)=(-(y(3)^params(1)*exp(y(5))*getPowerDeriv(y(6),1-params(1),1)));
  g1(2,1)=(-((1-params(1))*(1-y(6))/y(6)));
  g1(2,2)=params(5);
  g1(2,6)=(-((y(6)*y(1)*(-(1-params(1)))-y(1)*(1-params(1))*(1-y(6)))/(y(6)*y(6))));
  g1(3,2)=T33*getPowerDeriv(y(2),(-params(4)),1)-y(4)*T33*params(3)*params(6)^(-params(4))*getPowerDeriv(y(2),(-params(4)),1);
  g1(3,4)=(-T40);
  g1(3,6)=T30*(-(getPowerDeriv(1-y(6),params(5)*(1-params(4)),1)))-y(4)*T30*params(3)*params(6)^(-params(4))*(-(getPowerDeriv(1-y(6),params(5)*(1-params(4)),1)));
  g1(4,1)=(-(params(1)/y(3)));
  g1(4,3)=(-((-(y(1)*params(1)))/(y(3)*y(3))));
  g1(4,4)=1;
  g1(5,1)=(-1);
  g1(5,2)=1;
  g1(5,3)=params(6)-(1-params(2));
  g1(6,5)=1-params(7);
  if ~isreal(g1)
    g1 = real(g1)+imag(g1).^2;
  end
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],6,36);
end
end
