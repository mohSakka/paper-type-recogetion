%% initialization
rng(1);
clear;
clc;
close all;
%% Q-Learning parameters
gamma = 0.8;
alpha = 0.33;
oldQTableWeight = 0.1;
%% input parameters
numberOfChunks = 9;
chunkLength = 50;
T = chunkLength;
TrainingRatio = 0.5;
%% loading data
load([cd '/../data/expandedDatasetCLBP_B']);
load([cd '/../data/expandedDatasetGabor_B']);
load([cd '/../data/expandedDatasetLBP_B']);
load([cd '/../data/expandedDatasetHaar_B']);
%
Features{1} = expandedDatasetCLBP(:,1:end-1);
Features{1} = normalize(Features{1});
Labels{1} = expandedDatasetCLBP(:,end);
%
Features{2} = expandedDatasetGabor(:,1:end-1);
Features{2} = normalize(Features{2});
Labels{2} = expandedDatasetGabor(:,end);
%
Features{3} = expandedDatasetLBP(:,1:end-1);
Features{3} = normalize(Features{3});
Labels{3} = expandedDatasetLBP(:,end);
%
Features{4} = expandedDatasetHaar(:,1:end-1);
Features{4} = normalize(Features{4});
Labels{4} = expandedDatasetHaar(:,end);
%% Feature Selection parameters
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
forgettingFactor = 0.1;
numberOfClasses = length(unique(Labels{1}));
%% continue with q-learning
counter2 = 1;
pInd = 1;
for chunk = 1:numberOfChunks
    for f = 1:numberOfFeatures
        chunkFeatures = Features{f}(currentInd: currentInd + T -1,:);
        chunkLabels = Labels{f}(currentInd: currentInd + T -1);
        Fn = size(chunkFeatures,2);
        if currentInd == 1
            initData.Input = chunkFeatures;
            initData.Targrt = chunkLabels;
            [Learner{f}] = buildOSELMLearner(initData,Fn,chunkFeatures,chunkLabels,0.25,...
                activationFunctionType,numberOfClasses);
        else
            % no thing
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % updating R and Q matrices
    for s = 1:numberOfStates
        chunkFeatures = Features{s}(currentInd: currentInd + T -1,:);
        chunkLabels = Labels{s}(currentInd: currentInd + T -1);
        Fn = size(chunkFeatures,2);
        % compting the accuracy of the current state
        currState = states(s,:);
        x = chunkFeatures;
        y = chunkLabels;
        %%%%%%%chunkFeatures%%%%%%%%%%%%%%%%%
        stateAcc = findStateTestAcc2(Learner{s},x,y,activationFunctionType);
        for a = 1:numberOfActions
            progress = counter/(numberOfStates*numberOfActions*numberOfChunks);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
            currAction = actions(a,:);
            chunkFeatures = Features{a}(currentInd: currentInd + T -1,:);
            chunkLabels = Labels{a}(currentInd: currentInd + T -1);
            
            x = chunkFeatures;
            y = chunkLabels;
            
            Fn = size(chunkFeatures,2);
            % computing accuracy of the current action
            actionAcc = findStateTestAcc2(Learner{a},x,y,activationFunctionType);
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
    QTimeSer{chunk} = Q;
    Acc(chunk) = max(max(Q));
    [tmpMax,i] = max(Q);
    [tmpMax,j] = max(tmpMax);
    bestState(chunk,:) = states(i(1),:);
    bestAction(chunk,:) = actions(j(1),:);
    bestAccTs(chunk) =  actionAccTs(bestState(chunk,:),bestAction(chunk,:));
    newX = Features{bestAction(chunk,:)}(currentInd: currentInd + T -1,:,:);
    newY = Labels{bestAction(chunk,:)}(currentInd: currentInd + T -1);
    [~,predictedLabels(pInd:pInd+size(newX,1)-1,:)] = findStateTestAcc2(Learner{bestAction(chunk,:)},newX,newY,activationFunctionType);
    trueLabels(pInd:pInd+size(newX,1)-1,:) = newY;
    %%%%%%%%%%%%% updating the learners
    for f = 1:numberOfFeatures
        chunkFeatures = Features{f}(currentInd: currentInd + T -1,:);
        chunkLabels = Labels{f}(currentInd: currentInd + T -1);
        Fn = size(chunkFeatures,2);
        if currentInd == 1
            % no thing
        else
            [Learner{f}] = updateOSELMLearner(Learner{f},chunkFeatures,chunkLabels,0.25,...
                numberOfHiddenNeurons(f),activationFunctionType,forgettingFactor,...
                numberOfClasses);
        end
    end
    %%%%%%%%%%%%%%%
    currentInd = currentInd + T;
    pInd = pInd + length(newY);
end
save([cd '/../results/QL_OSELM2version_dataSetB.mat']);