the codes folder contain the following algorithm for feature selection
1- QL_ELM
2- QL_OSELM
3- QL_KNN
to run the codes you can find the code of each algorithm with the algorithm name
and dataset name and 'realApp' means that this is our actual application
for example: 'ql_ELM_realAppB.m' means QL_ELM on dataset B
## but for datasetA the files names not contain the dataset name, so ...
ql_realApp.m means QL_ELM on dataset A
########## to use the codes on an other dataset, it is easy
just change the loading path in top of the file, and change the saving directory...
in the end of file, notice that you also may need to change the chunkLength,...
numberOfChunks, and may more parameters. some codes replace chunkLength with T or period.
%%%%%%%%% new for visualization %%%%%%%
go to visualization --> MainFile
the figures are saved automatically
the figures have been already saved in visualization/images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
**********Q-Learninng Based Features Selection GUI*********
go to codes --> gui2
***************************
figures of the dataset that is exist in the following directory:
"data/syntheticData" is availabel in codes with name 'accTimeSer2' and
'containment'
***********************
the files and codes has not been completely done because it is initial version.
***********************
the modifications that will be done:
1- processing the special cases of the GUI (empty text input,.. etc).
2- fixing some issues
3- developing the GUI to work with the real app and datasets
************************


