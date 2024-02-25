%% initialization
clear;
clc;
close all;
%% Q-Learning parameters
gamma = 0.8;
alpha = 0.33;
oldQTableWeight = 0.1;
%% knn parameters
knnk = 4;
%% loading data
load([cd '/../data/expandedDatasetCLBP']);
load([cd '/../data/expandedDatasetGabor']);
load([cd '/../data/expandedDatasetLBP']);
load([cd '/../data/expandedDatasetHaar']);
Features{1} = expandedDatasetCLBP(:,1:end-1);
Labels{1} = expandedDatasetCLBP(:,end);
Features{2} = expandedDatasetGabor(:,1:end-1);
Labels{2} = expandedDatasetGabor(:,end);
Features{3} = expandedDatasetLBP(:,1:end-1);
Labels{3} = expandedDatasetLBP(:,end);
Features{4} = expandedDatasetHaar(:,1:end-1);
Labels{4} = expandedDatasetHaar(:,end);
%% start
reductionRatio = 0.5; % reduction ratio
currentInd = 1;
numberOfFeatures = 4;
k = 1; % number of the selected features
numberOfActions = nchoosek(numberOfFeatures,k); % number of actions
numberOfStates = numberOfActions; % number of states
actions = combnk(1:numberOfFeatures,k); % all possible actions
states = actions; % all possible states
R = zeros(numberOfActions); % R matrix (state matrix)
Q = zeros(numberOfActions); % Q table
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
            if period == 1
            stateAcc = computeKnnClassificationAcc(x,y,knnk);
            else 
             stateAcc = computeKnnClassificationAcc2(x,y,previousFeatures{s},previousLabels{s},knnk);
            end
        for a = 1:numberOfActions
            progress = counter/(numberOfStates*numberOfActions*numberOfPeriods);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
            currAction = actions(a,:);
            % computing accuracy of the current action
            x = chunkFeatures{a};
            y = chunkLabels{a};
            if period == 1
            actionAcc = computeKnnClassificationAcc(x,y,knnk);
            else
              actionAcc = computeKnnClassificationAcc2(x,y,previousFeatures{a},previousLabels{a},knnk); 
            end
            actionAccTs(s,a) = actionAcc;
            % reward
            R(s,a) = actionAcc -stateAcc  ;
            v = 1:length(Q); % just temporal variable
            % updating Q value
             Q(s, a) = oldQTableWeight * Q(s, a) + (1-oldQTableWeight) * ...
                (alpha * (R(s,a) + gamma *....
                max(Q(s, v~=s)) - Q(s, a)));
%             Q(s, a) = oldQTableWeight * Q(s, a) + ...
%                 (alpha * (R(s,a) + gamma *....
%                 max(Q(s, v~=s)) - Q(s, a))); 
            counter = counter+1;
            counter2 = counter2+1;     
        end
         
    end
 
    QTimeSer{period} = Q;
  Acc(period) = max(max(Q));
  [tmpMax,i] = max(Q);
  [tmpMax,j] = max(tmpMax);
  bestState(period,:) = states(i(1),:);
  bestAction(period,:) = actions(j(1),:);
  if period==1
   newX = Features{bestAction(period,:)}(pInd: pInd + T -1,:);
    newY = Labels{bestAction(period,:)}(pInd : pInd + T -1);
  [~,predictedLabels(pInd: pInd + T -1)] = computeKnnClassificationAcc(newX,newY,knnk);
  else
      newX = Features{bestAction(period,:)}(pInd: pInd + T -1,:);
    newY = Labels{bestAction(period,:)}(pInd : pInd + T -1);
    previousFeats = previousFeatures{bestAction(period,:)};
    prevLabs = previousLabels{bestAction(period,:)};
   [~,predictedLabels(pInd: pInd + T -1)] = computeKnnClassificationAcc2(newX,newY,previousFeats,prevLabs,knnk); 
  end
  trueLabels(pInd: pInd + T -1) = newY;
  QTimeSer{period} = Q;
  bestAccTs(period) =  actionAccTs(bestState(period,:),bestAction(period,:));
  
  for f = 1:numberOfFeatures
    previousFeatures{f} = Features{f}(currentInd: currentInd + T -1,:);
    previousLabels{f} = Labels{f}(currentInd: currentInd + T -1);
  end
    currentInd = currentInd + T;
  pInd = pInd + T;
end
save([cd '/../results/QL_KNN2version_dataSetA.mat']);