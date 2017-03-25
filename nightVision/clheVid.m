function J = clheVid(I,beta)
J = zeros(size(I));
for i = 1:size(I,4)
   J(:,:,:,i) = clhe(I(:,:,:,i),beta);
end
end