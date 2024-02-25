for i=1:10
cont(i) = sum(ismember(subsets{i},bestAction(i,:)))/length(subsets{i})
end