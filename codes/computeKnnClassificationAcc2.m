function [accuracy predictedClass] = computeKnnClassificationAcc2(x,y,prevX,prevY,k)
distances = zeros(size(prevX,1),size(x,1));
distances = pdist2(prevX,x);
[sortedDistances , kPointsInds] = sort(distances,1);
kLabels = y(kPointsInds(1:1+k-1,:));
for p = 1:size(prevX,1)
classes = unique(kLabels(:,p));
counts = histc(kLabels(:,p), classes);
[~,i] = max(counts);
predictedClass(p) = classes(i);
end
predictedClass = predictedClass';
hit = predictedClass==prevY;
numberOfTruePositive = length(find(hit==1));
% accuracy = numberOfTruePositive/length(hit);
accuracy = findRealAcc(length(unique(y)),y,predictedClass);
end