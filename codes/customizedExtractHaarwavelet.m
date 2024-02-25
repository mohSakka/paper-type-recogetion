function Data = customizedExtractHaarwavelet(configurations,imageMatrix,uniDims)
level1 = configurations(1);
level2 = configurations(2);
imageMatrix = imresize(imageMatrix, uniDims);
[c,s]=wavedec2(imageMatrix,level1,'haar');
A1 = appcoef2(c,s,'haar',level2);
Data= A1(:)';
end