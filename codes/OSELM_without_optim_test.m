function [trainingError,validationError,testingError] = OSELM_without_optim_test(trainingData,testingData,validationData, ...
    ElmType,numberOfHiddenNeurons,activationFunctionType,numberOfInitTrainData,blockSize,forgettingFactor,numberOfClasses)
 
% Input:
%-------
% trainingData            - Training dataset
% testingData             - Testing dataset
% ElmType                 - 0 for regression
%                         - 1 for (both binary and multi-classes) classification
% numberOfHiddenNeurons   - Number of hidden neurons assigned to the OSELM
% activationFunctionType  - Type of activation function:
%                               'rbf' for radial basis function, G(a,b,x) = exp(-b||x-a||^2)
%                               'sig' for sigmoidal function, G(a,b,x) = 1/(1+exp(-(ax+b)))
%                               'sin' for sine function, G(a,b,x) = sin(ax+b)
%                               'hardlim' for hardlim function, G(a,b,x) = hardlim(ax+b)
% numberOfInitTrainData   - Number of initial training data used in the initial phase of OSLEM
%                           (which is not less than the number of hidden neurons)
% blockSize               - Size of block of data learned by OSELM in each step
% forgettingFactor        - Forgetting Factor
% numberOfClasses         - Number of required classes to which the data will be classified
%--------------------------------------------------------------------------------------------------
% Output:
%--------
% trainingTime            - Time (seconds) spent on training OSELM
% testingTime             - Time (seconds) spent on predicting all testing data
% train                   - Structure contains the class-label column
%                           (targets) and the actual output of classifier
%                           (outputs) for training dataset
% test                    - Structure contains the class-label column
%                           (targets) and the actual output of classifier
%                           (outputs) for testing dataset
%--------------------------------------------------------------------------------------------------
% MULTI-CLASSE CLASSIFICATION: NUMBER OF OUTPUT NEURONS WILL BE AUTOMATICALLY SET EQUAL TO NUMBER OF CLASSES
% FOR EXAMPLE, if there are 7 classes in all, there will have 7 output neurons
% (for example, if neuron 5 has the highest output means input belongs to 5-th class)
%--------------------------------------------------------------------------------------------------

%% Macro definition

REGRESSION = 0;
CLASSIFICATION = 1;

%% Preparing datasets

% Training dataset
trainData.Target = trainingData(:,end)';
trainData.Input = trainingData(:,1:end-2)';

% Testing dataset
testData.Target = testingData(:,end)';
testData.Input = testingData(:,1:end-2)';
% Validation dataset
valData.Target= validationData(:,end)';
valData.Input= validationData(:,1:end-2)';

numberOfTrainingData = size(trainData.Input,2);
numberOfValidationData= size(valData.Input,2);
numberOfTestingData = size(testData.Input,2);
numberOfInputNeurons = size(trainData.Input,1);

uniq=unique(trainData.Target);
for i=1:length(uniq)
trainData.Target(trainData.Target==uniq(i))=i;
end

%% Processing the targets of training dataset in the case of CLASSIFICATION

if ElmType==CLASSIFICATION
    tempTrain = zeros(numberOfClasses,numberOfTrainingData);
    ind = sub2ind(size(tempTrain),trainData.Target,1:numberOfTrainingData);
    tempTrain(ind) = 1;
    trainData.ProcessedTarget = tempTrain*2-1;
end

%% Step 1 Initialization Phase (Boosting Phase)
startTimeTrain = cputime;
% Random generating of the input weight matrix and the biases of hidden neurons
W_in = rand(numberOfHiddenNeurons,numberOfInputNeurons)*2-1;
% W_in=[0	0.151367762525609	-0.105531988895741	0	0.101239198379468	0	0	-0.0308574895248652	0	-0.214543434260912	-0.166082347647108	0	0	-100	-100	-100	-100	-100	-100	-100	-100	-100	-100	-100	-100	-100];
% W_in=parent_pop(index,numberOfHiddenNeurons+2:numberOfHiddenNeurons+1+numberOfHiddenNeurons*numberOfInputNeurons);
% W_in=reshape(W_in,numberOfHiddenNeurons,numberOfInputNeurons);
% size(W_in);
% biasOfHiddenNeurons=parent_pop(index,2:numberOfHiddenNeurons+1)';
biasOfHiddenNeurons = rand(numberOfHiddenNeurons,1);
% biasOfHiddenNeurons=[0.682472156794414	0.0351556407948950	0.506432176538200	0.928267096637659	0.569658016741742	0.756659849551746	0.0209291451043211	0.318713516071968	0.868749922138476	0.460221695288322	0.197159402252456	0.694100226889361	0.867666300345956	0.394439108899593	0.00425804800505980	0.359899257282001	0.914630892934277	0.934642479901962	0.936581990019032	0.199160023787874	0.334466429268005	0.447753286178060	0.0402721710035503	0.701924362242686	0.0769213492964490	0.619543495854871	0.604749746596246	0.450161893538217	0.683656667826289	0.607589527050732]';
% Take initial training dataset from the training Data
initTrainData.Input = trainData.Input(:,1:numberOfInitTrainData);
if ElmType==CLASSIFICATION
    initTrainData.Target = trainData.ProcessedTarget(:,1:numberOfInitTrainData);
elseif ElmType==REGRESSION
    initTrainData.Target = trainData.Target(:,1:numberOfInitTrainData);
end

% Calculate the initial Hidden Layer Output Matrix (H0) For the inititial training dataset
tempH0_train = W_in*initTrainData.Input;
biasMatrix0 = repmat(biasOfHiddenNeurons,1,numberOfInitTrainData); % Extend the bias matrix to match the demention of H
tempH0_train = tempH0_train+biasMatrix0;
H0_train = ActivationFunction(tempH0_train,activationFunctionType);

% Initialize M0 and beta0
M = pinv(H0_train*H0_train');
beta = initTrainData.Target*pinv(H0_train);

%% Step 2 Sequential Learning Phase

% For each further left data
counter = 0;
nextIndex = numberOfInitTrainData+1;
while nextIndex<numberOfTrainingData
    if nextIndex+blockSize-1>numberOfTrainingData
        nTrainData.Input = trainData.Input(:,nextIndex:numberOfTrainingData);
        if ElmType==CLASSIFICATION
            nTrainData.Target = trainData.ProcessedTarget(:,nextIndex:numberOfTrainingData);
        elseif ElmType==REGRESSION
            nTrainData.Target = trainData.Target(:,nextIndex:numberOfTrainingData);
        end
        blockSize = size(nTrainData.Input,2);  % Correct the block size
    else
        nTrainData.Input = trainData.Input(:,nextIndex:nextIndex+blockSize-1);
        if ElmType==CLASSIFICATION
            nTrainData.Target = trainData.ProcessedTarget(:,nextIndex:nextIndex+blockSize-1);
        elseif ElmType==REGRESSION
            nTrainData.Target = trainData.Target(:,nextIndex:nextIndex+blockSize-1);
        end
    end
    
    counter = counter+1;
    
    % Update nextIndex value
    nextIndex = nextIndex+blockSize;

    % Calculate the Hidden Layer Output Matrix (H) For the training dataset n
    tempH_train = W_in*nTrainData.Input;
    biasMatrix = repmat(biasOfHiddenNeurons,1,blockSize);
    tempH_train = tempH_train+biasMatrix;
    H_train = ActivationFunction(tempH_train,activationFunctionType);
    
    % Calculate latest output weights (beta) based on RLS algorithm
    M = (M-M*H_train*(forgettingFactor*eye(blockSize)+H_train'*M*H_train)^(-1)*H_train'*M)/forgettingFactor;
    beta = beta+(M*H_train*(nTrainData.Target'-H_train'*beta'))';
    
    clear tempH_train H_train;
end

endTimeTrain = cputime;
trainingTime = endTimeTrain-startTimeTrain;

disp(['Number of training blocks: ' num2str(counter)]);

% Calculate the Hidden Layer Output Matrix (H) For the total training dataset
tempH_train = W_in*trainData.Input;
biasMatrix = repmat(biasOfHiddenNeurons,1,size(trainData.Input,2));
tempH_train = tempH_train+biasMatrix;
H_train = ActivationFunction(tempH_train,activationFunctionType);

% Calculate the actual output of training data
ActualOutputOfTrainData = beta*H_train;

%% Performance Evaluation

startTimeTest = cputime;

% Calculate the Hidden Layer Output Matrix (H) For testing dataset
tempH_test = W_in*testData.Input;
biasMatrix = repmat(biasOfHiddenNeurons,1,size(testData.Input,2));   % Extend the bias matrix to match the demention of H
tempH_test = tempH_test+biasMatrix;
H_test = ActivationFunction(tempH_test,activationFunctionType);

% Calculate the actual output of testing data
ActualOutputOfTestData = beta*H_test;
endTimeTest = cputime;
testingTime = endTimeTest-startTimeTest;

startTimeVal = cputime;
% Calculate the Hidden Layer Output Matrix (H) For validation dataset
tempH_val = W_in*valData.Input;
biasMatrix = repmat(biasOfHiddenNeurons,1,size(valData.Input,2)); % Extend the bias matrix to match the demention of H
tempH_val = tempH_val+biasMatrix;
H_val = ActivationFunction(tempH_val,activationFunctionType);

% Calculate the actual output of validation data
ActualOutputOfValData = beta*H_val;
endTimeTest = cputime;
validationTime = endTimeTest-startTimeVal;

%% Outputs and Targets

train.targets = trainData.Target;
test.targets = testData.Target;
val.targets= valData.Target;
if ElmType==CLASSIFICATION
    [~,labelIndexActualTrain] = max(ActualOutputOfTrainData);
    train.outputs = labelIndexActualTrain;
    [~,labelIndexActualTest] = max(ActualOutputOfTestData);
    test.outputs = labelIndexActualTest;
    [~,labelIndexActualVal] = max(ActualOutputOfValData);
    val.outputs = labelIndexActualVal;
elseif ElmType==REGRESSION
    train.outputs = ActualOutputOfTrainData;
    test.outputs = ActualOutputOfTestData;
end
trainingError= (1/length(train.targets))*sum((train.targets-train.outputs).^2);
validationError= (1/length(val.targets))*sum((val.targets-val.outputs).^2);
testingError= (1/length(test.targets))*sum((test.targets-test.outputs).^2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function H = ActivationFunction(H_temp,activationFunctionType)

switch lower(activationFunctionType)
    case {'sig','sigmoid'} % Sigmoid 
        H = 1./(1 + exp(-H_temp));
    case {'sin','sine'} % Sine
        H = sin(H_temp);    
    case {'hardlim'}  % Hard Limit
        H = double(hardlim(H_temp));
    case {'tribas'}  % Triangular basis function
        H = tribas(H_temp);
    case {'radbas'}  % Radial basis function
        H = radbas(H_temp); 
end

end