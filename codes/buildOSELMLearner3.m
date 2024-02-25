function [Learner,testAcc] = buildOSELMLearner3(initData,numberOfFeatures,x,y,testingRatio,...
    activationFunctionType,numberOfClasses)
%% splitting the chunk
numOfTestingData = round(size(x,1)*testingRatio);
numberOfTrainingData = size(x,1) ;%- numOfTestingData;
trainData.Input = x';%x(1:numberOfTrainingData,:)';
% testData.Input = x(numberOfTrainingData+1:end,:)';
trainData.Target = y';%(1:numberOfTrainingData)';
% testData.Target = y(numberOfTrainingData+1:end)';
initData.Input = x';%initData.Input(1:numberOfTrainingData,:)';
%% Processing the targets of training dataset in the case of CLASSIFICATION
tempTrain = zeros(numberOfClasses,numberOfTrainingData);
ind = sub2ind(size(tempTrain),trainData.Target,1:numberOfTrainingData);
tempTrain(ind) = 1;
trainData.ProcessedTarget = tempTrain*2-1;
%% create the learner
Learner.W_in = rand(3,numberOfFeatures)*2-1;
Learner.biasOfHiddenNeurons = rand(3,1);
tempH_train = Learner.W_in*initData.Input;
biasMatrix = repmat(Learner.biasOfHiddenNeurons,1,numberOfTrainingData); % Extend the bias matrix to match the demention of H
tempH_train = tempH_train+biasMatrix;
H_train = ActivationFunction(tempH_train,activationFunctionType);
% Initialize M0 and beta0
Learner.M = pinv(H_train*H_train');
Learner.beta = trainData.ProcessedTarget*pinv(H_train);
end
