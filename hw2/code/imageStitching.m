function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image
img1_g = im2double(rgb2gray(img1));
img2_g = im2double(rgb2gray(img2));
panoImg = warpH(img2, inv(H2to1), round(2*[size(img1,1),size(img1,2)]));
panoImg(1:size(img1,1),1:size(img1,2),:) = img1;
