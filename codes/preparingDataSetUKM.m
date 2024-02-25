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
% datasets = 'AB';
Res_type = 2;
resolutions = [50 100 150];
ReadingPath = [cd '\..\data\UKM ' num2str(resolutions(Res_type)) ' DPI - Resolution'];
%% ql_knn features selection
dtatFiles = dir(ReadingPath);
dtatFiles(1:2) = [];
for j = 1:2
for i = 1:numel(dtatFiles)
        fileId = dtatFiles(i).name(2);
        dataName = dtatFiles(i).name;
        if strcmp(dataName(end-3:end),'.JPG') || strcmp(dataName(end-3:end),'.jpg')
            if strcmp(dataName(4:end-4),num2str(j))
                try
                    imageMatrix = imread([ReadingPath  '/' dtatFiles(i).name]);
                catch
                    imageMatrix = imread([ReadingPath  '\' dtatFiles(i).name]);
                end
%                 imageMatrix = rgb2gray(imageMatrix);
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
save([cd '/../data/Haar_dataUKM ' num2str(resolutions(Res_type))],'dataSetHaarwavelet');
save([cd '/../data/LBP_dataUKM ' num2str(resolutions(Res_type))],'dataSetLBP');
save([cd '/../data/CLBP_dataUKM ' num2str(resolutions(Res_type))],'dataSetCLBP');
save([cd '/../data/Gabor_dataUKM ' num2str(resolutions(Res_type))],'dataSetGabor');