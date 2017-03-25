function bestH = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC
if ~exist('nIter','var')
    nIter = 1000;
end
if ~exist('tol','var')
    tol = 4;
end

p1 = locs1(matches(:,1),1:2);
p2 = locs2(matches(:,2),1:2);

coef.minPtNum = 8;
coef.iterNum = nIter;
coef.thDist = tol;
coef.thInlrRatio = .1;
bestH = ransac(p1',p2',coef,@solveHomo,@ptsDist);
end

function d = ptsDist(H,p1,p2)
n = size(p1,2);
p3 = H*[p1;ones(1,n)];
p3 = p3(1:2,:)./repmat(p3(3,:),2,1);
d = sqrt(sum((p2-p3).^2,1));
end