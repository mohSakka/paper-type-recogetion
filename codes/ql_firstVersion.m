%% initialization
clear;
clc;
close all;
%% Q-Learning parameters
gamma = 0.8;
alpha = 0.33;
knnk = 20;
%% loading data
load([cd '/../data/syntheticData']);
%% start
reductionRatio = 0.5; % reduction ratio
currentInd = 1;
numberOfFeatures = size(Features,2);
% initializing R and Q matrices
tmp.reward = 0;
tmp.model = [];
k = round(reductionRatio * numberOfFeatures); % number of the selected features
numberOfActions = nchoosek(numberOfFeatures,k); % number of actions
numberOfStates = numberOfActions; % number of states
actions = combnk(1:numberOfFeatures,k); % all possible actions
states = actions; % all possible states
R = repmat(tmp,numberOfActions,numberOfActions); % R matrix (state matrix)
Q = zeros(numberOfActions); % Q table
counter = 0;
% numberOfPeriods=2;
%% initializing R matrix and the initial classifiers
for period = 1:1
    chunkFeatures = Features(currentInd: currentInd + T -1,:);
    chunkLabels = Labels(currentInd: currentInd + T -1);
    % creating R matrix
    for s = 1:numberOfStates
        for a = 1:numberOfActions
            progress = counter/(numberOfStates*numberOfActions*numberOfPeriods);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
            currState = states(s,:);
            currAction = actions(a,:);
            % compting the accuracy of the current action
            x = chunkFeatures(:,currState);
            y = chunkLabels;
            % computing state accuracy using knn classifier
            state_mdl = fitcknn(x,y);
            % predection
            predictedLabels = predict(state_mdl, x);
            % computing accuracy
            hit = y == predictedLabels;
            numberOfTruePositive = length(find(hit==1));
            stateAcc = numberOfTruePositive/length(hit);
            % compting the accuracy of the current action
            x = chunkFeatures(:,currAction);
            y = chunkLabels;
            % creating state Knn model
            action_mdl = fitcknn(x,y);
            % predection
            predictedLabels = predict(action_mdl, x);
            % computing accuracy
            hit = y == predictedLabels;
            numberOfTruePositive = length(find(hit==1));
            actionAcc = numberOfTruePositive/length(hit);
            R(s,a).reward = actionAcc-stateAcc;
            R(s,a).state_model = state_mdl;
            R(s,a).action_model = action_mdl;
            counter=counter+1;
        end
    end
    currentInd = currentInd + T;
end
%% continue with q-learning
counter2 = 1;
for period = 2:numberOfPeriods
    chunkFeatures = Features(currentInd: currentInd + T -1,:);
    chunkLabels = Labels(currentInd: currentInd + T -1);
    % updating R and Q matrices
    for s = 1:numberOfStates
        % compting the accuracy of the current state
            currState = states(s,:);
            x = chunkFeatures(:,currState);
            y = chunkLabels;
            stateAcc = computeKnnClassificationAcc(x,y,knnk)
        for a = 1:numberOfActions
            progress = counter/(numberOfStates*numberOfActions*numberOfPeriods);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
            currAction = actions(a,:);
            % computing accuracy of the current a
            numberOfTruePositive = length(find(hit==1));
            accuracy(counter2) = numberOfTruePositive/length(hit);
            R(s,a).reward = accuracy(counter2);
            R(s,a).model = mdl;
            v = 1:length(Q); % just temporal variable
            % updating Q value
            Q(s, a) = Q(s, a) + alpha * (R(s,a).reward + gamma *....
                max(Q(s, v~=s)) - Q(s, a)); 
            counter= counter+1;
            counter2 = counter2+1;
        end
    end
    currentInd = currentInd + T;
end