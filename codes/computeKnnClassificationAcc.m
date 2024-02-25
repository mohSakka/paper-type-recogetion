function [accuracy predictedClass] = computeKnnClassificationAcc(x,y,k)
distances = zeros(size(x,1),size(x,1));
distances = pdist2(x,x);
[sortedDistances , kPointsInds] = sort(distances,1);
kLabels = y(kPointsInds(2:2+k-1,:));
for p = 1:size(x,1)
classes = unique(kLabels(:,p));
counts = histc(kLabels(:,p), classes);
[~,i] = max(counts);
predictedClass(p) = classes(i);
end
predictedClass = predictedClass';
hit = predictedClass==y;
numberOfTruePositive = length(find(hit==1));
% accuracy = numberOfTruePositive/length(hit);
accuracy = findRealAcc(length(unique(y)),y,predictedClass);
end