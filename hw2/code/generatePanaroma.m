function I = generatePanaroma(im1,im2)
img1_g = im2double(rgb2gray(im1));
img2_g = im2double(rgb2gray(im2));
[locs1, desc1] = briefLite(img1_g);
[locs2, desc2] = briefLite(img2_g);
matches = briefMatch(desc1,desc2,0.7);
H = ransacH(matches, locs1, locs2, 20000, 2);
I = (imageStitching_noClip(im1, im2, H));