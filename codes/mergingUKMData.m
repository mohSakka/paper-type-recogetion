%% initialization 
clear;
clc;
close all;
%% loading
% res50
clbp50 = load([cd '/../data/CLBP_dataUKM 50']);
gabor50 = load([cd '/../data/Gabor_dataUKM 50']);
lbp50 = load([cd '/../data/LBP_dataUKM 50']);
haar50 = load([cd '/../data/Haar_dataUKM 50']);
% res100
clbp100 = load([cd '/../data/CLBP_dataUKM 100']);
gabor100 = load([cd '/../data/Gabor_dataUKM 100']);
lbp100 = load([cd '/../data/LBP_dataUKM 100']);
haar100 = load([cd '/../data/Haar_dataUKM 100']);
% res150
clbp150 = load([cd '/../data/CLBP_dataUKM 150']);
gabor150 = load([cd '/../data/Gabor_dataUKM 150']);
lbp150 = load([cd '/../data/LBP_dataUKM 150']);
haar150 = load([cd '/../data/Haar_dataUKM 150']);
%% merging
dataSetCLBP = [clbp150.dataSetCLBP ; clbp100.dataSetCLBP ; clbp50.dataSetCLBP];
dataSetGabor = [gabor150.dataSetGabor ; gabor100.dataSetGabor ; gabor50.dataSetGabor];
dataSetHaarwavelet = [haar150.dataSetHaarwavelet ; haar100.dataSetHaarwavelet ; haar50.dataSetHaarwavelet];
dataSetLBP = [lbp150.dataSetLBP ; lbp100.dataSetLBP ; lbp50.dataSetLBP];
save([cd '/../data/Haar_dataUKM'],'dataSetHaarwavelet');
save([cd '/../data/LBP_dataUKM'],'dataSetLBP');
save([cd '/../data/CLBP_dataUKM'],'dataSetCLBP');
save([cd '/../data/Gabor_dataUKM'],'dataSetGabor');
