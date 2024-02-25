for c = 1:10
   ism = ismember(bestAction(c,:),subsets{c});
   L = length(find(ism==1));
   hitt(c) = L/length(subsets{c});
end