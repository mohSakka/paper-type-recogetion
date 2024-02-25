%% initialization
clear;
clc;
close all;
dataSetCLBP = [];
dataSetGabor = [];
dataSetHaarwavelet = [];
dataSetLBP = [];
%%
uniDims = [176 128];
configurations = {[8 4],[30 30],[5 5],[8 4]}; % 
% { CLBP, Gabor, Haar, LBP} = {[radius,numberOfNeighbours],...
% [d1,d2] , [level1, level2], [radius,numberOfNeighbours]}
% level2 must be integer and equal or smaller than level1
%% path of the dataset
datasets = 'AB';
Data_type = 1;
ReadingPath = [cd '/document_authentication/Datasets/ISSD/ISSD - ' datasets(Data_type)];
%% ql_knn features selection
dtatFiles = dir(ReadingPath);
dtatFiles(1:2) = [];
for j = 1:18
for i = 1:numel(dtatFiles)
        fileId = dtatFiles(i).name(2);
        dataName = dtatFiles(i).name;
        if strcmp(dataName(end-4:end),'.jpeg')
            if strcmp(dataName(4:end-5),num2str(j))
                try
                    imageMatrix = imread([ReadingPath  '/' dtatFiles(i).name]);
                catch
                    imageMatrix = imread([ReadingPath  '\' dtatFiles(i).name]);
                end
                imageMatrix = rgb2gray(imageMatrix);
                numberOfRecs = round(0.05*size(imageMatrix,1));
                numberOfCols = round(0.05*size(imageMatrix,2));
                im1 = imageMatrix(1:numberOfRecs,1:numberOfCols);
                im2 = imageMatrix(1:numberOfRecs,end-numberOfCols+1:end);
                im3 = imageMatrix(end-numberOfRecs+1:end,1:numberOfCols);
                im4 = imageMatrix(end-numberOfRecs+1:end,end-numberOfCols+1:end);
                reducedImMat = [im1 im2; im3 im4];
                CLBPFeature = customizedExtractClpb(configurations{1},reducedImMat,uniDims);
                dataSetCLBP = [dataSetCLBP ;CLBPFeature str2num(fileId)];
                gaborFeature = customizedExtractGabor(configurations{2},reducedImMat,uniDims);
                dataSetGabor = [dataSetGabor ;gaborFeature str2num(fileId)]; 
                haarFeatures = customizedExtractHaarwavelet(configurations{3},reducedImMat,uniDims);
                dataSetHaarwavelet = [dataSetHaarwavelet ; haarFeatures str2num(fileId)];
                LBPFeature = customizedExtractLBP(configurations{4},reducedImMat,uniDims);
                dataSetLBP = [dataSetLBP ;LBPFeature str2num(fileId)];
            end
        end
        
    end
end
