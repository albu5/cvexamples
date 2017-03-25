function [locs, desc] = briefLite(im)
% INPUTS
% im - gray image with values between 0 and 1
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
% 		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. 
%		 m is the number of valid descriptors in the image and will vary
% 		 n is the number of bits for the BRIEF descriptor
levels = [-1, 0, 1, 2, 3, 4];
K = sqrt(2);
sigma0 = 1;
thetac = 0.03;
thetar = 12;
load testPattern.mat

[locs, pyr] = DoGdetector(im,sigma0, K, levels, thetac, thetar);
[locs,desc] = computeBrief(im, pyr, locs, K,...
    levels,compareX, compareY);