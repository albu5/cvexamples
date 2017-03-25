%% debugScript

% [X, MAP] = imread('shadow.tif');
% I = ind2rgb(X,MAP);
% J = clhe(I,0.005);
% imshow([I J])

%%
Vtennis = readVolume('test_videos/noise_free/tennis');
viewVolume(Vtennis);
close
%%
params.exposure = 0.2;
params.noise_level = 0.005;
params.beta = 0.05;
params.window = [13 13 13];
params.sigma = 0.5;
params.smax = 0.5;
params.smin = 0.1;
params.d = 0.004;
params.alpha = 0.1;
T = 8;
f = 1/2;
%%
Vtennis_dark = Vtennis*params.exposure;
viewVolume(Vtennis_dark,60);
close
%%
Vtennis_dark_noisy = Vtennis_dark + params.noise_level*randn(size(Vtennis_dark));
viewVolume(Vtennis_dark_noisy,60);
close
%%
Vtennis_dn_T = clheVid(Vtennis_dark_noisy,params.beta);

%%
viewVolume(Vtennis_dn_T,5);
close
%%
I = squeeze(mean(Vtennis_dn_T,3));
I = imresize(I,f);
I = I(:,:,1:T);
J = structTensor(I,params.sigma, params.window);

%%
viewVolume(squeeze(J(1,1,:,:,:)));
viewVolume(squeeze(J(2,2,:,:,:)));
viewVolume(squeeze(J(3,3,:,:,:)));
close all

%%
% G = gaussFiltVec3(I,J,params.d,params.smin,params.smax,params.window);
[B,evalarr] = baseFiltVec3(I,J,params.d,params.smin,params.smax,params.window,params.alpha);

%%
O = imresize(squeeze(mean(Vtennis(:,:,:,1:T),3)),f);
viewVolume([B B;I O],1);
viewVolume(cat(1,cat(2,G,I),cat(2,B,squeeze(mean(Vtennis(:,:,:,1:15),3)))),1);
