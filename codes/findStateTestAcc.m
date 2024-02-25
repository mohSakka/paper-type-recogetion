function testAcc = findStateTestAcc(Learner,x,y,currentFeatures,testingRatio,activationFunctionType)
%% splitting the chunk
numOfTestingData = round(size(x,1)*testingRatio);
numberOfTrainingData = size(x,1) - numOfTestingData;
testData.Input = x';%x(numberOfTrainingData+1:end,:)';
testData.Target = y';%(numberOfTrainingData+1:end)';
%% find Testing Accuracy 
W_in = Learner.W_in(currentFeatures,currentFeatures);
biasOfHiddenNeurons = Learner.biasOfHiddenNeurons(currentFeatures,:);
tempH_test = W_in*testData.Input;
biasMatrix = repmat(biasOfHiddenNeurons,1,size(testData.Input,2));   % Extend the bias matrix to match the demention of H
tempH_test = tempH_test+biasMatrix;
H_test = ActivationFunction(tempH_test,activationFunctionType);
% Calculate the actual output of testing data
ActualOutputOfTestData = Learner.beta(:,currentFeatures)*H_test;
[~,labelIndexActualTest] = max(ActualOutputOfTestData);
% computing the accuracy
tmp = testData.Target  == labelIndexActualTest;
tmp = length(find(tmp==1));
testAcc = tmp/length(testData.Target);
end