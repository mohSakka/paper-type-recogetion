%% initialization 
clear;
clc;
close all;
%% loading the results
% select dataset name by setting num variable
% -1 A
% -2 B
% -3 UKM
% -4 IRIS
for num=1:4 % just modify this variable, but not modify any other except oselmVer and knnVer
datasets = {'A','B','UKM','IRIS'};
index = [151 151 501 11];
NC = [5 5 5 3];
% select knn and OSELM version
% -1 first version
% -2 second version
for oselmVer = 1:2
knnVer = oselmVer;
%%%%%%%%
OSELMxclCols = {'G','T'};
OSELMxclTitles = {'OSELM_Version_1','OSELM_Version_2'};
KNNxclCols = {'M','Z'};
KNNxclTitles = {'KNN_Version_1','KNN_Version_2'};
elm = load([cd '/../results/ELM_dataSet' datasets{num}]);
qlElm = load([cd '/../results/QL_ELM_dataSet' datasets{num}]);
if oselmVer~=2
oselm = load([cd '/../results/OSELM_dataSet' datasets{num}]);
qlOSElm = load([cd '/../results/QL_OSELM_dataSet' datasets{num}]);
else
oselm = load([cd '/../results/OSELM2version_dataSet' datasets{num}]);
qlOSElm = load([cd '/../results/QL_OSELM2version_dataSet' datasets{num}]);
end
if knnVer~=2
knn = load([cd '/../results/KNN_dataSet' datasets{num}]);
qlKnn = load([cd '/../results/QL_KNN_dataSet' datasets{num}]);
else
knn = load([cd '/../results/KNN2version_dataSet' datasets{num}]);
qlKnn = load([cd '/../results/QL_KNN2version_dataSet' datasets{num}]);
end
%% start visualization 
% plotAcc;
% if ismember(num,[1 2]) % because the number of chunks in UKM data is large
% plotQTableTS;
% end
overallPlot;
% if ismember(num,[1 2])
% computeMeasuresTimeSeriesForAandBData;
% end
close all;
% savingAllfigures;
end
end