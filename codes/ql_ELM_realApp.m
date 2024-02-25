%% initialization
clear;
clc;
close all;
%% Q-Learning parameters
rng(1);
gamma = 0.8;
alpha = 0.33;
oldQTableWeight = 0.1;
%% input parameters
numberOfTraining = 150;
%% loading data
load([cd '/../data/expandedDatasetCLBP']);
load([cd '/../data/expandedDatasetGabor']);
load([cd '/../data/expandedDatasetLBP']);
load([cd '/../data/expandedDatasetHaar']);
Features{1} = expandedDatasetCLBP(:,1:end-1);
Features{1} = normalize(Features{1});
Labels{1} = expandedDatasetCLBP(:,end);
trainingData{1} = Features{1}(1:numberOfTraining,:);
testingData{1} = Features{1}(numberOfTraining+1:end,:);
trainingLabels{1} = Labels{1}(1:numberOfTraining);
testingLabels{1} = Labels{1}(numberOfTraining+1:end);
% this 15 number only for datasetA,...
% because we need to train on only N,R,and T data
Features{2} = expandedDatasetGabor(:,1:end-1);
Features{2} = normalize(Features{2});
Labels{2} = expandedDatasetGabor(:,end);
trainingData{2} = Features{2}(1:numberOfTraining,:);
testingData{2} = Features{2}(numberOfTraining+1:end,:);
trainingLabels{2} = Labels{2}(1:numberOfTraining);
testingLabels{2} = Labels{2}(numberOfTraining+1:end);
%
Features{3} = expandedDatasetLBP(:,1:end-1);
Features{3} = normalize(Features{3});
Labels{3} = expandedDatasetLBP(:,end);
trainingData{3} = Features{3}(1:numberOfTraining,:);
testingData{3} = Features{3}(numberOfTraining+1:end,:);
trainingLabels{3} = Labels{3}(1:numberOfTraining);
testingLabels{3} = Labels{3}(numberOfTraining+1:end);
%
Features{4} = expandedDatasetHaar(:,1:end-1);
Features{4} = normalize(Features{4});
Labels{4} = expandedDatasetHaar(:,end);
trainingData{4} = Features{4}(1:numberOfTraining,:);
testingData{4} = Features{4}(numberOfTraining+1:end,:);
trainingLabels{4} = Labels{4}(1:numberOfTraining);
testingLabels{4} = Labels{4}(numberOfTraining+1:end);
%% Feature Selection parameters
maxAcc = -100;
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
% numberOfPeriods=1;
%% OSELM parameters
for f = 1:numberOfFeatures
numberOfHiddenNeurons(f) = size(Features{f},2);
end
activationFunctionType = 'sig';
forgettingFactor = 1;
numberOfClasses = length(unique(Labels{1}));
%% continue with q-learning
for f = 1:numberOfFeatures
        chunkFeatures = trainingData{f};
        chunkLabels = trainingLabels{f};
        [Learner{f}] = buildOSELMLearner2(chunkFeatures,chunkLabels,...
            activationFunctionType,numberOfClasses);    
end
T = 50;
pInd= 1;
numberOfChunks = round(length(testingLabels{2})/T);
for chunk = 1:numberOfChunks
 counter2 = 1;
 maxAcc = -100;
        %%%%%%%%%%%%%%%%%%%%%%%%
    % updating R and Q matrices
    for s = 1:numberOfStates
        % compting the accuracy of the current state
        currState = states(s,:);
        chunkFeatures = testingData{s}(currentInd:currentInd+T-1,:);
        chunkLabels = testingLabels{s}(currentInd:currentInd+T-1);
        x = chunkFeatures;
        y = chunkLabels;
        %%%%%%%chunkFeatures%%%%%%%%%%%%%%%%%
        stateAcc = findStateTestAcc2(Learner{s},x,y,activationFunctionType);
       maxAcc(maxAcc<stateAcc) = stateAcc;
        for a = 1:numberOfActions
            progress = counter/(numberOfStates*numberOfActions*numberOfChunks);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
            currAction = actions(a,:);
            %%%
            chunkFeatures = testingData{a}(currentInd:currentInd+T-1,:);
        chunkLabels = testingLabels{a}(currentInd:currentInd+T-1);
            % computing accuracy of the current action
            x = chunkFeatures;
            y = chunkLabels;
            [actionAcc ] = findStateTestAcc2(Learner{a},x,y,activationFunctionType);
            maxAcc(maxAcc<actionAcc) = actionAcc;
            actionAccTs(s,a) = actionAcc;
            % reward
            R(s,a) = actionAcc -stateAcc  ;
            v = 1:length(Q); % just temporal variable
            % updating Q value
            Q(s, a) = oldQTableWeight * Q(s, a) + (1-oldQTableWeight) * ...
                (alpha * (R(s,a) + gamma *....
                max(Q(s, v~=s)) - Q(s, a)));
            counter = counter+1;
            counter2 = counter2+1;
        end
    end
    maxAc(chunk) = maxAcc;
   QTimeSer{chunk} = Q;
  Acc(chunk) = max(max(Q));
  [tmpMax,i] = max(Q);
  [tmpMax,j] = max(tmpMax);
  bestState(chunk,:) = states(i(1),:);
  bestAction(chunk,:) = actions(j(1),:);
  bestAccTs(chunk) =  actionAccTs(bestState(chunk,:),bestAction(chunk,:));
  newX = testingData{bestAction(chunk,:)}(pInd:pInd+size(x,1)-1,:);
  newY = testingLabels{bestAction(chunk,:)}(pInd:pInd+size(newX,1)-1,:);
  [~,predictedLabels(pInd:pInd+size(newX,1)-1,:)] = findStateTestAcc2(Learner{bestAction(chunk,:)},newX,newY,activationFunctionType);
  trueLabels(pInd:pInd+size(newX,1)-1,:) = testingLabels{bestAction(chunk,:)}(pInd:pInd+size(newX,1)-1);
  pInd = pInd + size(newX,1);
currentInd = currentInd + T;
end 
save([cd '/../results/QL_ELM_dataSetA.mat']);