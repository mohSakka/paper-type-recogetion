%% initialization
clear;
clc;
close all;
%% knn parameters
knnk = 4;
%% loading data
load([cd '/../data/expandedDatasetCLBP_UKM']);
load([cd '/../data/expandedDatasetGabor_UKM']);
load([cd '/../data/expandedDatasetLBP_UKM']);
load([cd '/../data/expandedDatasetHaar_UKM']);

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
            if period==1
            [stateAcc(s),predictedLabels(pInd:pInd+T-1,s)] = computeKnnClassificationAcc(x,y,knnk);
            else
               [stateAcc(s),predictedLabels(pInd:pInd+T-1,s)] = computeKnnClassificationAcc2(x,y,prevX{s},prevY{s},knnk); 
            end
            progress = counter/(numberOfStates*numberOfPeriods);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
            counter = counter+1;
            counter2 = counter2+1;
            prevX{s} = x;
            prevY{s} = y;
    end
  Acc(period,:) = stateAcc;
  currentInd = currentInd + T;
  pInd = pInd + T;
  trueLabels = Labels;
end
save([cd '/../results/KNN2version_dataSetUKM.mat']);