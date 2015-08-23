function [residual, g1, g2] = ramseyexample_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 5, 1);

%
% Model equations
%

T29 = y(3)^(-params(4))*params(3);
lhs =y(1);
rhs =exp(y(5))*y(4)^params(1);
residual(1)= lhs-rhs;
lhs =y(4);
rhs =y(2)+y(4)*(1-params(2));
residual(2)= lhs-rhs;
lhs =y(1);
rhs =y(2)+y(3);
residual(3)= lhs-rhs;
lhs =y(3)^(-params(4));
rhs =T29*(1+exp(y(5))*params(1)*y(4)^(params(1)-1)-params(2));
residual(4)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(7)+params(8)*x(1);
residual(5)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(5, 5);

%
% Jacobian matrix
%

  g1(1,1)=1;
  g1(1,4)=(-(exp(y(5))*getPowerDeriv(y(4),params(1),1)));
  g1(1,5)=(-(exp(y(5))*y(4)^params(1)));
  g1(2,2)=(-1);
  g1(2,4)=1-(1-params(2));
  g1(3,1)=1;
  g1(3,2)=(-1);
  g1(3,3)=(-1);
  g1(4,3)=getPowerDeriv(y(3),(-params(4)),1)-(1+exp(y(5))*params(1)*y(4)^(params(1)-1)-params(2))*params(3)*getPowerDeriv(y(3),(-params(4)),1);
  g1(4,4)=(-(T29*exp(y(5))*params(1)*getPowerDeriv(y(4),params(1)-1,1)));
  g1(4,5)=(-(T29*exp(y(5))*params(1)*y(4)^(params(1)-1)));
  g1(5,5)=1-params(7);
  if ~isreal(g1)
    g1 = real(g1)+imag(g1).^2;
  end
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],5,25);
end
end
