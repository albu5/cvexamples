function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid
PrincipalCurvature = zeros(size(DoGPyramid));
for i = 1:size(DoGPyramid,3)
    I = DoGPyramid(:,:,i);
    H = computeHessian(I);
    R = (tracefun(H).^2) ./ (detfun(H));
    PrincipalCurvature(:,:,i) = R;
end
end

function T = tracefun(H)
T = H.ixx + H.iyy;
end

function D = detfun(H)
D = ((H.ixx) .* (H.iyy)) - ((H.ixy) .* (H.iyx));
end