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
M_.fname = 'newsrbc';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'newsrbc.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.exo_names = 'e';
M_.exo_names_tex = 'e';
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names = char(M_.endo_names, 'R');
M_.endo_names_tex = char(M_.endo_names_tex, 'R');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names = char(M_.endo_names, 'N');
M_.endo_names_tex = char(M_.endo_names_tex, 'N');
M_.endo_names = char(M_.endo_names, 'AUX_EXO_LAG_6_0');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_EXO\_LAG\_6\_0');
M_.endo_names = char(M_.endo_names, 'AUX_EXO_LAG_6_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_EXO\_LAG\_6\_1');
M_.endo_names = char(M_.endo_names, 'AUX_EXO_LAG_6_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_EXO\_LAG\_6\_2');
M_.param_names = 'alfa';
M_.param_names_tex = 'alfa';
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names = char(M_.param_names, 'eta');
M_.param_names_tex = char(M_.param_names_tex, 'eta');
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
M_.endo_nbr = 9;
M_.param_nbr = 8;
M_.orig_endo_nbr = 6;
M_.aux_vars(1).endo_index = 7;
M_.aux_vars(1).type = 3;
M_.aux_vars(1).orig_index = 1;
M_.aux_vars(1).orig_lead_lag = 0;
M_.aux_vars(2).endo_index = 8;
M_.aux_vars(2).type = 3;
M_.aux_vars(2).orig_index = 1;
M_.aux_vars(2).orig_lead_lag = -1;
M_.aux_vars(3).endo_index = 9;
M_.aux_vars(3).type = 3;
M_.aux_vars(3).orig_index = 1;
M_.aux_vars(3).orig_lead_lag = -2;
M_.Sigma_e = zeros(1, 1);
M_.H = 0;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('newsrbc_dynamic');
M_.lead_lag_incidence = [
 0 6 0;
 0 7 15;
 1 8 0;
 0 9 16;
 2 10 0;
 0 11 17;
 3 12 0;
 4 13 0;
 5 14 0;]';
M_.equations_tags = {
};
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(9, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(8, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 28;
M_.NNZDerivatives(2) = -1;
M_.NNZDerivatives(3) = -1;
close all
M_.params( 1 ) = 0.363;
alfa = M_.params( 1 );
M_.params( 2 ) = 0.0195;
delta = M_.params( 2 );
M_.params( 3 ) = 0.994;
bet = M_.params( 3 );
M_.params( 4 ) = 2;
eta = M_.params( 4 );
M_.params( 5 ) = 3.0956;
theta = M_.params( 5 );
M_.params( 6 ) = 1.0034;
a = M_.params( 6 );
M_.params( 7 ) = 0.999;
rho = M_.params( 7 );
M_.params( 8 ) = 0.00677;
sigma = M_.params( 8 );
zss = 0;
ykss = (1/alfa)*(1/(bet*a^(-eta))-1+delta);
ckss = ykss + (1-delta) -a;
ycss = ykss/ckss;
Nss = (1-alfa)*ycss/(theta + (1-alfa)*ycss);
kss = (bet*alfa*exp(zss)*Nss^(1-alfa)/(1-bet*(1-delta)))^(1/(1-alfa));
css = ckss*kss;
Rss = 1/(bet*a^(-eta));
yss = ykss*kss;
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 1 ) = log(yss);
oo_.steady_state( 3 ) = log(kss);
oo_.steady_state( 4 ) = log(Rss);
oo_.steady_state( 2 ) = log(css);
oo_.steady_state( 6 ) = log(Nss);
oo_.steady_state( 5 ) = 0;
oo_.exo_steady_state( 1 ) = 0;
oo_.steady_state(7)=oo_.exo_steady_state(1);
oo_.steady_state(8)=oo_.steady_state(7);
oo_.steady_state(9)=oo_.steady_state(8);
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
options_.irf = 20;
options_.order = 1;
options_.periods = 500;
var_list_=[];
info = stoch_simul(var_list_);
save('newsrbc_results.mat', 'oo_', 'M_', 'options_');
diary off

disp(['Total computing time : ' dynsec2hms(toc) ]);
