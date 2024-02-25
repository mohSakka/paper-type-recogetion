%% initialization
clear;
clc;
close all;
%% loading dataset
records = readtable([cd '/../data/iris.csv']);
unq = unique(records(:,end));
tmp = records(:,end);
for j = 1:numel(unq)
    for i = 1:numel(tmp)
if isequal(tmp(i,1).Var5,unq(j,1).Var5);
    tmp(i,1).Var5 = {num2str(j)};
end
    end
end
records(:,end) = tmp;
recordsStruct = table2struct(records);
data(:,1) = [recordsStruct.Var1];
data(:,2) = [recordsStruct.Var2];
data(:,3) = [recordsStruct.Var3];
data(:,4) = [recordsStruct.Var4];
for i = 1:length(data(:,4))
    tmp2(i) = recordsStruct(i).Var5;
end
for i = 1:length(data(:,4))
    data(i,5) = str2double(recordsStruct(i).Var5);
end
%% normalization 
data = normalize(data);
%% shuffelling the data
data = data(randperm(end),:); % X
%%%%
%% saving
save([cd '/../data/iris'],'data');