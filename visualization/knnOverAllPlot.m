% accuracy
% exporting to execl 
filename = [cd '/Tables/' datasets{num} '/overallMeasures.xlsx'];
Title = KNNxclTitles{knnVer};
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '1'],'WriteRowNames',true);
Title = 'Accuracy';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '3'],'WriteRowNames',true);
T = table(knn_overall{1}.accuracyMicro, knn_overall{2}.accuracyMicro, ...
    knn_overall{3}.accuracyMicro, knn_overall{4}.accuracyMicro, qlknn_overall.accuracyMicro,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '4'],'WriteRowNames',true);
%%%%%%%%%%
% plotting
bdata = [knn_overall{1}.accuracyMicro knn_overall{2}.accuracyMicro ...
    knn_overall{3}.accuracyMicro knn_overall{4}.accuracyMicro qlknn_overall.accuracyMicro];
Titl = 'KNN overall accuracy';
Titl = [Titl ' version' num2str(knnVer)];
styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
if ismember(num,[1 2])
% accuracy with deformation type
bdata = [knnAcc qlKnnAcc'];
Titl = 'KNN accuracy TimeSer according to deformation type';
Titl = [Titl ' version' num2str(knnVer)];

if num==1
xTick2 = {deformationTypes{1:end}};
else
   xTick2 = {deformationTypes2{1:end}};
end 
styledBar2(bdata,'Deformation Type',yLabl,xTick2,Titl,lgnd);
end
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% f_measure
% export to excel
Title = 'F_Measure';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '7'],'WriteRowNames',true);
T = table(elm_overall{1}.f_Measure, elm_overall{2}.f_Measure, ...
    elm_overall{3}.f_Measure ,elm_overall{4}.f_Measure ,qlelm_overall.f_Measure,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '8'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [knn_overall{1}.f_Measure knn_overall{2}.f_Measure ...
    knn_overall{3}.f_Measure knn_overall{4}.f_Measure qlknn_overall.f_Measure];
Titl = 'KNN overall f-Measure';
Titl = [Titl ' version' num2str(knnVer)];

styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% g_Mean
% export to excel
Title = 'G_Mean';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '11'],'WriteRowNames',true);
T = table(knn_overall{1}.g_Mean, knn_overall{2}.g_Mean, ...
    knn_overall{3}.g_Mean, knn_overall{4}.g_Mean, qlknn_overall.g_Mean,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '12'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [knn_overall{1}.g_Mean knn_overall{2}.g_Mean ...
    knn_overall{3}.g_Mean knn_overall{4}.g_Mean qlknn_overall.g_Mean];
Titl = 'KNN overall g-Mean';
Titl = [Titl ' version' num2str(knnVer)];

styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% precision
% export to excel
Title = 'precision';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '15'],'WriteRowNames',true);
T = table(knn_overall{1}.precision, knn_overall{2}.precision, ...
    knn_overall{3}.precision, knn_overall{4}.precision, qlknn_overall.precision,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '16'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [knn_overall{1}.precision knn_overall{2}.precision ...
    knn_overall{3}.precision knn_overall{4}.precision qlknn_overall.precision];
Titl = 'KNN overall precision';
Titl = [Titl ' version' num2str(knnVer)];

styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% recall
% export to excel
Title = 'recall';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '19'],'WriteRowNames',true);
T = table(knn_overall{1}.recall, knn_overall{2}.recall, ...
    knn_overall{3}.recall, knn_overall{4}.recall, qlknn_overall.recall,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '20'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [knn_overall{1}.recall knn_overall{2}.recall ...
    knn_overall{3}.recall knn_overall{4}.recall qlknn_overall.recall];
Titl = 'KNN overall recall';
Titl = [Titl ' version' num2str(knnVer)];

styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% specificity
% export to excel
Title = 'specificity';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '23'],'WriteRowNames',true);
T = table(knn_overall{1}.specificity, knn_overall{2}.specificity, ...
    knn_overall{3}.specificity, knn_overall{4}.specificity, qlknn_overall.specificity,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '24'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [knn_overall{1}.specificity knn_overall{2}.specificity ...
    knn_overall{3}.specificity knn_overall{4}.specificity qlknn_overall.specificity];
Titl = 'KNN overall specificity';
Titl = [Titl ' version' num2str(knnVer)];

styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% NPV
% export to excel
Title = 'NPV';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '27'],'WriteRowNames',true);
T = table(knn_overall{1}.NPV, knn_overall{2}.NPV,...
    knn_overall{3}.NPV, knn_overall{4}.NPV, qlknn_overall.NPV,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[KNNxclCols{knnVer} '28'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [knn_overall{1}.NPV knn_overall{2}.NPV ...
    knn_overall{3}.NPV knn_overall{4}.NPV qlknn_overall.NPV];
Titl = 'KNN overall NPV';
Titl = [Titl ' version' num2str(knnVer)];

styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% confusion matrix
% elm-clbp
figure('Name','KNN');
% suptitle('KNN');
subplot 231;
if num~=4
titl='CLBP';
else
  titl='Feature1';
end  
plotConfMat(knn_confusionMatrix{1},knn_tableOfConfusion{1}, {'1', '2','3','4','5'},titl);
% elm-gabor
subplot 232;
if num~=4
titl='Gabor';
else
  titl='Feature2';
end  

plotConfMat(knn_confusionMatrix{2},knn_tableOfConfusion{2}, {'1', '2','3','4','5'},titl);
% elm-lbp
subplot 233;
if num~=4
titl='LBP';
else
  titl='Feature3';
end  

plotConfMat(knn_confusionMatrix{3},knn_tableOfConfusion{3}, {'1', '2','3','4','5'},titl);
% elm-haar
subplot 234;
if num~=4
titl='Haar';
else
  titl='Feature4';
end  

plotConfMat(knn_confusionMatrix{4},knn_tableOfConfusion{4}, {'1', '2','3','4','5'},titl);
% ql-elm
subplot 235;
titl='ql-knn';
titl = [titl ' version' num2str(knnVer)];

plotConfMat(qlknn_confusionMatrix,qlknn_tableOfConfusion, {'1', '2','3','4','5'},titl);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%