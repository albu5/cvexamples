function h = plotInterestPoints(im, locs, po)
%% plotInterestPoints
% im = image for interest points
% locs = locations of interest points, each row containing [x,y,scale]
% po = fraction of interests point to be drawn
% h = output handle for the plot
h = imshow(im); hold on
if ~exist('po','var')
    po = 0.1;
end
s = max(size(im,1),size(im,2))/150;
for  i = 1:size(locs,1);
    if rand>po, continue, end
    c = [rand rand rand];
    try
        rectangle('Position',...
            [locs(i,1)-s*locs(i,3), locs(i,2)-s*locs(i,3), 2*s*locs(i,3), 2*s*locs(i,3)],...
            'Curvature', [1 1],...
            'EdgeColor', c);
        scatter(locs(i,1),locs(i,2),[],c,'+')
    catch
        continue
    end
    pause(0.000000001)
end
hold off
end