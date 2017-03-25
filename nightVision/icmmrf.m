V1 = squeeze(mean(Vtennis_dn_T(:,:,:,1:3),3));
vb = 10000;
alpha = 0.95;

it = 0;
disp = 1;
dims = size(V1);
while true
    i = randi([2 dims(1)-1]);
    j = randi([2 dims(2)-1]);
    k = randi([2 dims(3)-1]);
    
    V1(i,j,k) = alpha*(V1(i,j,k)) +...
        (1-alpha)*(V1(i+1,j,k)+...
                   V1(i-1,j,k)+...
                   V1(i,j+1,k)+...
                   V1(i,j-1,k)+...
                   V1(i,j,k+1)+...
                   V1(i,j,k-1));
     if rem(it,vb)==0
         imagesc(V1(:,:,disp)), axis image, colormap gray;
         drawnow()
         disp = disp+1;
         if disp==dims(3), disp=2; end;
     end
     it = it+1;
end