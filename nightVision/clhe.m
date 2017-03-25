function J = clhe(I, beta, ntiles, nbins, distr, alpha)

if ~exist('beta', 'var')
    beta = 0.01;
end

if ~exist('ntiles', 'var')
    ntiles = [2 2];
end

if ~exist('nbins', 'var')
    nbins = 256;
end

if ~exist('distr', 'var')
    distr = 'uniform';
end

if ~exist('alpha', 'var')
    alpha = 0.4;
end


if size(I,3) == 1
    J = adapthisteq(I,'NumTiles',ntiles, 'ClipLimit',beta,...
        'NBins',nbins, 'Range','full', 'Distribution', distr, 'Alpha', alpha);
else
    LAB = rgb2lab(I);
    temp = strcmp(distr,'uniform');
    if ~strcmp(distr,'uniform')
        LAB(:,:,1) = 100*adapthisteq(LAB(:,:,1)/100,'NumTiles',ntiles,...
            'ClipLimit',beta, 'NBins',nbins, 'Range','full',...
            'Distribution', distr, 'Alpha', alpha);
    else
        LAB(:,:,1) = 100*adapthisteq(LAB(:,:,1)/100,'NumTiles',ntiles,...
            'ClipLimit',beta, 'NBins',nbins, 'Range','full',...
            'Distribution', distr);
    end
    J = lab2rgb(LAB);
end


