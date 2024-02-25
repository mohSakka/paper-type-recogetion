%% initialization
clear;
clc;
close all;
%% knn parameters
knnk = 4;
%% loading data
load([cd '/../data/expandedDatasetCLBP']);
load([cd '/../data/expandedDatasetGabor']);
load([cd '/../data/expandedDatasetLBP']);
load([cd '/../data/expandedDatasetHaar']);
%
Features{1} = expandedDatasetCLBP(:,1:end-1);
Labels{1} = expandedDatasetCLBP(:,end);
Features{2} = expandedDatasetGabor(:,1:end-1);
Labels{2} = expandedDatasetGabor(:,end);
Features{3} = expandedDatasetLBP(:,1:end-1);
Labels{3} = expandedDatasetLBP(:,end);
Features{4} = expandedDatasetHaar(:,1:end-1);
Labels{4} = expandedDatasetHaar(:,end);
%% start
currentInd = 1;
numberOfFeatures = 4;
k = 1; % number of the selected features
numberOfActions = nchoosek(numberOfFeatures,k); % number of actions
numberOfStates = numberOfActions; % number of states
states = combnk(1:numberOfFeatures,k);% all possible states
counter = 0;
T = 50;
numberOfPeriods = round(size(Features{1},1)/T);
% numberOfPeriods=1;
%% continue with q-learning
counter2 = 1;
pInd = 1;
for period = 1:numberOfPeriods
    for f = 1:numberOfFeatures
    chunkFeatures{f} = Features{f}(currentInd: currentInd + T -1,:);
    chunkLabels{f} = Labels{f}(currentInd: currentInd + T -1);
    end
    % updating R and Q matrices
    for s = 1:numberOfStates
        % compting the accuracy of the current state
            currState = states(s,:);
            x = chunkFeatures{s};
            y = chunkLabels{s};
            [stateAcc(s),predictedLabels(pInd:pInd+T-1,s)] = computeKnnClassificationAcc(x,y,knnk);
            progress = counter/(numberOfStates*numberOfPeriods);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
            counter = counter+1;
            counter2 = counter2+1;
    end
  Acc(period,:) = stateAcc;
  currentInd = currentInd + T;
  pInd = pInd + T;
  trueLabels = Labels;
end
save([cd '/../results/KNN_dataSetA.mat']);