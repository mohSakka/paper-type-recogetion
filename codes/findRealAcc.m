function acc = findRealAcc(numberOfClasses,targets,outputs)
% Compute metrics for each class
for i = 1:numberOfClasses
    T = targets(targets==i);
    O = outputs(targets==i);
    Oprime = outputs(targets~=i);
    
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
end
acc = sum(TP+TN)/sum(TP+TN+FN+FP);