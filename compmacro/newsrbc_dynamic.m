function [residual, g1, g2, g3] = newsrbc_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(9, 1);
T59 = params(3)*params(6)^(-params(4))*exp(params(4)*(-y(15)))*(1-exp(y(17)))^(params(5)*(1-params(4)))*exp(y(16));
lhs =exp(y(6));
rhs =exp(y(10))*exp(y(11)*(1-params(1)))*exp(params(1)*y(1));
residual(1)= lhs-rhs;
lhs =params(5)*exp(y(7));
rhs =exp(y(6))*(1-params(1))*(1-y(11))/exp(y(11));
residual(2)= lhs-rhs;
lhs =exp((-y(7))*params(4))*(1-exp(y(11)))^(params(5)*(1-params(4)));
rhs =T59;
residual(3)= lhs-rhs;
lhs =exp(y(9));
rhs =1+exp(y(6))*params(1)/exp(y(1))-params(2);
residual(4)= lhs-rhs;
lhs =params(6)*exp(y(8));
rhs =exp(y(6))+exp(y(1))*(1-params(2))-exp(y(7));
residual(5)= lhs-rhs;
lhs =y(10);
rhs =params(7)*y(2)+params(8)*y(5);
residual(6)= lhs-rhs;
lhs =y(12);
rhs =x(it_, 1);
residual(7)= lhs-rhs;
lhs =y(13);
rhs =y(3);
residual(8)= lhs-rhs;
lhs =y(14);
rhs =y(4);
residual(9)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(9, 18);

%
% Jacobian matrix
%

g1(1,6)=exp(y(6));
g1(1,1)=(-(exp(y(10))*exp(y(11)*(1-params(1)))*params(1)*exp(params(1)*y(1))));
g1(1,10)=(-(exp(y(10))*exp(y(11)*(1-params(1)))*exp(params(1)*y(1))));
g1(1,11)=(-(exp(params(1)*y(1))*exp(y(10))*(1-params(1))*exp(y(11)*(1-params(1)))));
g1(2,6)=(-(exp(y(6))*(1-params(1))*(1-y(11))/exp(y(11))));
g1(2,7)=params(5)*exp(y(7));
g1(2,11)=(-((exp(y(11))*exp(y(6))*(-(1-params(1)))-exp(y(6))*(1-params(1))*(1-y(11))*exp(y(11)))/(exp(y(11))*exp(y(11)))));
g1(3,7)=(1-exp(y(11)))^(params(5)*(1-params(4)))*exp((-y(7))*params(4))*(-params(4));
g1(3,15)=(-(exp(y(16))*(1-exp(y(17)))^(params(5)*(1-params(4)))*params(3)*params(6)^(-params(4))*(-params(4))*exp(params(4)*(-y(15)))));
g1(3,16)=(-T59);
g1(3,11)=exp((-y(7))*params(4))*(-exp(y(11)))*getPowerDeriv(1-exp(y(11)),params(5)*(1-params(4)),1);
g1(3,17)=(-(exp(y(16))*params(3)*params(6)^(-params(4))*exp(params(4)*(-y(15)))*(-exp(y(17)))*getPowerDeriv(1-exp(y(17)),params(5)*(1-params(4)),1)));
g1(4,6)=(-(exp(y(6))*params(1)/exp(y(1))));
g1(4,1)=(-((-(exp(y(6))*params(1)*exp(y(1))))/(exp(y(1))*exp(y(1)))));
g1(4,9)=exp(y(9));
g1(5,6)=(-exp(y(6)));
g1(5,7)=exp(y(7));
g1(5,1)=(-(exp(y(1))*(1-params(2))));
g1(5,8)=params(6)*exp(y(8));
g1(6,2)=(-params(7));
g1(6,10)=1;
g1(6,5)=(-params(8));
g1(7,18)=(-1);
g1(7,12)=1;
g1(8,3)=(-1);
g1(8,13)=1;
g1(9,4)=(-1);
g1(9,14)=1;
end
if nargout >= 3,
%
% Hessian matrix
%

  g2 = sparse([],[],[],9,324);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],9,5832);
end
end
