function y = scalefun(x,d,lmin,smin,smax)
y = (smax-smin)*(exp((lmin-x)/d)) + smin;
y(x<=lmin) = smax;
y = 1./y;
y(end) = y(end);
end