function J = structTensor(V,sigma,window)
dims = size(V);
J = zeros([3,3,dims]);
[Gx,Gy,Gt] = gradient(V);

J(1,1,:,:,:) = imgaussfilt3(Gx.*Gx, sigma, 'FilterSize',window, 'padding','symmetric');
J(1,2,:,:,:) = imgaussfilt3(Gx.*Gy, sigma, 'FilterSize',window, 'padding','symmetric');
J(1,3,:,:,:) = imgaussfilt3(Gx.*Gt, sigma, 'FilterSize',window, 'padding','symmetric');

J(2,1,:,:,:) = imgaussfilt3(Gy.*Gx, sigma, 'FilterSize',window, 'padding','symmetric');
J(2,2,:,:,:) = imgaussfilt3(Gy.*Gy, sigma, 'FilterSize',window, 'padding','symmetric');
J(2,3,:,:,:) = imgaussfilt3(Gy.*Gt, sigma, 'FilterSize',window, 'padding','symmetric');

J(3,1,:,:,:) = imgaussfilt3(Gt.*Gx, sigma, 'FilterSize',window, 'padding','symmetric');
J(3,2,:,:,:) = imgaussfilt3(Gt.*Gy, sigma, 'FilterSize',window, 'padding','symmetric');
J(3,3,:,:,:) = imgaussfilt3(Gt.*Gt, sigma, 'FilterSize',window, 'padding','symmetric');
end