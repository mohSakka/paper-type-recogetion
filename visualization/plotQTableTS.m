elmQts = qlElm.QTimeSer;
oselmQts = qlOSElm.QTimeSer;
knnQts = qlKnn.QTimeSer;
%% scaling between 0 and 1
for i=1:numel(elmQts)
    mn = min(min(elmQts{i}));
    mx = max(max(elmQts{i}));
    elmQts{i} = (elmQts{i} - mn)./(mx-mn);
end
%%%%%%%%
for i=1:numel(oselmQts)
    mn = min(min(oselmQts{i}));
    mx = max(max(oselmQts{i}));
    oselmQts{i} = (oselmQts{i} - mn)./(mx-mn);
end
%%%%%%%%%%%
for i=1:numel(knnQts)
    mn = min(min(knnQts{i}));
    mx = max(max(knnQts{i}));
    knnQts{i} = (knnQts{i} - mn)./(mx-mn);
end
%% ELM
% suptitle('elm');
xTitles = {'CLBP','Gabor','LBP','Haar'};
yTitles = xTitles;
f1 = figure('name','elm Q-table timeSer');
% suptitle('elm Q-table timeSer');
rowsNum = numel(elmQts);
for i=1:rowsNum
  subplot(3,rowsNum/3,i);  
  imagesc(elmQts{i});
  colorbar;
%   g=gca;
  set(gca,'xTickLabelRotation' , 30,'yTickLabelRotation' , 30);
  set(gca,'XTick',1:4,'xtickLabel' , xTitles);
  set(gca,'YtickLabel' , yTitles);
   set(gca,'YTick',1:4,'YDir','normal');
  title(['chunk ' num2str(i)]);
  colormap('default');
end
%%%%%%%%%%%%%%
% set(gca,'FontSize',10);
% set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
saveas(f1,[cd '/images/' datasets{num} ['/elm Q-table timeSer.png']]);
%% KNN
% suptitle('knn');
xTitles = {'CLBP','Gabor','LBP','Haar'};
yTitles = xTitles;
f2 = figure('name',['knn Q-table timeSer version' num2str(knnVer)]);
% suptitle('knn Q-table timeSer');
rowsNum = numel(knnQts);
for i=1:rowsNum
  subplot(3,rowsNum/3,i);  
  imagesc(knnQts{i});
  colorbar;
%   g=gca;
  set(gca,'xTickLabelRotation' , 30,'yTickLabelRotation' , 30);
  set(gca,'XTick',1:4,'xtickLabel' , xTitles);
  set(gca,'YtickLabel' , yTitles);
   set(gca,'YTick',1:4,'YDir','normal');
  title(['chunk ' num2str(i)]);
  colormap('default');
end
%%%%%%%%%%%%%%
% set(gca,'FontSize',10);
% set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
saveas(f2,[cd '/images/' datasets{num} ['/KNN Q-table timeSer version' num2str(oselmVer)] '.png']);
%% OSELM
% suptitle('oselm');
xTitles = {'CLBP','Gabor','LBP','Haar'};
yTitles = xTitles;
f3 = figure('name',['oselm Q-table timeSer version' num2str(oselmVer)]);
% suptitle('oselm Q-table timeSer');
rowsNum = numel(oselmQts);
for i=1:rowsNum
  subplot(3,rowsNum/3,i);  
  imagesc(oselmQts{i});
  colorbar;
%   g=gca;
  set(gca,'xTickLabelRotation' , 30,'yTickLabelRotation' , 30);
  set(gca,'XTick',1:4,'xtickLabel' , xTitles);
  set(gca,'YtickLabel' , yTitles);
   set(gca,'YTick',1:4,'YDir','normal');
  title(['chunk ' num2str(i)]);
  colormap('default');
end
%%%%%%%%%%%%%%
% set(gca,'FontSize',10);
% set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%%%%%%%%%%%%%
saveas(f3,[cd '/images/' datasets{num} ['/oselm Q-table timeSer version' num2str(oselmVer)] '.png']);