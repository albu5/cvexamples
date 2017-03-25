close all

T = imresize(fliplr(imread('toy.jpg')),1/3);
imshow(T);

[locs, desc] = vl_sift(single(rgb2gray(T)));
locs = locs';
desc = desc';

plotInterestPoints(T, locs);
drawnow()

%%
figure
I = imresize(imread('11.jpg'),1/2);
imshow(I)

[locsi, desci] = vl_sift(single(rgb2gray(I)));
locsi = locsi';
desci = desci';

plotInterestPoints(I, locsi);
drawnow()

%%
matches = matchInterestPoints(desc, desci);

figure
plotInterestPoints(T, locs(matches(:,1),:), 1);
drawnow()

figure
plotInterestPoints(I, locsi(matches(:,2),:), 1);
drawnow()

%%
H = ransacH(matches, locs, locsi, 100000);
%%
corners = [1,1,1;...
           1,size(T,1),1;...
           size(T,2),size(T,1),1;...
           size(T,2),1,1;];
cornersR = (H*corners')';
figure
x = cornersR(:,1);
y = cornersR(:,2);
imshow(I), hold on, fill(x,y,'r','FaceAlpha',0.3), hold off
drawnow()