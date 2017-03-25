function H = computeHessian(I)
[ix,iy] = gradient(I);
[H.ixx, H.ixy] = gradient(ix);
[H.iyx, H.iyy] = gradient(iy);
end