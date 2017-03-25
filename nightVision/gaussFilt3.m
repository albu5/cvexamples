function G = gaussFilt3(I,J,d,smin,smax,window)
window = window+1;
wini = window(1);
winj = window(2);
wink = window(3);
G = zeros(size(I));
dims = size(I);
di = dims(1);
dj = dims(2);
dk = dims(3);
for i = 1:size(G,1)
    for j = 1:size(G,2)
        display(sprintf('%d|%d, %d|%d',i,di,j,dj));
        parfor k = 1:size(G,3)
            res = 0;
            mu = 0;
            [R,S] = gaussKernel3(squeeze(J(:,:,i,j,k)), d, smin, smax);          
            for x = 1:wini
                if i+x-wini/2 > di, break, end;
                if i+x-wini/2 < 1, continue, end;
                
                for y = 1:winj
                    if j+y-winj/2 > dj, break, end;
                    if j+y-winj/2 < 1, continue, end;
                    
                    for t = 1:wink
                        if k+t-wink/2 > dk, break, end;
                        if k+t-wink/2 < 1, continue, end;
                        
                        v = [x-wini/2; y-winj/2; t-wink/2];
                        garg = exp( -0.5*( v' * R * (S * S') * R' * v ) );
                        
                        res = res + garg*I(i+v(1), j+v(2), k+v(3));
                        mu = mu + garg;
                    end
                end
            end
            G(i,j,k) = res/mu;
        end
    end
end
end