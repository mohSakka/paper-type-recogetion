%% initialization
clear;
clc;
close all;
%% knn parameters
knnk = 4;
%% loading data
load([cd '/../data/iris.mat']);
%
Features{1} = data(:,1);
Labels{1} = data(:,end);
%
Features{2} = data(:,2);
Labels{2} = data(:,end);
%
Features{3} = data(:,3);
Labels{3} = data(:,end);
%
Features{4} = data(:,4);
Labels{4} = data(:,end);
%% start
currentInd = 1;
numberOfFeatures = 4;
k = 1; % number of the selected features
numberOfActions = nchoosek(numberOfFeatures,k); % number of actions
numberOfStates = numberOfActions; % number of states
states = combnk(1:numberOfFeatures,k);% all possible states
counter = 0;
T = 10;
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
save([cd '/../results/KNN2version_dataSetIRIS.mat']);