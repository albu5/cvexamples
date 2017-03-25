function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary
patchWidth = 9;
margin = (patchWidth-1)/2;
W = size(im,2);
H = size(im,1);

badidx = locsDoG(:,2)-margin<1;
badidx = badidx | locsDoG(:,2)+margin>H;
badidx = badidx | locsDoG(:,1)+margin>W;
badidx = badidx | locsDoG(:,1)-margin<1;
desc = [];
locs = locsDoG(~badidx,:);

[ay,ax] = ind2sub(patchWidth,compareA);
[by,bx] = ind2sub(patchWidth,compareB);
for loc = locs'
    tempim = GaussianPyramid(:,:,loc(3));
    X1 = ax-1-margin+loc(1);
    Y1 = ay-1-margin+loc(2);
    X2 = bx-1-margin+loc(1);
    Y2 = by-1-margin+loc(2);
    l1 = sub2ind(size(im),Y1,X1);
    l2 = sub2ind(size(im),Y2,X2);
    fvec = tempim(l1)<tempim(l2);
    desc = vertcat(desc,fvec(:)');
end


