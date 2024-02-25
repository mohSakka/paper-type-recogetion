%% initialization
clear;
clc;
close all;
%% Q-Learning parameters
gamma = 0.8;
alpha = 0.33;
oldQTableWeight = 0.25;
%% loading data
load([cd '/../data/syntheticData']);
% normalize the data
Features = normalize(Features);
%% Feature Selection parameters
reductionRatio = 0.5; % reduction ratio
currentInd = 1;
numberOfFeatures = size(Features,2);
k = round(reductionRatio * numberOfFeatures); % number of the selected features
numberOfActions = nchoosek(numberOfFeatures,k); % number of actions
numberOfStates = numberOfActions; % number of states
actions = combnk(1:numberOfFeatures,k); % all possible actions
states = actions; % all possible states
R = zeros(numberOfActions); % R matrix (state matrix)
Q = zeros(numberOfActions); % Q table
counter = 0;
% numberOfPeriods=1;
%% OSELM parameters
testingRatio = 0.33; % testing data ratio of the
numberOfHiddenNeurons = k; % same as number of features (you musn't modify this line)
activationFunctionType = 'sig';
forgettingFactor = 1;
numberOfClasses = length(unique(Labels));
%% continue with q-learning
counter2 = 1;
for period = 1:numberOfPeriods
    chunkFeatures = Features(currentInd: currentInd + T -1,:);
    chunkLabels = Labels(currentInd: currentInd + T -1);
                if currentInd == 1
        initData.Input = chunkFeatures;
        initData.Targrt = chunkLabels;
        [Learner] = buildOSELMLearner(initData,numberOfFeatures,chunkFeatures,chunkLabels,testingRatio,...
            activationFunctionType,numberOfClasses);
                    else
        [Learner] = updateOSELMLearner(Learner,chunkFeatures,chunkLabels,testingRatio,...
            numberOfHiddenNeurons,activationFunctionType,forgettingFactor,...
            numberOfClasses);
                    end
        %%%%%%%%%%%%%%%%%%%%%%%%
    % updating R and Q matrices
    for s = 1:numberOfStates
        % compting the accuracy of the current state
        currState = states(s,:);
        x = chunkFeatures(:,currState);
        y = chunkLabels;
        %%%%%%%chunkFeatures%%%%%%%%%%%%%%%%%
        stateAcc = findStateTestAcc(Learner,x,y,currState,testingRatio,activationFunctionType);
        for a = 1:numberOfActions
            progress = counter/(numberOfStates*numberOfActions*numberOfPeriods);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
            currAction = actions(a,:);
            % computing accuracy of the current action
            x = chunkFeatures(:,currAction);
            actionAcc = findStateTestAcc(Learner,x,y,currAction,testingRatio,activationFunctionType);
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
    Acc(period) = max(max(Q));
    [tmpMax,i] = max(Q);
    [tmpMax,j] = max(tmpMax);
    bestState(period,:) = states(i(1),:);
    bestAction(period,:) = actions(j(1),:);
    currentInd = currentInd + T;
end
% save('QL_KNN_secondVersion');