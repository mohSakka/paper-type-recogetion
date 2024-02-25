elmAcc = elm.Acc;
oselmAcc = oselm.bestAccTs;
knnAcc = knn.Acc;
qlElmAcc = qlElm.bestAccTs;
qlOSElmAcc = qlOSElm.bestAccTs;
qlKnnAcc = qlKnn.bestAccTs;
%% plotting
if num~=4
legends = {'CLBP','Gabor','LBP','Haar','QL'};
else
    legends = {'Feature1','Feature2','Feature3','Feature4','QL'};
end
loc = 'northeastoutside';
% elm and ql-elm on the same figure
figure;
for s = 1:4
plot(elmAcc(:,s),'-o','linewidth',2)
hold on;
end
% 
plot(qlElmAcc,'-o','linewidth',2)
%
xlabel('chunk');
ylabel('accuracy');
title('ELM Accuracy timeSeries');
legend(legends,'location',loc);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%%%%%%%%%%%%%

% oselm and ql-oselm on the same figure
figure;
for s = 1:4
plot(oselmAcc(:,s),'-o','linewidth',2)
hold on;
end
% 
plot(qlOSElmAcc,'-o','linewidth',2);
%
xlabel('chunk');
ylabel('accuracy');
title(['OSELM Accuracy timeSeries ver' num2str(oselmVer)]);
legend(legends,'location',loc);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%%%%%%%%%%%%%

% KNN and ql-KNN on the same figure
figure;
for s = 1:4
plot(knnAcc(:,s),'-o','linewidth',2)
hold on;
end
% 
plot(qlKnnAcc,'-o','linewidth',2);
%
xlabel('chunk');
ylabel('accuracy');
title(['KNN Accuracy timeSeries version' num2str(knnVer)]);
legend(legends,'location',loc);
%%%%%%%%%%%%%%
set(gca,'FontSize',10);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
%%%%%%%%%%%%%%