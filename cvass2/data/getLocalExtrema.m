function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
    PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.
N = circshift(DoGPyramid,[-1, 0, 0]);
NE = circshift(DoGPyramid,[-1, 1, 0]);
E = circshift(DoGPyramid,[0, 1, 0]);
SE = circshift(DoGPyramid,[1, 1, 0]);
S = circshift(DoGPyramid,[1, 0, 0]);
SW = circshift(DoGPyramid,[1, -1, 0]);
W = circshift(DoGPyramid,[0, -1, 0]);
NW = circshift(DoGPyramid,[-1, -1, 0]);
Coarse = circshift(DoGPyramid,[0,0,1]);
Fine = circshift(DoGPyramid,[0,0,-1]);

locs = (DoGPyramid>=N)&(DoGPyramid>=NE)&(DoGPyramid>=E)&...
    (DoGPyramid>=SE)&(DoGPyramid>=S)&(DoGPyramid>=SW)&...
    (DoGPyramid>=W)&(DoGPyramid>=NW)&...
    (DoGPyramid>=Coarse)&(DoGPyramid>=Fine);
locs(:,:,1) = 0;
locs(:,:,end) = 0;
Xl = [];
Yl = [];
Dl = [];
for i = 1:size(DoGPyramid,3)-2
    iloc = locs(:,:,i+1);
    D = DoGPyramid(:,:,i+1);
    R = PrincipalCurvature(:,:,i+1);
    iloc = iloc & (D>th_contrast);
    iloc = iloc & (R<th_r);
    [Yt,Xt] = find(iloc);
    Xl = vertcat(Xl,Xt);
    Yl = vertcat(Yl,Yt);
    Dl = vertcat(Dl,DoGLevels(i+1)*ones(size(Xt)));
end
locsDoG = horzcat(Xl,Yl,Dl);