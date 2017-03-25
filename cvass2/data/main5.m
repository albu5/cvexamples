K = [721.5, 0, 609.6; 0, 721.5, 172.9; 0, 0, 1];

%%
% ground plane is y=0 in world coordinates. Thus, y = -1.7 is the equation
% of ground in camera coordinate system.

%%
% let [x y z] be coordinates is World. [xr, yr, zr, 1] = inv(R)*[x y z] are the corrdinates
% in camera coordinate system (retinal). Replace zr by 1, and [xi,yi,1] =
% K*[xr, yr, 1]. Thus, (xi, yi) are the image plane coordinates. r is
% extrinsic rotation matrix
% R = [1,0,0,0;
%      0,1,0,-1.7;
%      0,0,1,0;
%      0,0,0,1]
% K is as described above