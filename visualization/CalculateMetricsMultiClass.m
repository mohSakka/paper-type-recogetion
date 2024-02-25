function [confusionMatrix,tableOfConfusion,TP,FN,FP,TN,accuracy,precision,recall,specificity,NPV,f_Measure,g_Mean,overall] = ...
    CalculateMetricsMultiClass(numberOfClasses,targets,outputs)

% This function calculates metrics for classification
% Input: - numberOfClasses: number of classes
%        - targets: targets of classification
%        - outputs: outputs of classification
% Output: - confusionMatrix: confusion matrix
%         - tableOfConfusion: table of confusion
%         - TP: True Positive, FN: False Negative, FP: False Positive, TN: True Negative
%         - accuracy, precision, recall, specificity, NPV, f_Measure, g_Mean
%         - overall: TP, FN, FP, TN, accuracy, precision, recall, specificity, NPV, f_Measure, g_Mean classes

% Initializing variables
confusionMatrix = zeros(numberOfClasses);          % Confusion Matrix
tableOfConfusion = zeros(2,2,numberOfClasses);     % Table Of Confusion
accuracy = zeros(1,numberOfClasses);               % Accuracy
precision = zeros(1,numberOfClasses);              % Precision
recall = zeros(1,numberOfClasses);                 % Recall
specificity = zeros(1,numberOfClasses);            % Specificity
NPV = zeros(1,numberOfClasses);                    % Negative predictive value
f_Measure = zeros(1,numberOfClasses);              % F1 score or F measure
g_Mean = zeros(1,numberOfClasses);                 % G measure or G mean
TP = zeros(1,numberOfClasses);                     % True Positive
FN = zeros(1,numberOfClasses);                     % False Negative
FP = zeros(1,numberOfClasses);                     % False Positive
TN = zeros(1,numberOfClasses);                     % True Negative
W = zeros(1,numberOfClasses);                      % Weights vector

% Compute metrics for each class
for i = 1:numberOfClasses
    T = targets(targets==i);
    O = outputs(targets==i);
    Oprime = outputs(targets~=i);
    
    W(i) = length(T)/length(targets);
    
    % Constitute confusion matrix
    for j = 1:numberOfClasses
%         confusionMatrix(i,j) = (length(find(O==j)))/(length(T));
        confusionMatrix(i,j) = (length(find(O==j)));
    end
    
    % Constitute table of confusion
    tableOfConfusion(1,1,i) = length(find(O==i));        % True Positive
    tableOfConfusion(2,1,i) = length(find(O~=i));        % False Negative
    tableOfConfusion(1,2,i) = length(find(Oprime==i));   % False Positive
    tableOfConfusion(2,2,i) = length(find(Oprime~=i));   % True Negative
    
    % Use shortcuts for easy work
    TP(i) = tableOfConfusion(1,1,i);
    FN(i) = tableOfConfusion(2,1,i);
    FP(i) = tableOfConfusion(1,2,i);
    TN(i) = tableOfConfusion(2,2,i);
    
    % Compute accuracy
    accuracy(i) = (TP(i)+TN(i))/(TP(i)+FN(i)+FP(i)+TN(i));
    
    % Compute precision or positive predictive value  (PPV)
    if(TP(i)==0)   %if TP =0 ,FP = 0 ,FN = 0 that mean there is no records belongs to this class in the data provided
        if(FP(i)==0 && FN(i)==0)
            precision(i)=1;
            recall(i)=1;
        else
            precision(i)=0;
            recall(i)=0;
        end
    else
    precision(i) = TP(i)/(TP(i)+FP(i));
    
    % Compute sensitivity, recall or True Positive rate (TPR)
    recall(i) = TP(i)/(TP(i)+FN(i));
    end
    % Specificity or true negative rate (TNR)
    specificity(i) = TN(i)/(TN(i)+FP(i));
    
    % Negative predictive value (NPV)
    NPV(i) = TN(i)/(TN(i)+FN(i));
    
    % F_measure or F_score is the harmonic mean of recall and precision
    f_Measure(i) = (2*precision(i)*recall(i))/(precision(i)+recall(i));
    
    % G_measure or G_mean is the geometric mean of recall and precision

    
    g_Mean(i) = sqrt(precision(i)*recall(i));
end

% Compute overall metrics for all classes
overall.accuracyMicro = sum(TP+TN)/sum(TP+FN+FP+TN);
overall.accuracyMacro = mean(accuracy);
overall.weightedAccuracy = sum(W.*accuracy);
overall.precision = sum(W.*precision);
overall.recall = sum(W.*recall);
overall.specificity = sum(W.*specificity);
overall.NPV = sum(W.*NPV);
overall.f_Measure = (2*overall.precision*overall.recall)/(overall.precision+overall.recall);
overall.g_Mean = sqrt(overall.precision*overall.recall);
end