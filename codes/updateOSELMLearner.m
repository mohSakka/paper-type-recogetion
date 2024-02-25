function [Learner] = updateOSELMLearner(Learner,x,y,testingRatio,numberOfHiddenNeurons,...
    activationFunctionType,forgettingFactor,numberOfClasses)
%% splitting the chunk
numOfTestingData = round(size(x,1)*testingRatio);
numberOfTrainingData = size(x,1) ;%- numOfTestingData;
trainData.Input = x';%x(1:numberOfTrainingData,:)';
% testData.Input = x(numberOfTrainingData+1:end,:)';
trainData.Target = y';%y(1:numberOfTrainingData)';
% testData.Target = y(numberOfTrainingData+1:end)';
%% Processing the targets of training dataset in the case of CLASSIFICATION
tempTrain = zeros(numberOfClasses,numberOfTrainingData);
ind = sub2ind(size(tempTrain),trainData.Target,1:numberOfTrainingData);
tempTrain(ind) = 1;
trainData.ProcessedTarget = tempTrain*2-1;
%% start training
W_in = Learner.W_in;
biasOfHiddenNeurons = Learner.biasOfHiddenNeurons;
tempH_train = W_in*trainData.Input;
biasMatrix = repmat(biasOfHiddenNeurons,1,numberOfTrainingData); % Extend the bias matrix to match the demention of H
tempH_train = tempH_train+biasMatrix;
H_train = ActivationFunction(tempH_train,activationFunctionType);
% Calculate latest output weights (beta) based on RLS algorithm
Learner.M = (Learner.M...
    -Learner.M*H_train*(forgettingFactor*...
    eye(numberOfTrainingData)+H_train'*Learner.M*H_train)^(-1)*H_train'*...
    Learner.M)/forgettingFactor;
Learner.beta = Learner.beta+(Learner.M...
    *H_train*(trainData.ProcessedTarget'-H_train'*Learner.beta'))';
end