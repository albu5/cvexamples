function [ iw3 ] = imageStitching_noClip( img1, img2, H)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
TL = H\[1,1,1]';
BL = H\[1,max([size(img2,1),size(img2,1)]),1]';
TR = H\[max([size(img2,2),size(img2,2)]),1,1]';
BR = H\[max([size(img2,2),size(img2,2)]),...
    max([size(img2,2),size(img2,2)]),1]';
xmin = min([TL(1), BL(1), TR(1), BR(1)]);
xmax = max([TL(1), BL(1), TR(1), BR(1)]);
ymin = min([TL(2), BL(2), TR(2), BR(2)]);
ymax = max([TL(2), BL(2), TR(2), BR(2)]);
tx = (floor(min(0,xmin)));
ty = (floor(min(0,ymin)));
M = eye(3);
M(1,3) = 2*tx;
M(2,3) = 2*ty;
iw1 = warpH(img1, inv(M), round([1.5*size(img1,1), 2*size(img1,2)]));
iw2 = warpH(img2, inv(M)*inv(H), round([1.5*size(img1,1), 2*size(img1,2)]));
iw3 = iw2;
temp1 = M\[size(img1,2);size(img1,1);1];
temp2 = M\[1;1;1];
iw3(temp2(2):temp1(2),temp2(1):temp1(1),:) = iw1(temp2(2):temp1(2),temp2(1):temp1(1),:);
end

