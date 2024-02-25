%% initialization 
clear;
clc;
close all;
%% loading the data
%% loading data
load([cd '/../data/CLBP_data']);
load([cd '/../data/Gabor_data']);
load([cd '/../data/LBP_data']);
load([cd '/../data/Haar_data']);
%% input parameters
expansionRate = 10;
%% CLBP
expandedDatasetCLBP = [];
numberOfCols = size(dataSetCLBP,2)-1;
mn = min(dataSetCLBP(:,1:end-1),[],1);
mx = max(dataSetCLBP(:,1:end-1),[],1);
sigma = (mx-mn)*0.05;
sigma = repmat(sigma,expansionRate-1,1);
expectedValue = zeros(length(sigma),1)';
expectedValue = repmat(expectedValue,expansionRate-1,1); 
for row = 1:size(dataSetCLBP,1)
    thisRow = dataSetCLBP(row,1:end-1);
    thisLabel = dataSetCLBP(row,end);
    whitNoise = normrnd(expectedValue,sigma);
    newRows = repmat(thisRow,expansionRate-1,1) + whitNoise;
    newLabels = repmat(thisLabel,expansionRate-1,1);
    newRows = [newRows newLabels];
    thisRow = [thisRow thisLabel];
    expandedDatasetCLBP = [expandedDatasetCLBP ; thisRow ; newRows];
end
% data shuffeling per the chunk 
numberOfChunks = 18;
chunkLength = 50;
currInd = 1;
for i = 1:numberOfChunks
    chunk = expandedDatasetCLBP(currInd:currInd+chunkLength-1,:);
    chunk = chunk(randperm(end),:); 
    expandedDatasetCLBP(currInd:currInd+chunkLength-1,:) = chunk;
    currInd = currInd + chunkLength;
end
%% Gabor
expandedDatasetGabor = [];
numberOfCols = size(dataSetGabor,2)-1;
mn = min(dataSetGabor(:,1:end-1),[],1);
mx = max(dataSetGabor(:,1:end-1),[],1);
sigma = (mx-mn)*0.05;
sigma = repmat(sigma,expansionRate-1,1);
expectedValue = zeros(length(sigma),1)';
expectedValue = repmat(expectedValue,expansionRate-1,1); 
for row = 1:size(dataSetGabor,1)
    thisRow = dataSetGabor(row,1:end-1);
    thisLabel = dataSetGabor(row,end);
    whitNoise = normrnd(expectedValue,sigma);
    newRows = repmat(thisRow,expansionRate-1,1) + whitNoise;
    newLabels = repmat(thisLabel,expansionRate-1,1);
    newRows = [newRows newLabels];
    thisRow = [thisRow thisLabel];
    expandedDatasetGabor = [expandedDatasetGabor ; thisRow ; newRows];
end
% data shuffeling per the chunk 
numberOfChunks = 18;
chunkLength = 50;
currInd = 1;
for i = 1:numberOfChunks
    chunk = expandedDatasetGabor(currInd:currInd+chunkLength-1,:);
    chunk = chunk(randperm(end),:); 
    expandedDatasetGabor(currInd:currInd+chunkLength-1,:) = chunk;
    currInd = currInd + chunkLength;
end
%% LBP
expandedDatasetLBP = [];
numberOfCols = size(dataSetLBP,2)-1;
mn = min(dataSetLBP(:,1:end-1),[],1);
mx = max(dataSetLBP(:,1:end-1),[],1);
sigma = (mx-mn)*0.05;
sigma = repmat(sigma,expansionRate-1,1);
expectedValue = zeros(length(sigma),1)';
expectedValue = repmat(expectedValue,expansionRate-1,1); 
for row = 1:size(dataSetLBP,1)
    thisRow = dataSetLBP(row,1:end-1);
    thisLabel = dataSetLBP(row,end);
    whitNoise = normrnd(expectedValue,sigma);
    newRows = repmat(thisRow,expansionRate-1,1) + whitNoise;
    newLabels = repmat(thisLabel,expansionRate-1,1);
    newRows = [newRows newLabels];
    thisRow = [thisRow thisLabel];
    expandedDatasetLBP = [expandedDatasetLBP ; thisRow ; newRows];
end
% data shuffeling per the chunk 
numberOfChunks = 18;
chunkLength = 50;
currInd = 1;
for i = 1:numberOfChunks
    chunk = expandedDatasetLBP(currInd:currInd+chunkLength-1,:);
    chunk = chunk(randperm(end),:); 
    expandedDatasetLBP(currInd:currInd+chunkLength-1,:) = chunk;
    currInd = currInd + chunkLength;
end
%% Haar
expandedDatasetHaar = [];
numberOfCols = size(dataSetHaarwavelet,2)-1;
mn = min(dataSetHaarwavelet(:,1:end-1),[],1);
mx = max(dataSetHaarwavelet(:,1:end-1),[],1);
sigma = (mx-mn)*0.05;
sigma = repmat(sigma,expansionRate-1,1);
expectedValue = zeros(length(sigma),1)';
expectedValue = repmat(expectedValue,expansionRate-1,1); 
for row = 1:size(dataSetHaarwavelet,1)
    thisRow = dataSetHaarwavelet(row,1:end-1);
    thisLabel = dataSetHaarwavelet(row,end);
    whitNoise = normrnd(expectedValue,sigma);
    newRows = repmat(thisRow,expansionRate-1,1) + whitNoise;
    newLabels = repmat(thisLabel,expansionRate-1,1);
    newRows = [newRows newLabels];
    thisRow = [thisRow thisLabel];
    expandedDatasetHaar = [expandedDatasetHaar ; thisRow ; newRows];
end
% data shuffeling per the chunk 
numberOfChunks = 18;
chunkLength = 50;
currInd = 1;
for i = 1:numberOfChunks
    chunk = expandedDatasetHaar(currInd:currInd+chunkLength-1,:);
    chunk = chunk(randperm(end),:); 
    expandedDatasetHaar(currInd:currInd+chunkLength-1,:) = chunk;
    currInd = currInd + chunkLength;
end
%% saving
savingDir = [cd '/../data/'];
save([savingDir 'expandedDatasetLBP.mat'],'expandedDatasetLBP');
save([savingDir 'expandedDatasetCLBP.mat'],'expandedDatasetCLBP');
save([savingDir 'expandedDatasetGabor.mat'],'expandedDatasetGabor');
save([savingDir 'expandedDatasetHaar.mat'],'expandedDatasetHaar');
%%