function [f] = ransac( x,y,ransacCoef,funcFindF,funcDist )

thInlrRatio = ransacCoef.thInlrRatio;
thDist = ransacCoef.thDist;
thInlr = round(thInlrRatio*size(x,2));
inlrNum = zeros(1,ransacCoef.iterNum);
fLib = cell(1,ransacCoef.iterNum);
for p = 1:ransacCoef.iterNum
	sampleIdx = randIndex(size(x,2),max(thInlr,ransacCoef.minPtNum));
	f1 = funcFindF(x(:,sampleIdx),y(:,sampleIdx));
	dist = funcDist(f1,x,y);
	inlier1 = find(dist < thDist);
	inlrNum(p) = length(inlier1);
	if length(inlier1) < thInlr, continue; end
	fLib{p} = funcFindF(x(:,inlier1),y(:,inlier1));
end
[~,idx] = max(inlrNum);
plot(inlrNum)
f = fLib{idx};	
end