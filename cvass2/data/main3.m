load rgbd.mat;
camera_params
R(3,:) = [t_x, t_y, t_z];
Intrinsic = [fx_d, 0, px_d; 0 fy_d, py_d; 0, 0, 1];
%%
imagesc(depth)

%%
[X,Y] = meshgrid(1:size(im,2), 1:size(im,1));
Z = depth;

%%
figure
for i = 1:max(labels(:))
    obj(i).R = (Intrinsic\[X(labels==i), Y(labels==i), ones(size(Z(labels==i)))]')';
    obj(i).R(:,3) = Z(labels==i);
    obj(i).wc = (R*obj(i).R')';
    obj(i).centre = mean(obj(i).wc,1);
    scatter3(obj(i).wc(:,1), obj(i).wc(:,2), obj(i).wc(:,3), 'r.'), hold on
end
drawnow(), hold off

%%
distvec = [];
hvec = [];
for i = 1:max(labels(:))
    distvec = horzcat(distvec, norm(obj(i).wc));
    hvec = horzcat(hvec, obj(i).wc(2));
end

[hmax,tallid] = max(hvec);
[zmax,farid] = max(distvec);
display(sprintf('farthest object is %d, at a mean distance of %f', farid, zmax));
display(sprintf('tallest object is %d, with mean height of %f', tallid, hmax));

%%
% top of one another means same position in x and z direction, but
% different y (height) in world coordinate system. Thus, we need to find
% objects that are close to eah other but have different heigths H

