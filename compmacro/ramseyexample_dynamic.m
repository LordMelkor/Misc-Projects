function [residual, g1, g2, g3] = ramseyexample_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(5, 1);
T32 = params(3)*y(8)^(-params(4));
T38 = params(1)*exp(y(9))*y(6)^(params(1)-1);
T40 = 1+T38-params(2);
T53 = params(3)*getPowerDeriv(y(8),(-params(4)),1);
lhs =y(3);
rhs =exp(y(7))*y(1)^params(1);
residual(1)= lhs-rhs;
lhs =y(6);
rhs =y(4)+y(1)*(1-params(2));
residual(2)= lhs-rhs;
lhs =y(3);
rhs =y(4)+y(5);
residual(3)= lhs-rhs;
lhs =y(5)^(-params(4));
rhs =T32*T40;
residual(4)= lhs-rhs;
lhs =y(7);
rhs =params(7)*y(2)+params(8)*x(it_, 1);
residual(5)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(5, 10);

%
% Jacobian matrix
%

g1(1,3)=1;
g1(1,1)=(-(exp(y(7))*getPowerDeriv(y(1),params(1),1)));
g1(1,7)=(-(exp(y(7))*y(1)^params(1)));
g1(2,4)=(-1);
g1(2,1)=(-(1-params(2)));
g1(2,6)=1;
g1(3,3)=1;
g1(3,4)=(-1);
g1(3,5)=(-1);
g1(4,5)=getPowerDeriv(y(5),(-params(4)),1);
g1(4,8)=(-(T40*T53));
g1(4,6)=(-(T32*params(1)*exp(y(9))*getPowerDeriv(y(6),params(1)-1,1)));
g1(4,9)=(-(T32*T38));
g1(5,2)=(-params(7));
g1(5,7)=1;
g1(5,10)=(-params(8));
end
if nargout >= 3,
%
% Hessian matrix
%

  v2 = zeros(14,3);
v2(1,1)=1;
v2(1,2)=1;
v2(1,3)=(-(exp(y(7))*getPowerDeriv(y(1),params(1),2)));
v2(2,1)=1;
v2(2,2)=61;
v2(2,3)=(-(exp(y(7))*getPowerDeriv(y(1),params(1),1)));
v2(3,1)=1;
v2(3,2)=7;
v2(3,3)=v2(2,3);
v2(4,1)=1;
v2(4,2)=67;
v2(4,3)=(-(exp(y(7))*y(1)^params(1)));
v2(5,1)=4;
v2(5,2)=45;
v2(5,3)=getPowerDeriv(y(5),(-params(4)),2);
v2(6,1)=4;
v2(6,2)=78;
v2(6,3)=(-(T40*params(3)*getPowerDeriv(y(8),(-params(4)),2)));
v2(7,1)=4;
v2(7,2)=58;
v2(7,3)=(-(T53*params(1)*exp(y(9))*getPowerDeriv(y(6),params(1)-1,1)));
v2(8,1)=4;
v2(8,2)=76;
v2(8,3)=v2(7,3);
v2(9,1)=4;
v2(9,2)=56;
v2(9,3)=(-(T32*params(1)*exp(y(9))*getPowerDeriv(y(6),params(1)-1,2)));
v2(10,1)=4;
v2(10,2)=88;
v2(10,3)=(-(T38*T53));
v2(11,1)=4;
v2(11,2)=79;
v2(11,3)=v2(10,3);
v2(12,1)=4;
v2(12,2)=86;
v2(12,3)=(-(T32*params(1)*exp(y(9))*getPowerDeriv(y(6),params(1)-1,1)));
v2(13,1)=4;
v2(13,2)=59;
v2(13,3)=v2(12,3);
v2(14,1)=4;
v2(14,2)=89;
v2(14,3)=(-(T32*T38));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),5,100);
end
if nargout >= 4,
%
% Third order derivatives
%

  g3 = sparse([],[],[],5,1000);
end
end
