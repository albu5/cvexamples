%%
levels = [-1, 0, 1, 2, 3, 4];
K = sqrt(2);
sigma0 = 1;
thetac = 0.03;
thetar = 12;
I = im2double(rgb2gray(imread('../data/model_chickenbroth.jpg')));

%%
mypyr = (createGaussianPyramid(I,...
    sigma0,K, levels));
displayPyramid(mypyr)

%%
[mypyrdog,L] = createDoGPyramid(mypyr, levels);
displayPyramid(mypyrdog);

%%
[ix,iy] = gradient(I);
[ixx, ixy] = gradient(ix);
[iyx, iyy] = gradient(iy);
figure, imagesc([ix,iy]), axis image, colormap gray
figure, imagesc([ixx, iyy, ixy, iyx]), axis image, colormap gray

%%
pc = computePrincipalCurvature(mypyrdog);
displayPyramid(log(pc))

%%
locsDoG = getLocalExtrema(mypyrdog, L, pc, thetac, thetar);
imagesc(I), axis image, colormap gray
hold on, scatter(locsDoG(:,1),locsDoG(:,2),'g*');

%%
[locs, pyr] = DoGdetector(I,sigma0, K, levels, thetac, thetar);
imagesc(I), axis image, colormap gray
hold on, scatter(locs(:,1),locs(:,2),'g*');

%%
[compareX,compareY] = makeTestPattern(9,256);
save testPattern.mat compareX compareY

%%
[locs,desc] = computeBrief(I, mypyr, locs, K,...
    levels,compareX, compareY);

%%
im1 = im2double(rgb2gray(imread('../data/model_chickenbroth.jpg')));
im2 = im2double(rgb2gray(imread('../data/chickenbroth_02.jpg')));
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1,desc2);
plotMatches(im1, im2, matches, locs1, locs2);

%%
p1 = locs1(matches(:,1),1:2);
p2 = locs2(matches(:,2),1:2);
H = computeH(p1',p2');
HR = ransacH(matches, locs1, locs2, 50, 4);

%%
clear
img1 = imread('../data/incline_L.png');
img1_g = im2double(rgb2gray(img1));
img2 = imread('../data/incline_R.png');
img2_g = im2double(rgb2gray(img2));

[locs1, desc1] = briefLite(img1_g);
[locs2, desc2] = briefLite(img2_g);
matches = briefMatch(desc1,desc2,0.7);
plotMatches(img1, img2, matches, locs1, locs2);
%%
H = ransacH(matches, locs1, locs2, 20000, 2);
%%
imshow(imageStitching(img1, img2, H));
%%
imshow(imageStitching_noClip(img1, img2, H));
%%
imshow(generatePanaroma(img1,img2));

%%
