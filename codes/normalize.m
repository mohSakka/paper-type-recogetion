function data = normalize(data)
records = data(:,1:end-1);
targets = data(:,end);
mn = min(records,[],1);
mn = repmat(mn,size(records,1),1);
mx = max(records,[],1);
mx = repmat(mx,size(records,1),1);
records = (records - mn)./(mx-mn);
data = [records,targets];
end