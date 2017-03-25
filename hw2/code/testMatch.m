%%
im1 = im2double(rgb2gray(imread('../data/model_chickenbroth.jpg')));
im2 = im2double(rgb2gray(imread('../data/chickenbroth_02.jpg')));
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1,desc2);
figure
plotMatches(im1, im2, matches, locs1, locs2);

%%
im1 = im2double((imread('../data/pf_scan_scaled.jpg')));
im2 = im2double(rgb2gray(imread('../data/pf_desk.jpg')));
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1,desc2);
figure
plotMatches(im1, im2, matches, locs1, locs2);