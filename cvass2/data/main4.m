%%
% [x,y,1] = K * [xr, yr, 1] where K is the intrinsic matrix, [x y 1] is the
% image plane coordinate and [xr yr 1] is the retinal (camera coordinate).
% Thus to compute K, we will need to setup a calibration experiment, where
% we will obtain multiple pairs of retinal and image plane coordinates.
% Using these pairs of coordinates and the above equation, a least squares
% estimate of K can be obtained using SVD or EVD.
