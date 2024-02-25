%% initialization
clear;
clc;
close all;
rng(1);
%% input parameters
numberOfTraining = 10;
%% loading data
load([cd '/../data/iris.mat']);
Features{1} = data(:,1);
Labels{1} = data(:,end);
trainingData{1} = Features{1}(1:numberOfTraining,:);
testingData{1} = Features{1}(numberOfTraining+1:end,:);
trainingLabels{1} = Labels{1}(1:numberOfTraining);
testingLabels{1} = Labels{1}(numberOfTraining+1:end);
% this 15 number only for datasetA,...
% because we need to train on only N,R,and T data
Features{2} = data(:,2);
Labels{2} = data(:,end);
trainingData{2} = Features{2}(1:numberOfTraining,:);
testingData{2} = Features{2}(numberOfTraining+1:end,:);
trainingLabels{2} = Labels{2}(1:numberOfTraining);
testingLabels{2} = Labels{2}(numberOfTraining+1:end);
%
Features{3} = data(:,3);
Labels{3} = data(:,end);
trainingData{3} = Features{3}(1:numberOfTraining,:);
testingData{3} = Features{3}(numberOfTraining+1:end,:);
trainingLabels{3} = Labels{3}(1:numberOfTraining);
testingLabels{3} = Labels{3}(numberOfTraining+1:end);
%
Features{4} = data(:,4);
Labels{4} = data(:,end);
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
        [Learner{f}] = buildOSELMLearner3(chunkFeatures,chunkLabels,...
            activationFunctionType,numberOfClasses);    
end
T = 10;
pInd = 1;
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
        [stateAcc(s),predictedLabels(pInd:pInd+length(y)-1,s)] = findStateTestAcc2(Learner{s},x,y,activationFunctionType);
        
    end
    pInd = pInd + length(y);
 Acc(chunk,:) = stateAcc;
 currentInd = currentInd + T;
end
%% saving
save([cd '/../results/ELM_dataSetIRIS.mat']);