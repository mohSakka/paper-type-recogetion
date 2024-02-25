Input:
discountFactor 
learningRate
oldQTableWeight
dataset % sequential dataset
chunkLength % all chunk records have the same texture type
numberOfFeatures 
Output:
bestFeature % as timeseries for each chunk
accTimeSer % accuracy time series
start:
% building ELM Learner using the  N,R,and T data for each type of features
trainingData = N ,R and T data
for f = 1:numberOfFeatures
	Learner{f} = buildElmLearner(trainingData)
end
% performing Q-Learning
testingData = the rest dataset
[Features Labels] = decomposeDataset(testingData)
numberOfStates = numberOfFeaturesTypes
numberOfActions = numberOfFeaturesTypes
Q = zeros(numberOfActions) % Q-Table
numberOfChunks = length(dataset)/chunkLength

for i = 1:numberOfChunks
	chunk = getChunk(dataset,i,chunkLength)
	for s = 1:numberOfStates
		% apply Knn predection algorithm on this chunk based on Features{s}
		stateAcc = findTestingAcc(Learner{s},chunkFeatures{s},chunkLabels)
		for a = 1:numberOfActions
			% apply Knn predection algorithm on this chunk based on Features{a}
			actionAcc = findTestingAcc(Learner{a},chunkFeatures{a},chunkLabels)
			reward = actionAcc - stateAcc
			Q(s, a) = oldQTableWeight * Q(s, a) + (1-oldQTableWeight) * ...
			(learningRate * (reward + discountFactor * max(Q(s,otherStates)) - Q(s, a)))
		end
	end
	bestFeature in this chunk = max(max(Q))
	accTimeSer(i) = accuracy of bestFeatures
end
end
%%%%%%%%%%
% for findTestingAcc we just apply ELM predection procedure1