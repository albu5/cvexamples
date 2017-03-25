function G = gaussFiltVec3(I,J,d,smin,smax,window)
window = window+1;
wini = window(1);
winj = window(2);
wink = window(3);
G = zeros(size(I));
dims = size(I);
di = dims(1);
dj = dims(2);
dk = dims(3);
wb = waitbar(0,'Smoothing image may take minutes...');
for i = 1:size(G,1)
    waitbar(i/size(G,1));
    for j = 1:size(G,2)
%         display(sprintf('%d|%d, %d|%d',i,di,j,dj));
        for k = 1:size(G,3)
            imin = max(1,i-wini/2);
            imax = min(di,i+wini/2);
            jmin = max(1,j-winj/2);
            jmax = min(dj,j+winj/2);
            kmin = max(1,k-wink/2);
            kmax = min(dk,k+wink/2);
            
            [jgrid,igrid,kgrid] = meshgrid(jmin:jmax,imin:imax,kmin:kmax);
            Ipatch = I(imin:imax,jmin:jmax,kmin:kmax);

            [R,S] = gaussKernel3(squeeze(J(:,:,i,j,k)), d, smin, smax);
            v = cat(4,igrid-i,jgrid-j,kgrid-k);
            temp1 = R * (S * S') * R';
            temp2 = multiprod(v,temp1,[4],[1 2]);
            temp3 = multiprod(temp2,v,[4],[4]);
%             display(sum(isnan(temp2(:))))
%             hist(temp3(:)),pause
            garg = exp(-0.5*temp3);
%             hist(garg(:)), pause(0.5)
            temp4 = garg.*Ipatch;
            res = sum(temp4(:));
            mu = sum(garg(:));
            G(i,j,k) = res/mu;
        end
    end
end
close(wb)
end