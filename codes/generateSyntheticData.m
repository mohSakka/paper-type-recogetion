%% initialization
% clear;
% clc;
% close all;
%% start
numberOfFeatures = 8;
numberOfRecords = 10000;
maxBeta = 50;
minBeta = 0;
maxAlpha = 100;
minAlpha = 0;
minC = 0;
maxC = 30;
beta = minBeta + maxBeta * rand(1,numberOfFeatures);
alpha = minAlpha + maxAlpha * rand(1,numberOfFeatures);
c = minC + maxC * rand(1,numberOfFeatures);
beta = repmat(beta,numberOfRecords,1);
alpha = repmat(alpha,numberOfRecords,1);
c = repmat(c,numberOfRecords,1);
t = 1:numberOfRecords;
t = t'
t = repmat(t,1,numberOfFeatures);
Features = alpha .* sin(beta .* t) + c;
numberOfPeriods = 10;
T = round(numberOfRecords/numberOfPeriods); % ensure that you will get equal periods, else you will get error
ind = 1;
OldFeaturesRatio = 0.25;
oldSubset=[];
for period = 1 : numberOfPeriods
    K = randi(numberOfFeatures);
    if isempty(oldSubset)
        subset = randperm(numberOfFeatures,K) % subSet
    else
        numberOfOldFeatures = round(min(OldFeaturesRatio * K,OldFeaturesRatio * length(oldSubset)));
        oldFeaturesInds = randperm(length(oldSubset),numberOfOldFeatures);
        oldFeatures = oldSubset(oldFeaturesInds);
        newFeatures = randperm(numberOfFeatures,K - numberOfOldFeatures);
        subset = [oldFeatures newFeatures]
        while length(unique(subset)) ~= length(subset)
            newFeatures = randperm(numberOfFeatures,K - numberOfOldFeatures);
            subset = [oldFeatures newFeatures];
        end
    end
        subsetFeatures = Features(ind:ind+T-1,subset);
        w = rand(1,K);
        w = w/sum(w);
        w = repmat(w,T,1);
        weightedSubsetFeatures = w.*subsetFeatures;
        Labels(ind:ind+T-1,:) = sum(weightedSubsetFeatures,2);
        ind = ind + T;
        oldSubset=subset;
        subsets{period} = subset;
    end
    normLabels = (Labels-min(Labels))/(max(Labels)-min(Labels));
    numberOfClasses = 5;
    thresh = 1:numberOfClasses;
    thresh = thresh/numberOfClasses;
    for i = 1:numberOfClasses
        if i==1
        normLabels(normLabels<thresh(i)) = i;
        else
          normLabels(normLabels>=thresh(i-1) & normLabels<thresh(i)) = i;
        end
    end
    Labels = normLabels;
    %% saving
    dir = [cd '/data'];
    if ~exist(dir)
        mkdir(dir);
    end
    save([dir '/syntheticData'],'Features','Labels','T','numberOfRecords','numberOfPeriods',...
        'numberOfFeatures','subsets');