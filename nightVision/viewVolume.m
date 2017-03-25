function h =  viewVolume(volume, fps)
if ~exist('fps','var')
    fps = 30;
end
h = figure;
if numel(size(volume))==4
    for i = 1:size(volume,4)
        imagesc(volume(:,:,:,i)), axis image
        pause(1/fps)
    end
else
    for i = 1:size(volume,3)
        imagesc(volume(:,:,i)), axis image, colormap gray
        pause(1/fps)
    end
end
end