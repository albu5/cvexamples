function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
p1 = p1';
p2 = p2';
A = [];
for i = 1:size(p1,1)
    x1 = p1(i,1);
    x2 = p2(i,1);
    y1 = p1(i,2);
    y2 = p2(i,2);
    
    A = vertcat(A,[-x1, -y1, -1, 0, 0, 0, x2*x1, x2*y1, x2]);
    A = vertcat(A,[0, 0, 0, -x1, -y1, -1, y2*x1, y2*y1, y2]);    
end
[V,~] = eig(A'*A);
h = V(:,1);
h = h/(h(end));
H2to1 = reshape(h,[3,3])';
