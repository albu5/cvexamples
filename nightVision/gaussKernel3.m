function [R,S,Dvec] = gaussKernel3(J,d,smin,smax)
[V,D] = eig(J);
Dvec = diag(D);
R = V;
S = diag(scalefun(Dvec, d, min(Dvec), smin, smax));
end