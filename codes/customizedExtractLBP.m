function Data = customizedExtractLBP(configurations,imageMatrix,uniDims)
Radius = configurations(1);
NumNeighbors = configurations(2);
CellSize = [32 32];
imageMatrix = imresize(imageMatrix,uniDims);
features = extractLBPFeatures(imageMatrix...
                    ,'CellSize',CellSize,'NumNeighbors',NumNeighbors,...
                    'Radius',Radius,'Upright',false);
Data=[features];
end