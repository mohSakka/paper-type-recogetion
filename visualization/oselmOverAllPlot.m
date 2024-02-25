% accuracy
% exporting to execl 
filename = [cd '/Tables/' datasets{num} '/overallMeasures.xlsx'];
Title = OSELMxclTitles{oselmVer};
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '1'],'WriteRowNames',true);
Title = 'Accuracy';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '3'],'WriteRowNames',true);
T = table(oselm_overall{1}.accuracyMicro, oselm_overall{2}.accuracyMicro, ...
    oselm_overall{3}.accuracyMicro, oselm_overall{4}.accuracyMicro, qloselm_overall.accuracyMicro,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '4'],'WriteRowNames',true);
%%%%%%%%%%
% plotting
bdata = [oselm_overall{1}.accuracyMicro oselm_overall{2}.accuracyMicro ...
    oselm_overall{3}.accuracyMicro oselm_overall{4}.accuracyMicro qloselm_overall.accuracyMicro];
Titl = 'OSELM overall accuracy';
Titl = [Titl ' version' num2str(oselmVer)];
styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
if ismember(num,[1 2])
% accuracy with deformation type
bdata = [oselmAcc qlOSElmAcc'];
Titl = 'OSELM accuracy TimeSer according to deformation type';
Titl = [Titl ' version' num2str(oselmVer)];
if num==1
xTick2 = {deformationTypes{1:end}};
else
   xTick2 = {deformationTypes2{1:end}};
end 

styledBar2(bdata,'Deformation Type',yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
end
% f_measure
% export to excel
Title = 'F_Measure';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '7'],'WriteRowNames',true);
T = table(oselm_overall{1}.f_Measure, oselm_overall{2}.f_Measure, ...
    oselm_overall{3}.f_Measure, oselm_overall{4}.f_Measure, qloselm_overall.f_Measure,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '8'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [oselm_overall{1}.f_Measure oselm_overall{2}.f_Measure ...
    oselm_overall{3}.f_Measure oselm_overall{4}.f_Measure qloselm_overall.f_Measure];
Titl = 'OSELM overall f-Measure';
Titl = [Titl ' version' num2str(oselmVer)];

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
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '11'],'WriteRowNames',true);
T = table(oselm_overall{1}.g_Mean, oselm_overall{2}.g_Mean, ...
    oselm_overall{3}.g_Mean, oselm_overall{4}.g_Mean, qloselm_overall.g_Mean,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '12'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting

bdata = [oselm_overall{1}.g_Mean oselm_overall{2}.g_Mean ...
    oselm_overall{3}.g_Mean oselm_overall{4}.g_Mean qloselm_overall.g_Mean];
Titl = 'OSELM overall g-Mean';
Titl = [Titl ' version' num2str(oselmVer)];

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
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '15'],'WriteRowNames',true);
T = table(oselm_overall{1}.precision, oselm_overall{2}.precision, ...
    oselm_overall{3}.precision, oselm_overall{4}.precision, qloselm_overall.precision,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '16'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [oselm_overall{1}.precision oselm_overall{2}.precision ...
    oselm_overall{3}.precision oselm_overall{4}.precision qloselm_overall.precision];
Titl = 'OSELM overall precision';
Titl = [Titl ' version' num2str(oselmVer)];

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
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '19'],'WriteRowNames',true);
T = table(oselm_overall{1}.recall, oselm_overall{2}.recall, ...
    oselm_overall{3}.recall, oselm_overall{4}.recall, qloselm_overall.recall,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '20'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [oselm_overall{1}.recall oselm_overall{2}.recall ...
    oselm_overall{3}.recall oselm_overall{4}.recall qloselm_overall.recall];
Titl = 'OSELM overall recall';
Titl = [Titl ' version' num2str(oselmVer)];

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
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '23'],'WriteRowNames',true);
T = table(oselm_overall{1}.specificity, oselm_overall{2}.specificity, ...
    oselm_overall{3}.specificity, oselm_overall{4}.specificity, qloselm_overall.specificity,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '24'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting

bdata = [oselm_overall{1}.specificity oselm_overall{2}.specificity ...
    oselm_overall{3}.specificity oselm_overall{4}.specificity qloselm_overall.specificity];
Titl = 'OSELM overall specificity';
Titl = [Titl ' version' num2str(oselmVer)];

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
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '27'],'WriteRowNames',true);
T = table(oselm_overall{1}.NPV, oselm_overall{2}.NPV, ...
    oselm_overall{3}.NPV, oselm_overall{4}.NPV, qloselm_overall.NPV,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range',[OSELMxclCols{oselmVer} '28'],'WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [oselm_overall{1}.NPV oselm_overall{2}.NPV ...
    oselm_overall{3}.NPV oselm_overall{4}.NPV qloselm_overall.NPV];
Titl = 'OSELM overall NPV';
Titl = [Titl ' version' num2str(oselmVer)];

styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% confusion matrix
% elm-clbp
figure('Name','OSELM');
% suptitle('OSELM')
subplot 231;
if num~=4
titl='CLBP';
else
    titl = 'Feature1';
end
plotConfMat(oselm_confusionMatrix{1},oselm_tableOfConfusion{1}, {'1', '2','3','4','5'},titl);
% elm-gabor
subplot 232;
if num~=4
titl='Gabor';
else
    titl = 'Feature2';
end
plotConfMat(oselm_confusionMatrix{2},oselm_tableOfConfusion{2}, {'1', '2','3','4','5'},titl);
% elm-lbp
subplot 233;
if num~=4
titl='LBP';
else
    titl = 'Feature3';
end
plotConfMat(oselm_confusionMatrix{3},oselm_tableOfConfusion{3}, {'1', '2','3','4','5'},titl);
% elm-haar
subplot 234;
if num~=4
titl='Haar';
else
    titl = 'Feature4';
end
plotConfMat(oselm_confusionMatrix{4},oselm_tableOfConfusion{4}, {'1', '2','3','4','5'},titl);
% ql-elm
subplot 235;
titl='ql-oselm';
titl = [titl ' version' num2str(oselmVer)];
plotConfMat(qloselm_confusionMatrix , qloselm_tableOfConfusion, {'1', '2','3','4','5'},titl);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%