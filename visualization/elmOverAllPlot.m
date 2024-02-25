if num==4
    varNames = {'SepalLength', 'SepalWidth', 'PetalLength' ,'PetalWidth ','QL'}
else
    varNames = {'CLBP' 'Gabor' 'LBP','Haar' 'QL'};
end

% accuracy
% exporting to execl 
filename = [cd '/Tables/' datasets{num} '/overallMeasures.xlsx'];
Title = 'ELM';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','A1','WriteRowNames',true);
Title = 'Accuracy';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','A3','WriteRowNames',true);
T = table(elm_overall{1}.accuracyMicro, elm_overall{2}.accuracyMicro ,...
    elm_overall{3}.accuracyMicro, elm_overall{4}.accuracyMicro, qlelm_overall.accuracyMicro,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range','A4','WriteRowNames',true);
%%%%%%%%%%
% plotting
bdata = [elm_overall{1}.accuracyMicro elm_overall{2}.accuracyMicro ...
    elm_overall{3}.accuracyMicro elm_overall{4}.accuracyMicro qlelm_overall.accuracyMicro];
Titl = 'ELM overall accuracy';
styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
if ismember(num,1:2)
% accuracy with deformation type
bdata = [elmAcc qlElmAcc'];
Titl = 'ELM accuracy TimeSer according to deformation type';
if num==1
xTick2 = {deformationTypes{4:end}};
else
   xTick2 = {deformationTypes2{4:end}};
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
writetable(T,filename,'Sheet',1,'Range','A7','WriteRowNames',true);
T = table(elm_overall{1}.f_Measure, elm_overall{2}.f_Measure, ...
    elm_overall{3}.f_Measure ,elm_overall{4}.f_Measure ,qlelm_overall.f_Measure,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range','A8','WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [elm_overall{1}.f_Measure elm_overall{2}.f_Measure ...
    elm_overall{3}.f_Measure elm_overall{4}.f_Measure qlelm_overall.f_Measure];
Titl = 'ELM overall f-Measure';
styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
if ismember(num,1:2)
% accuracy with deformation type
bdata = [elmAcc qlElmAcc'];
Titl = 'ELM accuracy TimeSer according to deformation type';
if num==1
xTick2 = {deformationTypes{4:end}};
else
   xTick2 = {deformationTypes2{4:end}};
end  
styledBar2(bdata,'Deformation Type',yLabl,xTick2,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
end

% g_Mean
% export to excel
Title = 'G_Measure';
T = table([],'VariableNames',{Title});
writetable(T,filename,'Sheet',1,'Range','A11','WriteRowNames',true);
T = table(elm_overall{1}.g_Mean, elm_overall{2}.g_Mean, ...
    elm_overall{3}.g_Mean, elm_overall{4}.g_Mean, qlelm_overall.g_Mean,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range','A12','WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [elm_overall{1}.g_Mean elm_overall{2}.g_Mean ...
    elm_overall{3}.g_Mean elm_overall{4}.g_Mean qlelm_overall.g_Mean];
Titl = 'ELM overall g-Mean';
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
writetable(T,filename,'Sheet',1,'Range','A15','WriteRowNames',true);
T = table(elm_overall{1}.precision, elm_overall{2}.precision, ...
    elm_overall{3}.precision, elm_overall{4}.precision, qlelm_overall.precision,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range','A16','WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [elm_overall{1}.precision elm_overall{2}.precision ...
    elm_overall{3}.precision elm_overall{4}.precision qlelm_overall.precision];
Titl = 'ELM overall precision';
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
writetable(T,filename,'Sheet',1,'Range','A19','WriteRowNames',true);
T = table(elm_overall{1}.recall, elm_overall{2}.recall, ...
    elm_overall{3}.recall, elm_overall{4}.recall, qlelm_overall.recall,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range','A20','WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting

bdata = [elm_overall{1}.recall elm_overall{2}.recall ...
    elm_overall{3}.recall elm_overall{4}.recall qlelm_overall.recall];
Titl = 'ELM overall recall';
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
writetable(T,filename,'Sheet',1,'Range','A23','WriteRowNames',true);
T = table(elm_overall{1}.specificity, elm_overall{2}.specificity, ...
    elm_overall{3}.specificity, elm_overall{4}.specificity, qlelm_overall.specificity,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range','A24','WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [elm_overall{1}.specificity elm_overall{2}.specificity ...
    elm_overall{3}.specificity elm_overall{4}.specificity qlelm_overall.specificity];
Titl = 'ELM overall specificity';
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
writetable(T,filename,'Sheet',1,'Range','A27','WriteRowNames',true);
T = table(elm_overall{1}.NPV, elm_overall{2}.NPV, ...
    elm_overall{3}.NPV, elm_overall{4}.NPV, qlelm_overall.NPV,...
    'VariableNames',varNames);
writetable(T,filename,'Sheet',1,'Range','A28','WriteRowNames',true);
%%%%%%%%%%%%%%%%%
% plotting
bdata = [elm_overall{1}.NPV elm_overall{2}.NPV ...
    elm_overall{3}.NPV elm_overall{4}.NPV qlelm_overall.NPV];
Titl = 'ELM overall NPV';
styledBar(bdata,xLabl,yLabl,Titl,lgnd);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
% confusion matrix
% elm-clbp
fg = figure('Name','ELM');
% suptitle('ELM');
subplot 231;
if num~=4
titl='CLBP';
else
 titl='Feature1';
end
plotConfMat(elm_confusionMatrix{1},elm_tableOfConfusion{1}, {'1', '2','3','4','5'},titl);
% elm-gabor
subplot 232;
if num~=4
titl='Gabor';
else
    titl='Feature2';
end 
plotConfMat(elm_confusionMatrix{2},elm_tableOfConfusion{2}, {'1', '2','3','4','5'},titl);
% elm-lbp
subplot 233;
if num~=4
titl='LBP';
else
  titl='Feature3';
end   
plotConfMat(elm_confusionMatrix{3},elm_tableOfConfusion{3}, {'1', '2','3','4','5'},titl);
% elm-haar
subplot 234;
if num~=2
titl='Haar';
else
titl='Feature4';
end 
plotConfMat(elm_confusionMatrix{4},elm_tableOfConfusion{4}, {'1', '2','3','4','5'},titl);
% ql-elm
subplot 235;
titl='ql-elm';
plotConfMat(qlelm_confusionMatrix,qlelm_tableOfConfusion, {'1', '2','3','4','5'},titl);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%