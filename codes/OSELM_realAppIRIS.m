%% initialization
rng(1);
clear;
clc;
close all;
%% input parameters
numberOfChunks = 15;
chunkLength = 10;
T = chunkLength;
TrainingRatio = 0.5;
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
%% Feature Selection parameters
currentInd = 1;
numberOfFeatures = 4;
k = 1; % number of the selected features
numberOfStates = 4; % number of states
states = combnk(1:numberOfFeatures,k); % all possible actions
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
    numberOfTrain = round(TrainingRatio*size(chunkFeatures,1));
    trainFeatures = chunkFeatures(1:numberOfTrain,:);
    trainLabels = chunkLabels(1:numberOfTrain);
    Fn = size(chunkFeatures,2);
                if currentInd == 1
        initData.Input = trainFeatures;
        initData.Targrt = trainLabels;
        [Learner{f}] = buildOSELMLearner3(initData,Fn,trainFeatures,trainLabels,0.25,...
            activationFunctionType,numberOfClasses);
                    else
        [Learner{f}] = updateOSELMLearner(Learner{f},trainFeatures,trainLabels,0.25,...
            numberOfHiddenNeurons(f),activationFunctionType,forgettingFactor,...
            numberOfClasses);
                end
    end
    
        %%%%%%%%%%%%%%%%%%%%%%%%
    % updating R and Q matrices
    for s = 1:numberOfStates
        chunkFeatures = Features{s}(currentInd: currentInd + T -1,:);
    chunkLabels = Labels{s}(currentInd: currentInd + T -1);
    numberOfTrain = round(TrainingRatio*size(chunkFeatures,1));
    testFeatures = chunkFeatures(numberOfTrain+1:end,:);
    testLabels = chunkLabels(numberOfTrain+1:end);
    Fn = size(chunkFeatures,2);
        % compting the accuracy of the current state
        currState = states(s,:);
        x = testFeatures;
        y = testLabels;
        %%%%%%%chunkFeatures%%%%%%%%%%%%%%%%%
        [stateAcc(s),predictedLabels(pInd:pInd+length(y)-1,s)] = findStateTestAcc2(Learner{s},x,y,activationFunctionType);
       trueLabels(pInd:pInd+length(y)-1,s) = Labels{s}(currentInd + numberOfTrain : currentInd + T -1);
            progress = counter/(numberOfStates*numberOfChunks);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
   
   
           
            counter = counter+1;
            counter2 = counter2+1;
    end
    
    pInd = pInd + length(y)
    bestAccTs(chunk,:) =  stateAcc;
    currentInd = currentInd + T;
end
save([cd '/../results/OSELM_dataSetIRIS.mat']);