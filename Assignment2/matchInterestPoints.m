function [matches] = matchInterestPoints(desc1, desc2, ratio)
%function [matches] = briefMatch(desc1, desc2, ratio)
% Performs the descriptor matching
% inputs  : desc1 , desc2 - m1 x n and m2 x n matrix. m1 and m2 are the number of keypoints in image 1 and 2.
%						    n is the number of bits in the brief
% outputs : matches - p x 2 matrix. where the first column are indices
%									into desc1 and the second column are indices into desc2

if nargin<3
    ratio = .8;
end
D = dist2(desc1, desc2);
ix = [];
iy = [];
d = [];
for i = 1:size(D,1)
   [B,I] = sort(D(i,:));
   if (B(1)/B(2) > ratio), continue, end
   ix(end+1) = i;
   iy(end+1) = I(1);
   d(end+1) = B(1);
end
matches = [ix', iy', d'];
end