% Script to test BRIEF under rotations
im = imread('../data/model_chickenbroth.jpg');
im = rgb2gray(im);
im = im2double(im);
tol = 1;
errata = [];
for i = 0:10:90
   imr = imrotate(im, -i);
   [locs1, desc1] = briefLite(im);
   [locs2, desc2] = briefLite(imr);
   matches = briefMatch(desc1, desc2);
   plotMatches(im, imr, matches, locs1, locs2);
   display(size(matches,1))
   errata(end+1) = input('what are the number of correct matches? ');
end
bar(errata)