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
M_.fname = 'hw5p3d';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'hw5p3d.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.exo_names = 'ez';
M_.exo_names_tex = 'ez';
M_.exo_names = char(M_.exo_names, 'eg');
M_.exo_names_tex = char(M_.exo_names_tex, 'eg');
M_.endo_names = 'Y';
M_.endo_names_tex = 'Y';
M_.endo_names = char(M_.endo_names, 'C');
M_.endo_names_tex = char(M_.endo_names_tex, 'C');
M_.endo_names = char(M_.endo_names, 'K');
M_.endo_names_tex = char(M_.endo_names_tex, 'K');
M_.endo_names = char(M_.endo_names, 'G');
M_.endo_names_tex = char(M_.endo_names_tex, 'G');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names = char(M_.endo_names, 'g');
M_.endo_names_tex = char(M_.endo_names_tex, 'g');
M_.endo_names = char(M_.endo_names, 'N');
M_.endo_names_tex = char(M_.endo_names_tex, 'N');
M_.endo_names = char(M_.endo_names, 'tau');
M_.endo_names_tex = char(M_.endo_names_tex, 'tau');
M_.param_names = 'alfa';
M_.param_names_tex = 'alfa';
M_.param_names = char(M_.param_names, 'del');
M_.param_names_tex = char(M_.param_names_tex, 'del');
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names = char(M_.param_names, 'gam');
M_.param_names_tex = char(M_.param_names_tex, 'gam');
M_.param_names = char(M_.param_names, 'th');
M_.param_names_tex = char(M_.param_names_tex, 'th');
M_.param_names = char(M_.param_names, 'rhoz');
M_.param_names_tex = char(M_.param_names_tex, 'rhoz');
M_.param_names = char(M_.param_names, 'rhog');
M_.param_names_tex = char(M_.param_names_tex, 'rhog');
M_.param_names = char(M_.param_names, 'sigz');
M_.param_names_tex = char(M_.param_names_tex, 'sigz');
M_.param_names = char(M_.param_names, 'sigg');
M_.param_names_tex = char(M_.param_names_tex, 'sigg');
M_.param_names = char(M_.param_names, 'psi');
M_.param_names_tex = char(M_.param_names_tex, 'psi');
M_.param_names = char(M_.param_names, 'TR');
M_.param_names_tex = char(M_.param_names_tex, 'TR');
M_.param_names = char(M_.param_names, 'gparam');
M_.param_names_tex = char(M_.param_names_tex, 'gparam');
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 8;
M_.param_nbr = 12;
M_.orig_endo_nbr = 8;
M_.aux_vars = [];
M_.Sigma_e = zeros(2, 2);
M_.H = 0;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('hw5p3d_dynamic');
M_.lead_lag_incidence = [
 0 4 12;
 0 5 13;
 1 6 0;
 0 7 14;
 2 8 0;
 3 9 0;
 0 10 15;
 0 11 0;]';
M_.equations_tags = {
};
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(8, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(12, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 34;
M_.NNZDerivatives(2) = -1;
M_.NNZDerivatives(3) = -1;
close all
M_.params( 3 ) = 0.99;
bet = M_.params( 3 );
M_.params( 1 ) = 0.6;
alfa = M_.params( 1 );
M_.params( 6 ) = 0.9;
rhoz = M_.params( 6 );
M_.params( 7 ) = 0.95;
rhog = M_.params( 7 );
M_.params( 4 ) = 2;
gam = M_.params( 4 );
M_.params( 2 ) = 0.02;
del = M_.params( 2 );
M_.params( 8 ) = 0.007;
sigz = M_.params( 8 );
M_.params( 9 ) = 0.01;
sigg = M_.params( 9 );
M_.params( 10 ) = 0.5;
psi = M_.params( 10 );
M_.params( 11 ) = 0;
TR = M_.params( 11 );
M_.params( 5 ) = 1.6294;
th = M_.params( 5 );
M_.params( 12 ) = 0.290085;
gparam = M_.params( 12 );
zss = 0;
tss = 0.2;
ykss = (1/((1-tss)*(1-alfa)))*(1/bet-1+del);
ckss = ykss*(1.2-2*tss) + (1-del) -1;
ycss = ykss/ckss;
Nss = (((ycss^-1)*th+th*psi*0.2)/(alfa*(1-tss))+1)^-1;
kss = (((1/bet)+del-1)/((1-tss)*(1-alfa)*Nss^alfa))^(-1/alfa);
css = ckss*kss;
yss = ykss*kss;
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 1 ) = yss;
oo_.steady_state( 3 ) = kss;
oo_.steady_state( 2 ) = css;
oo_.steady_state( 7 ) = Nss;
oo_.steady_state( 8 ) = tss;
oo_.steady_state( 4 ) = M_.params(12);
oo_.steady_state( 5 ) = 0;
oo_.steady_state( 6 ) = 0;
oo_.exo_steady_state( 1 ) = 0;
oo_.exo_steady_state( 2 ) = 0;
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
M_.Sigma_e(2, 2) = 1;
M_.sigma_e_is_diagonal = 1;
steady;
options_.irf = 40;
options_.order = 1;
options_.periods = 500;
var_list_=[];
info = stoch_simul(var_list_);
save('hw5p3d_results.mat', 'oo_', 'M_', 'options_');
diary off

disp(['Total computing time : ' dynsec2hms(toc) ]);
