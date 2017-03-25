I = imread('shoe.jpg');
imshow(I);

%%
title('click on corners of bill')
[billx,billy] = getpts;
hold on, fill(billx,billy,'r','FaceAlpha',0.3), hold off

%%
billh = 69.85;
billw = 152.4;
billx_top = [0,billw,billw,0]';
billy_top = [0,0,billh,billh]';
H = computeH([billx,billy]',[billx_top,billy_top]');

%%
title('click on two points on shoe for width')
[swx,swy] = getpts;
hold on, line(swx,swy), hold off

%%
title('click on two points on shoe for length')
[slx,sly] = getpts;
hold on, plot(slx,sly,'g'), hold off

%%
W_coord = H*[swx(1), swx(2); swy(1), swy(2); 1,1]
L_coord = H*[slx(1), slx(2); sly(1), sly(2); 1,1]

%%
L = abs(L_coord(1,1)-L_coord(1,2));
W = abs(W_coord(2,1)-W_coord(2,2));
display(sprintf('length is: %f cm, width is: %f cm',L/10,W/10));

%%
figure
fill(billx_top,billy_top,'r','FaceAlpha',0.3), hold on
scatter(W_coord(2:3,1),W_coord(2:3,2), 'b')
scatter(L_coord(2:3,1),L_coord(2:3,2), 'g')
