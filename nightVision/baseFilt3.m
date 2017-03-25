function G = baseFilt3(I,J,d,smin,smax,window,alpha)
window = window+1;
G = zeros(size(I));
dims = size(I);
for i = 1:size(G,1)
    for j = 1:size(G,2)
        for k = 1:size(G,3)
            res = 0;
            mu = 0;
            for x = 1:window(1)
                if i+x-window(1)/2 > dims(1), continue, end;
                if i+x-window(1)/2 < 1, continue, end;
                
                for y = 1:window(2)
                    if j+y-window(2)/2 > dims(2), continue, end;
                    if j+y-window(2)/2 < 1, continue, end;
                    
                    for t = 1:window(3)
                        if k+t-window(3)/2 > dims(3), continue, end;
                        if k+t-window(3)/2 < 1, continue, end;
                        
                        v = [x-window(1)/2; y-window(2)/2; t-window(3)/2];
                        [R,S] = gaussKernel3(squeeze(J(:,:,i,j,k)), d, smin, smax);
                        garg = exp( -0.5*( v' * R * (S * S') * R' * v ) ) *...
                            (1-alpha*(v' * R * (S * S') * R' * v) );
                        
                        res = res + garg*I(v(1), v(2), v(3));
                        mu = mu + garg;
                    end
                end
            end
            G(i,j,k) = res/mu;
        end
    end
end
end