function [testAcc,labelIndexActualTest] = findStateTestAcc2(Learner,x,y,activationFunctionType)
testData.Input = x';
testData.Target = y';
%% find Testing Accuracy 
W_in = Learner.W_in;
biasOfHiddenNeurons = Learner.biasOfHiddenNeurons;
tempH_test = W_in*testData.Input;
biasMatrix = repmat(biasOfHiddenNeurons,1,size(testData.Input,2));   % Extend the bias matrix to match the demention of H
tempH_test = tempH_test+biasMatrix;
H_test = ActivationFunction(tempH_test,activationFunctionType);
% Calculate the actual output of testing data
ActualOutputOfTestData = Learner.beta*H_test;
[~,labelIndexActualTest] = max(ActualOutputOfTestData);
% computing the accuracy
% tmp = testData.Target  == labelIndexActualTest;
labelIndexActualTest = labelIndexActualTest';
% tmp = length(find(tmp==1));
% testAcc = tmp/length(testData.Target);
testAcc = findRealAcc(length(unique(testData.Target)),testData.Target,labelIndexActualTest);
end