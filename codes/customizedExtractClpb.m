function Data = customizedExtractClpb(configurations,imageMatrix,uniDims)
Radius = configurations(1);
NumNeighbors = configurations(2);
imageMatrix = imresize(imageMatrix,uniDims);
[FS,FM]= clbp(imageMatrix,Radius,NumNeighbors,0,'nh');
Data=[FS FM];
end