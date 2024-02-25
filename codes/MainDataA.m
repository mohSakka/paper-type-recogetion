%% initialization
clear;
clc;
close all;
addpath('document_authentication/Implementation Code_ISSD');
%% Q-Learning parameters
qLearningPars.gamma = 0.8;
qLearningPars.alpha = 0.33;
qLearningPars.oldQTableWeight = 0.25;
%% knn parameters
knnPars.knnk = 20;
%% features extraction parameters 
Data_type = 1; % 1-A, 2-B
% configurations 
% 1- Clbp {Radius,NumNeighbors}
% 2- Gabor {Radius,NumNeighbors,Level,Wavelength,Orintation}
% 3- Haarwavelet {Radius,NumNeighbors,Level}
% 4- Lbp {Radius,NumNeighbors}
configurations = {[2 8],[2 8 3 7 90],[2 8 3],[2 8]};
%% path of the dataset
datasets = 'AB';
ReadingPath = [cd '/document_authentication/Datasets/ISSD - ' datasets(Data_type)];
%% ql_knn features selection
dtatFiles = dir(ReadingPath);
dtatFiles(1:2) = [];
for i = 1:numel(dtatFiles)
    try
    imageMatrix = imread([ReadingPath  '/' dtatFiles(i).name]);
    catch
    imageMatrix = imread([ReadingPath  '\' dtatFiles(i).name]);
    end
    fileId = dtatFiles(i).name(
    currentFeatur = 1;%1-CLBP 2-Gabpor 3-Haar 4-LBP
    for currentFeatur=1:4
    CLBPFeature = customizedExtractClpb(configurations{1},imageMatrix);
         
[Q,R,Acc,bestState,bestAction] = ql_KNN_featureSelection(qLearningPars,...
    knnPars,Data_type,configurations);