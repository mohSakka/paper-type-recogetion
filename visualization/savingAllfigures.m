FolderName = ['images/' cell2mat(datasets(num))];   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = get(FigHandle, 'Name');
  if strcmp(FigName,'KNN')
      ver = knnVer;
  elseif strcmp(FigName,'OSELM')
      ver = oselmVer;
  end

  if strcmp(FigName,'KNN') ||  strcmp(FigName,'OSELM')
        saveas(FigHandle, fullfile(FolderName, [FigName '_version' num2str(ver) '_ConfMat' '.png']));
  elseif  strcmp(FigName,'ELM')
              saveas(FigHandle, fullfile(FolderName, [FigName '_ConfMat' '.png']));
  else
      axes_h = get(FigHandle,'CurrentAxes');
      g = get(axes_h,'title');
  saveas(FigHandle, fullfile(FolderName, [g.String(1,:) '.png']));
  end
end