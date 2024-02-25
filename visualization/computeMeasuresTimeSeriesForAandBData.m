%% excel parameters
filename = [cd '/Tables/' datasets{num} '/timeSeriesMeasures.xlsx'];
varNames = {'CLBP' 'Gabor' 'LBP' 'Haar' 'QL'};
%%
numberOfClasses = NC(num);
deformationTypes = {'N','R','T','NS',...
    'RS ','TS','NP',...
    'RP','TP','NPS',...
    'RPS','TPS',...
    'NPC','RPC','TPC',...
    'NPC&S','RPC&S',...
    'TPC&S'};
deformationTypes2 = {'N','R','T','NC','RC','TC','NCS','RCS','TCS'};
xLabl = 'Deformation Type';
yLabl = 'masure value';
lgnd = {'CLBP','Gabor','LBP','Haar','QL'};
if num==1
    DT = deformationTypes';
else
    DT = deformationTypes2';
end
%% get the algorithms's true LAbels and predicted labels
%% elm
elmLabels = elm.Labels;
elmPredLabels = elm.predictedLabels;
%% ql_elm
qlElmLabels = qlElm.trueLabels;
qlElmPredLabels = qlElm.predictedLabels;
%% oselm
oselmLabels = oselm.trueLabels;
oselmPredLabels = oselm.predictedLabels;
%% ql_OSELM
qlOselmLabels = qlOSElm.trueLabels;
qlOselmPredLabels = qlOSElm.predictedLabels;
%% KNN
knnLabels = knn.trueLabels;
knnPredLabels = knn.predictedLabels;
%% qlKnn
qlKnnLabels = qlKnn.trueLabels;
qlKnnPredLabels = qlKnn.predictedLabels;
%% chunkLengths for every dataset
elmChunksLengths = [50 50 50 10]; % A B UKM IRIS
oselmChunksLengths = [50 50 50 10]; % A B UKM IRIS
knnChunksLengths = [50 50 50 10]; % A B UKM IRIS
%% divide every algorithm results to chunks and calculate the measures
%% elm
T = elmChunksLengths(num);
numberOfChunks = (length(elmLabels{1})-index(num)+1)/T;
ind = index(num);
ind2 = 1;
for i=1:numberOfChunks
% ELM
for f = 1:4
[~,~,~,~,~,~,~,~,~,~,~,~,~,elm_overall_ts{i,f}] = ...
CalculateMetricsMultiClass(numberOfClasses,elmLabels{f}(ind:ind+T-1),elmPredLabels(ind2:ind2+T-1,f));
end
ind = ind + T;
ind2 = ind2 + T;
end
%% ql_ELM
T = elmChunksLengths(num);
numberOfChunks = (length(qlElmLabels))/T;
ind = 1;
for i=1:numberOfChunks
[~,~,~,~,~,~,~,~,~,~,~,~,~,qlelm_overall_ts{i}] = ...
CalculateMetricsMultiClass(numberOfClasses,qlElmLabels(ind:ind+T-1),qlElmPredLabels(ind:ind+T-1));
ind = ind + T;
end
%% OSELM
if oselmVer==1
    T = oselmChunksLengths(num)/2
else
T = oselmChunksLengths(num);
end
numberOfChunks = (length(oselmLabels(:,1)))/T;
ind = 1;
for i=1:numberOfChunks
for f = 1:4
[~,~,~,~,~,~,~,~,~,~,~,~,~,oselm_overall_ts{i,f}] = ...
CalculateMetricsMultiClass(numberOfClasses,oselmLabels(ind:ind+T-1),oselmPredLabels(ind:ind+T-1,f));
end
ind = ind + T;
end
%% ql_OSELM
ind = 1;
for i=1:numberOfChunks
[~,~,~,~,~,~,~,~,~,~,~,~,~,qloselm_overall_ts{i}] = ...
CalculateMetricsMultiClass(numberOfClasses,qlOselmLabels(ind:ind+T-1),qlOselmPredLabels(ind:ind+T-1));
ind = ind + T;
end
%% KNN
T = knnChunksLengths(num);
numberOfChunks = (length(knnLabels{1}))/T;
ind = 1;
for i=1:numberOfChunks
for f = 1:4
[~,~,~,~,~,~,~,~,~,~,~,~,~,knn_overall_ts{i,f}] = ...
CalculateMetricsMultiClass(numberOfClasses,knnLabels{f}(ind:ind+T-1),knnPredLabels(ind:ind+T-1,f));
end
ind = ind + T;
end
%% ql_KNN
T = knnChunksLengths(num);
numberOfChunks = (length(qlKnnLabels))/T;
ind = 1;
for i=1:numberOfChunks
[~,~,~,~,~,~,~,~,~,~,~,~,~,qlknn_overall_ts{i}] = ...
CalculateMetricsMultiClass(numberOfClasses,qlKnnLabels(ind:ind+T-1),qlKnnPredLabels(ind:ind+T-1));
ind = ind + T;
end
%% converting the structures to arrays
%% 
% elm
for i=1:4
tmp = [elm_overall_ts{:,i}];
elmAcc(:,i) = [tmp.accuracyMicro];
elmPrecision(:,i) = [tmp.precision];
elmRecall(:,i) = [tmp.recall];
elmSpecificity(:,i) = [tmp.specificity];
elmF_Measure(:,i) = [tmp.f_Measure];
elmNPV(:,i) = [tmp.NPV];
elmG_Mean(:,i) = [tmp.g_Mean];
end
% qlelm
tmp = [qlelm_overall_ts{:}];
qlelmAcc = [tmp.accuracyMicro];
qlelmPrecision = [tmp.precision];
qlelmRecall = [tmp.recall];
qlelmSpecificity = [tmp.specificity];
qlelmF_Measure = [tmp.f_Measure];
qlelmNPV = [tmp.NPV];
qlelmG_Mean = [tmp.g_Mean];
% oselm
for i=1:4
tmp = [oselm_overall_ts{:,i}];
oselmAcc(:,i) = [tmp.accuracyMicro];
oselmPrecision(:,i) = [tmp.precision];
oselmRecall(:,i) = [tmp.recall];
oselmSpecificity(:,i) = [tmp.specificity];
oselmF_Measure(:,i) = [tmp.f_Measure];
oselmNPV(:,i) = [tmp.NPV];
oselmG_Mean(:,i) = [tmp.g_Mean];
end
% qloselm
tmp = [qloselm_overall_ts{:}];
qloselmAcc = [tmp.accuracyMicro];
qloselmPrecision = [tmp.precision];
qloselmRecall = [tmp.recall];
qloselmSpecificity = [tmp.specificity];
qloselmF_Measure = [tmp.f_Measure];
qloselmNPV = [tmp.NPV];
qloselmG_Mean = [tmp.g_Mean];
% knn
for i=1:4
tmp = [knn_overall_ts{:,i}];
knnAcc(:,i) = [tmp.accuracyMicro];
knnPrecision(:,i) = [tmp.precision];
knnRecall(:,i) = [tmp.recall];
knnSpecificity(:,i) = [tmp.specificity];
knnF_Measure(:,i) = [tmp.f_Measure];
knnNPV(:,i) = [tmp.NPV];
knnG_Mean(:,i) = [tmp.g_Mean];
end
% qlknn
tmp = [qlknn_overall_ts{:}];
qlknnAcc = [tmp.accuracyMicro];
qlknnPrecision = [tmp.precision];
qlknnRecall = [tmp.recall];
qlknnSpecificity = [tmp.specificity];
qlknnF_Measure = [tmp.f_Measure];
qlknnNPV = [tmp.NPV];
qlknnG_Mean = [tmp.g_Mean];
%% plotting with deformation type
%% ELM
% precision
bdata = [elmPrecision qlelmPrecision'];
Titl = 'ELM precision TimeSer according to deformation type';
if num==1
xTick2 = {deformationTypes{4:end}};
else
   xTick2 = {deformationTypes2{4:end}};
end  
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% export to excel
Title = 'ELM';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','A1','WriteRowNames',true);
%%%
Title = 'precision';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','A3','WriteRowNames',true);
T = table({DT{4:end}}','VariableNames',{'DT'});
writetable(T,filename,'Sheet',1,'Range','A4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',1,'Range','B4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',1,'Range','B5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% recall 
bdata = [elmRecall qlelmRecall'];
Titl = 'ELM recall TimeSer according to deformation type';
if num==1
xTick2 = {deformationTypes{4:end}};
else
   xTick2 = {deformationTypes2{4:end}};
end  
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'recall';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','H3','WriteRowNames',true);
T = table({DT{4:end}}','VariableNames',{'DT'});
writetable(T,filename,'Sheet',1,'Range','H4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',1,'Range','I4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',1,'Range','I5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% specificity 
bdata = [elmSpecificity qlelmSpecificity'];
Titl = 'ELM specificity TimeSer according to deformation type';
if num==1
xTick2 = {deformationTypes{4:end}};
else
   xTick2 = {deformationTypes2{4:end}};
end  
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'specificity';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','O3','WriteRowNames',true);
T = table({DT{4:end}}','VariableNames',{'DT'});
writetable(T,filename,'Sheet',1,'Range','O4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',1,'Range','P4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',1,'Range','P5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% NPV 
bdata = [elmNPV qlelmNPV'];
Titl = 'ELM NPV TimeSer according to deformation type';
if num==1
xTick2 = {deformationTypes{4:end}};
else
   xTick2 = {deformationTypes2{4:end}};
end  
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'NPV';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','V3','WriteRowNames',true);
T = table({DT{4:end}}','VariableNames',{'DT'});
writetable(T,filename,'Sheet',1,'Range','V4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',1,'Range','W4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',1,'Range','W5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% f_Measure 
bdata = [elmF_Measure qlelmF_Measure'];
Titl = 'ELM f-Measure TimeSer according to deformation type';
if num==1
xTick2 = {deformationTypes{4:end}};
else
   xTick2 = {deformationTypes2{4:end}};
end  
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'f_Measure';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','AC3','WriteRowNames',true);
T = table({DT{4:end}}','VariableNames',{'DT'});
writetable(T,filename,'Sheet',1,'Range','AC4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',1,'Range','AD4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',1,'Range','AD5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% g_Mean 
bdata = [elmG_Mean qlelmG_Mean'];
Titl = 'ELM g-Mean TimeSer according to deformation type';
if num==1
xTick2 = {deformationTypes{4:end}};
else
   xTick2 = {deformationTypes2{4:end}};
end  
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'g_Mean';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','AJ3','WriteRowNames',true);
T = table({DT{4:end}}','VariableNames',{'DT'});
writetable(T,filename,'Sheet',1,'Range','AJ4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',1,'Range','AK4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',1,'Range','AK5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
chNum = 1;
% Accuracy 
%%% export to excel
Title = 'Accuracy';
bdata = [elmAcc qlelmAcc'];
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','AQ3','WriteRowNames',true);
T = table({DT{4:end}}','VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','AQ4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','AR4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','AR5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
%% OSELM
% precision
bdata = [oselmPrecision qloselmPrecision'];
Titl = ['OSELM-version-' num2str(oselmVer) ' precision TimeSer according to deformation type'];
if num==1
xTick2 = deformationTypes;
else
   xTick2 = deformationTypes2;
end  
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% export to excel
oselmChNum = [2 4];
Title = ['OSELM_version_' num2str(knnVer)];
chNum = oselmChNum(oselmVer);
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','A1','WriteRowNames',true);
%%%
Title = 'precision';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','A3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','A4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','B4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','B5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% recall 
bdata = [oselmRecall qloselmRecall'];
Titl = ['OSELM-version-' num2str(oselmVer) ' recall TimeSer according to deformation type'];

styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'recall';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','H3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','H4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','I4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','I5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% specificity 
bdata = [oselmSpecificity qloselmSpecificity'];
Titl = ['OSELM-version-' num2str(oselmVer) ' specificity TimeSer according to deformation type'];

styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'specificity';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','O3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','O4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','P4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','P5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% NPV 
bdata = [oselmNPV qloselmNPV'];
Titl = ['OSELM-version-' num2str(oselmVer) ' NPV TimeSer according to deformation type'];
 
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'NPV';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','V3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','V4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','W4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','W5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% f_Measure 
bdata = [oselmF_Measure qloselmF_Measure'];
Titl = ['OSELM-version-' num2str(oselmVer) ' f-Measure TimeSer according to deformation type'];

styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'f_Measure';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','AC3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','AC4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','AD4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','AD5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% g_Mean 
bdata = [oselmG_Mean qloselmG_Mean'];
Titl = ['OSELM-version-' num2str(oselmVer) ' g-Mean TimeSer according to deformation type'];
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'g_Mean';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','AJ3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','AJ4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','AK4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','AK5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% Accuracy 
%%% export to excel
Title = 'Accuracy';
bdata = [oselmAcc qloselmAcc'];
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','AQ3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','AQ4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','AR4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','AR5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
%% KNN
% precision
bdata = [knnPrecision qlknnPrecision'];
Titl = ['KNN_version_' num2str(knnVer) ' precision TimeSer according to deformation type'];

styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% export to excelc
knnChNum = [3 5];
Title = ['KNN_version_' num2str(knnVer)];
chNum = knnChNum(knnVer);
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','A1','WriteRowNames',true);
%%%
Title = 'precision';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','A3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','A4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','B4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','B5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% recall 
bdata = [knnRecall qlknnRecall'];
Titl = ['KNN-version-' num2str(knnVer) ' recall TimeSer according to deformation type'];

styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'recall';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','H3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','H4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','I4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','I5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% specificity 
bdata = [knnSpecificity qlknnSpecificity'];
Titl = ['KNN-version-' num2str(knnVer) ' specificity TimeSer according to deformation type'];

styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'specificity';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','O3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','O4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','P4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','P5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% NPV 
bdata = [knnNPV qlknnNPV'];
Titl = ['KNN-version-' num2str(knnVer) ' NPV TimeSer according to deformation type'];
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'NPV';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','V3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','V4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','W4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','W5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% f_Measure 
bdata = [knnF_Measure qlknnF_Measure'];
Titl = ['KNN-version-' num2str(knnVer) ' f-Measure TimeSer according to deformation type'];

styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'f_Measure';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','AC3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','AC4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','AD4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','AD5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% g_Mean 
bdata = [knnG_Mean qlknnG_Mean'];
Titl = ['KNN-version-' num2str(knnVer) ' g-Mean TimeSer according to deformation type'];
styledBar2(bdata,xLabl,yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%% export to excel
Title = 'g_Mean';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','AJ3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','AJ4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','AK4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','AK5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%
% Accuracy 
%%% export to excel
Title = 'Accuracy';
bdata = [knnAcc qlknnAcc'];
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',chNum,'Range','AQ3','WriteRowNames',true);
T = table(DT,'VariableNames',{'DT'});
writetable(T,filename,'Sheet',chNum,'Range','AQ4','WriteVariableNames',true);
T = table(varNames);
writetable(T,filename,'Sheet',chNum,'Range','AR4','WriteVariableNames',false);
T = table(bdata);
writetable(T,filename,'Sheet',chNum,'Range','AR5','WriteVariableNames',false);
%%%%%%%%%%%%%%%%%