%% initialization
rng(1);
clear;
clc;
close all;
%% input parameters
numberOfChunks = 60;
chunkLength = 50;
T = chunkLength;
TrainingRatio = 0.5;
%% loading data
load([cd '/../data/expandedDatasetCLBP_UKM']);
load([cd '/../data/expandedDatasetGabor_UKM']);
load([cd '/../data/expandedDatasetLBP_UKM']);
load([cd '/../data/expandedDatasetHaar_UKM']);
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
        [stateAcc(s),predictedLabels(pInd:pInd+length(y)-1,s)] = findStateTestAcc2(Learner{s},x,y,activationFunctionType);
       trueLabels(pInd:pInd+length(y)-1,s) = Labels{s}(currentInd  : currentInd + T -1);
            progress = counter/(numberOfStates*numberOfChunks);
            clc;
            disp(['progress: ' num2str(progress*100) ' %']);
   
   
           
            counter = counter+1;
            counter2 = counter2+1;
        end
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
   pInd = pInd + length(y)
    bestAccTs(chunk,:) =  stateAcc;
    currentInd = currentInd + T;
end
save([cd '/../results/OSELM2version_dataSet_UKM']);
