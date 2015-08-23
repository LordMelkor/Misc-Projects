%
% Status : main Dynare file 
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

clear all
clear global
tic;
global M_ oo_ options_ ys0_ ex0_
options_ = [];
M_.fname = 'ramseyexample';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'ramseyexample.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.exo_names = 'e';
M_.exo_names_tex = 'e';
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.param_names = 'alfa';
M_.param_names_tex = 'alfa';
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names = char(M_.param_names, 'gama');
M_.param_names_tex = char(M_.param_names_tex, 'gama');
M_.param_names = char(M_.param_names, 'theta');
M_.param_names_tex = char(M_.param_names_tex, 'theta');
M_.param_names = char(M_.param_names, 'a');
M_.param_names_tex = char(M_.param_names_tex, 'a');
M_.param_names = char(M_.param_names, 'rho');
M_.param_names_tex = char(M_.param_names_tex, 'rho');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 5;
M_.param_nbr = 8;
M_.orig_endo_nbr = 5;
M_.aux_vars = [];
M_.Sigma_e = zeros(1, 1);
M_.H = 0;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('ramseyexample_dynamic');
M_.lead_lag_incidence = [
 0 3 0;
 0 4 0;
 0 5 8;
 1 6 0;
 2 7 9;]';
M_.equations_tags = {
};
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(5, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(8, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 16;
M_.NNZDerivatives(2) = 14;
M_.NNZDerivatives(3) = -1;
close all
M_.params( 1 ) = 0.27;
alfa = M_.params( 1 );
M_.params( 3 ) = 0.97;
bet = M_.params( 3 );
M_.params( 2 ) = 1;
delta = M_.params( 2 );
M_.params( 4 ) = 5;
gama = M_.params( 4 );
M_.params( 7 ) = 0.94;
rho = M_.params( 7 );
M_.params( 8 ) = 0.0067;
sigma = M_.params( 8 );
zss = 0;
Kss = (exp(zss)*alfa*bet/(1-bet*(1-delta)))^(1/(1-alfa));    
Css = exp(zss)*Kss^alfa - delta*Kss;                         
Yss = exp(zss)*Kss^alfa;
Iss = delta*Kss;
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 4 ) = Kss;
oo_.steady_state( 3 ) = Css;
oo_.steady_state( 1 ) = Yss;
oo_.steady_state( 2 ) = Iss;
oo_.steady_state( 5 ) = 0;
oo_.exo_steady_state( 1 ) = 0;
oo_.endo_simul=[oo_.steady_state*ones(1,M_.maximum_lag)];
if M_.exo_nbr > 0;
	oo_.exo_simul = [ones(M_.maximum_lag,1)*oo_.exo_steady_state'];
end;
if M_.exo_det_nbr > 0;
	oo_.exo_det_simul = [ones(M_.maximum_lag,1)*oo_.exo_det_steady_state'];
end;
%
% SHOCKS instructions
%
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = 1;
M_.sigma_e_is_diagonal = 1;
steady;
options_.order = 2;
var_list_=[];
var_list_ = 'z';
var_list_ = char(var_list_, 'c');
var_list_ = char(var_list_, 'i');
var_list_ = char(var_list_, 'y');
info = stoch_simul(var_list_);
save('ramseyexample_results.mat', 'oo_', 'M_', 'options_');
diary off

disp(['Total computing time : ' dynsec2hms(toc) ]);
