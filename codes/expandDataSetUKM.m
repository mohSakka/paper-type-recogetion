%% initialization 
clear;
clc;
close all;
Res_type = 3;
resolutions = [50 100 150];
%% loading the data
%% loading data
load([cd '/../data/CLBP_dataUKM']);
load([cd '/../data/Gabor_dataUKM']);
load([cd '/../data/LBP_dataUKM']);
load([cd '/../data/Haar_dataUKM']);
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
numberOfChunks = 3;
chunkLength = 100;
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
currInd = 1;
for i = 1:numberOfChunks
    chunk = expandedDatasetHaar(currInd:currInd+chunkLength-1,:);
    chunk = chunk(randperm(end),:); 
    expandedDatasetHaar(currInd:currInd+chunkLength-1,:) = chunk;
    currInd = currInd + chunkLength;
end
%% second expansion level 
%% input parameters
expansionRate = 10;
%% CLBP
expandedDatasetCLBP2 = [];
numberOfCols = size(expandedDatasetCLBP,2)-1;
mn = min(expandedDatasetCLBP(:,1:end-1),[],1);
mx = max(expandedDatasetCLBP(:,1:end-1),[],1);
sigma = (mx-mn)*0.05;
sigma = repmat(sigma,expansionRate-1,1);
expectedValue = zeros(length(sigma),1)';
expectedValue = repmat(expectedValue,expansionRate-1,1); 
for row = 1:size(expandedDatasetCLBP,1)
    thisRow = expandedDatasetCLBP(row,1:end-1);
    thisLabel = expandedDatasetCLBP(row,end);
    whitNoise = normrnd(expectedValue,sigma);
    newRows = repmat(thisRow,expansionRate-1,1) + whitNoise;
    newLabels = repmat(thisLabel,expansionRate-1,1);
    newRows = [newRows newLabels];
    thisRow = [thisRow thisLabel];
    expandedDatasetCLBP2 = [expandedDatasetCLBP2 ; thisRow ; newRows];
end
% data shuffeling per the chunk 
numberOfChunks = 60;
chunkLength = 50;
currInd = 1;
for i = 1:numberOfChunks
    chunk = expandedDatasetCLBP2(currInd:currInd+chunkLength-1,:);
    chunk = chunk(randperm(end),:); 
    expandedDatasetCLBP2(currInd:currInd+chunkLength-1,:) = chunk;
    currInd = currInd + chunkLength;
end
%% Gabor
expandedDatasetGabor2 = [];
numberOfCols = size(expandedDatasetGabor,2)-1;
mn = min(expandedDatasetGabor(:,1:end-1),[],1);
mx = max(expandedDatasetGabor(:,1:end-1),[],1);
sigma = (mx-mn)*0.05;
sigma = repmat(sigma,expansionRate-1,1);
expectedValue = zeros(length(sigma),1)';
expectedValue = repmat(expectedValue,expansionRate-1,1); 
for row = 1:size(expandedDatasetGabor,1)
    thisRow = expandedDatasetGabor(row,1:end-1);
    thisLabel = expandedDatasetGabor(row,end);
    whitNoise = normrnd(expectedValue,sigma);
    newRows = repmat(thisRow,expansionRate-1,1) + whitNoise;
    newLabels = repmat(thisLabel,expansionRate-1,1);
    newRows = [newRows newLabels];
    thisRow = [thisRow thisLabel];
    expandedDatasetGabor2 = [expandedDatasetGabor2 ; thisRow ; newRows];
end
% data shuffeling per the chunk 
currInd = 1;
for i = 1:numberOfChunks
    chunk = expandedDatasetGabor2(currInd:currInd+chunkLength-1,:);
    chunk = chunk(randperm(end),:); 
    expandedDatasetGabor2(currInd:currInd+chunkLength-1,:) = chunk;
    currInd = currInd + chunkLength;
end
%% LBP
expandedDatasetLBP2 = [];
numberOfCols = size(expandedDatasetLBP,2)-1;
mn = min(expandedDatasetLBP(:,1:end-1),[],1);
mx = max(expandedDatasetLBP(:,1:end-1),[],1);
sigma = (mx-mn)*0.05;
sigma = repmat(sigma,expansionRate-1,1);
expectedValue = zeros(length(sigma),1)';
expectedValue = repmat(expectedValue,expansionRate-1,1); 
for row = 1:size(expandedDatasetLBP,1)
    thisRow = expandedDatasetLBP(row,1:end-1);
    thisLabel = expandedDatasetLBP(row,end);
    whitNoise = normrnd(expectedValue,sigma);
    newRows = repmat(thisRow,expansionRate-1,1) + whitNoise;
    newLabels = repmat(thisLabel,expansionRate-1,1);
    newRows = [newRows newLabels];
    thisRow = [thisRow thisLabel];
    expandedDatasetLBP2 = [expandedDatasetLBP2 ; thisRow ; newRows];
end
% data shuffeling per the chunk 
currInd = 1;
for i = 1:numberOfChunks
    chunk = expandedDatasetLBP2(currInd:currInd+chunkLength-1,:);
    chunk = chunk(randperm(end),:); 
    expandedDatasetLBP2(currInd:currInd+chunkLength-1,:) = chunk;
    currInd = currInd + chunkLength;
end
%% Haar
expandedDatasetHaar2 = [];
numberOfCols = size(expandedDatasetHaar,2)-1;
mn = min(expandedDatasetHaar(:,1:end-1),[],1);
mx = max(expandedDatasetHaar(:,1:end-1),[],1);
sigma = (mx-mn)*0.05;
sigma = repmat(sigma,expansionRate-1,1);
expectedValue = zeros(length(sigma),1)';
expectedValue = repmat(expectedValue,expansionRate-1,1); 
for row = 1:size(expandedDatasetHaar,1)
    thisRow = expandedDatasetHaar(row,1:end-1);
    thisLabel = expandedDatasetHaar(row,end);
    whitNoise = normrnd(expectedValue,sigma);
    newRows = repmat(thisRow,expansionRate-1,1) + whitNoise;
    newLabels = repmat(thisLabel,expansionRate-1,1);
    newRows = [newRows newLabels];
    thisRow = [thisRow thisLabel];
    expandedDatasetHaar2 = [expandedDatasetHaar2 ; thisRow ; newRows];
end
% data shuffeling per the chunk 
currInd = 1;
for i = 1:numberOfChunks
    chunk = expandedDatasetHaar2(currInd:currInd+chunkLength-1,:);
    chunk = chunk(randperm(end),:); 
    expandedDatasetHaar2(currInd:currInd+chunkLength-1,:) = chunk;
    currInd = currInd + chunkLength;
end
expandedDatasetLBP = expandedDatasetLBP2;
expandedDatasetCLBP = expandedDatasetCLBP2;
expandedDatasetGabor = expandedDatasetGabor2;
expandedDatasetHaar = expandedDatasetHaar2;
%% saving
savingDir = [cd '/../data/'];
save([savingDir 'expandedDatasetLBP_UKM'],'expandedDatasetLBP');
save([savingDir 'expandedDatasetCLBP_UKM'],'expandedDatasetCLBP');
save([savingDir 'expandedDatasetGabor_UKM'],'expandedDatasetGabor');
save([savingDir 'expandedDatasetHaar_UKM'],'expandedDatasetHaar');
%%