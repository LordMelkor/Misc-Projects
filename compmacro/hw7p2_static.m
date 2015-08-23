function [residual, g1, g2] = hw7p2_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 4, 1);

%
% Model equations
%

T14 = exp(y(4))*y(3)^params(1);
T28 = y(2)^(-params(4))*params(3);
lhs =y(1);
rhs =T14;
residual(1)= lhs-rhs;
lhs =y(2);
rhs =T14+(-y(3))+y(3)*(1-params(2));
residual(2)= lhs-rhs;
lhs =y(2)^(-params(4));
rhs =T28*(1-params(2)+exp(y(4))*params(1)*y(3)^(params(1)-1));
residual(3)= lhs-rhs;
lhs =y(4);
rhs =y(4)*params(5)+params(6)*x(1);
residual(4)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(4, 4);

%
% Jacobian matrix
%

  g1(1,1)=1;
  g1(1,3)=(-(exp(y(4))*getPowerDeriv(y(3),params(1),1)));
  g1(1,4)=(-T14);
  g1(2,2)=1;
  g1(2,3)=(-(exp(y(4))*getPowerDeriv(y(3),params(1),1)+(-1)+1-params(2)));
  g1(2,4)=(-T14);
  g1(3,2)=getPowerDeriv(y(2),(-params(4)),1)-(1-params(2)+exp(y(4))*params(1)*y(3)^(params(1)-1))*params(3)*getPowerDeriv(y(2),(-params(4)),1);
  g1(3,3)=(-(T28*exp(y(4))*params(1)*getPowerDeriv(y(3),params(1)-1,1)));
  g1(3,4)=(-(T28*exp(y(4))*params(1)*y(3)^(params(1)-1)));
  g1(4,4)=1-params(5);
  if ~isreal(g1)
    g1 = real(g1)+imag(g1).^2;
  end
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],4,16);
end
end
