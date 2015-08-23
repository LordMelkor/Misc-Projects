function [residual, g1, g2] = newsrbc_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 9, 1);

%
% Model equations
%

T40 = (1-exp(y(6)))^(params(5)*(1-params(4)));
T51 = T40*exp((-y(2))*params(4))*params(3)*params(6)^(-params(4))*exp(y(4));
T115 = (-exp(y(6)))*getPowerDeriv(1-exp(y(6)),params(5)*(1-params(4)),1);
lhs =exp(y(1));
rhs =exp(y(5))*exp(y(6)*(1-params(1)))*exp(params(1)*y(3));
residual(1)= lhs-rhs;
lhs =params(5)*exp(y(2));
rhs =exp(y(1))*(1-params(1))*(1-y(6))/exp(y(6));
residual(2)= lhs-rhs;
lhs =exp((-y(2))*params(4))*T40;
rhs =T51;
residual(3)= lhs-rhs;
lhs =exp(y(4));
rhs =1+exp(y(1))*params(1)/exp(y(3))-params(2);
residual(4)= lhs-rhs;
lhs =params(6)*exp(y(3));
rhs =exp(y(1))+exp(y(3))*(1-params(2))-exp(y(2));
residual(5)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(7)+params(8)*y(9);
residual(6)= lhs-rhs;
lhs =y(7);
rhs =x(1);
residual(7)= lhs-rhs;
lhs =y(8);
rhs =y(7);
residual(8)= lhs-rhs;
lhs =y(9);
rhs =y(8);
residual(9)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(9, 9);

%
% Jacobian matrix
%

  g1(1,1)=exp(y(1));
  g1(1,3)=(-(exp(y(5))*exp(y(6)*(1-params(1)))*params(1)*exp(params(1)*y(3))));
  g1(1,5)=(-(exp(y(5))*exp(y(6)*(1-params(1)))*exp(params(1)*y(3))));
  g1(1,6)=(-(exp(params(1)*y(3))*exp(y(5))*(1-params(1))*exp(y(6)*(1-params(1)))));
  g1(2,1)=(-(exp(y(1))*(1-params(1))*(1-y(6))/exp(y(6))));
  g1(2,2)=params(5)*exp(y(2));
  g1(2,6)=(-((exp(y(6))*exp(y(1))*(-(1-params(1)))-exp(y(1))*(1-params(1))*(1-y(6))*exp(y(6)))/(exp(y(6))*exp(y(6)))));
  g1(3,2)=T40*exp((-y(2))*params(4))*(-params(4))-exp(y(4))*T40*params(3)*params(6)^(-params(4))*exp((-y(2))*params(4))*(-params(4));
  g1(3,4)=(-T51);
  g1(3,6)=exp((-y(2))*params(4))*T115-exp(y(4))*exp((-y(2))*params(4))*params(3)*params(6)^(-params(4))*T115;
  g1(4,1)=(-(exp(y(1))*params(1)/exp(y(3))));
  g1(4,3)=(-((-(exp(y(1))*params(1)*exp(y(3))))/(exp(y(3))*exp(y(3)))));
  g1(4,4)=exp(y(4));
  g1(5,1)=(-exp(y(1)));
  g1(5,2)=exp(y(2));
  g1(5,3)=params(6)*exp(y(3))-exp(y(3))*(1-params(2));
  g1(6,5)=1-params(7);
  g1(6,9)=(-params(8));
  g1(7,7)=1;
  g1(8,7)=(-1);
  g1(8,8)=1;
  g1(9,8)=(-1);
  g1(9,9)=1;
  if ~isreal(g1)
    g1 = real(g1)+imag(g1).^2;
  end
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],9,81);
end
end
