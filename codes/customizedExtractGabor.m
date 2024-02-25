function Data = customizedExtractGabor(configurations,imageMatrix,uniDims)
d1 = configurations(1);
d2 = configurations(2);
imageMatrix = imresize(imageMatrix,uniDims);
gaborArray = gaborFilterBank(5,8,39,39);
featureVector = gaborFeatures(imageMatrix,gaborArray,d1,d2);
Data = featureVector';
end