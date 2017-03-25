function M = gnm(n,m)
M = zeros(n);
count = 0;
ne = m;
while(count<m)
idx = randi(numel(M), [ne,1]);
M(idx) = 1;
M = M | M';
M = M.*(1-eye(n));
count = sum(M(:))/2;
% pause(2)
ne = m-count;
end