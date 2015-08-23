function [zsim,state]=simumarkov(P,Z,T,s0);
%
% [chain,state]=markov(PI,s,n,s0); 
%
% simulate a Markov chain
%
% P	: Transition matrix
% Z	: State vector
% T	: length of simulation
% s0	: initial state (index) e.g., s0=1
%
% zsimu : values for the simulated markov chain
% state : index of the state
%

[rP,cP]=size(P);

% Step 1: Compute the cumulative distribution of the Markov chain
cum_PI=[zeros(rP,1) cumsum(P')'];

% Step 2: Set initial T random numers from a uniform dist
pt         = rand(T,1);

% start the vector that will store the state simulated
state		= zeros(T,1);
state(1) 	= s0;

% Step 3: Find the indes $j$ such that cumP_{i(j-1)} , pt < cumP_{ij}
for t=2:T;
  state(t)=find(((pt(t)<=cum_PI(state(t-1),2:cP+1))&(pt(t)>cum_PI(state(t-1),1:cP))));
end;

zsim =Z(state);
