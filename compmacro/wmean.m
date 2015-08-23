function [y] = wmean(x,w)

y=dot(x,w)/sum(w);