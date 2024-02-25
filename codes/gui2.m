function varargout = gui2(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui2_OpeningFcn, ...
                   'gui_OutputFcn',  @gui2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui2 is made visible.
function gui2_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.axes4);
matlabImage = imread('icon3.jpg');
image(matlabImage)
axis off
axis image
%%%%%%%%
axes(handles.logo);
matlabImage = imread('logo.png');
image(matlabImage);
axis off
axis image
%%%%%%%%%%%
axes(handles.axes3)
matlabImage = imread('steps.png');
image(matlabImage)
axis off
axis image
%%%%%%%
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = gui2_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function logo_CreateFcn(hObject, eventdata, handles)

% Hint: place code in OpeningFcn to populate logo


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)

% Create the percent-complete text that will be updated
handles.progress.Visible = 'on';
handles.startRunning.Visible = 'on';
set(handles.progress,'box','on','xtick',[],'ytick',[],...
    'color',[0.9375 0.9375 0.9375],'xlim',[0,1],'ylim',[0,1]); %gray94
axes(handles.progress);
%%%%%%%%%%
ph = patch([0 0 0 0],[0 0 1 1],[0.67578 1 0.18359]); %greenyellow
th = text(1,1,'0%','VerticalAlignment','top','HorizontalAlignment','right');
title('Progress')
gamma = str2double(get(handles.discount, 'String'));
alpha = str2double(get(handles.learningRate, 'String'));
oldQTableWeight = str2double(get(handles.oldWeight, 'String'));
knnk = str2double(get(handles.numberOfNeighbours, 'String'));
reductionRatio = str2double(get(handles.reduction, 'String'));
if handles.checkbox1.Value == 1
dataDir = get(handles.datasetDir, 'String');
else
 dataDir = get(handles.savingDir, 'String'); 
 dataDir = [dataDir '/syntheticData.mat'];
end
load(dataDir);
currentInd = 1;
numberOfFeatures = size(Features,2);
k = round(reductionRatio * numberOfFeatures); % number of the selected features
numberOfActions = nchoosek(numberOfFeatures,k); % number of actions
numberOfStates = numberOfActions; % number of states
actions = combnk(1:numberOfFeatures,k); % all possible actions
states = actions; % all possible states
R = zeros(numberOfActions); % R matrix (state matrix)
Q = zeros(numberOfActions); % Q table
counter = 0;
% numberOfPeriods=1;
%% continue with q-learning
counter2 = 1;
for period = 1:numberOfPeriods
    chunkFeatures = Features(currentInd: currentInd + T -1,:);
    chunkLabels = Labels(currentInd: currentInd + T -1);
    % updating R and Q matrices
    for s = 1:numberOfStates
        % compting the accuracy of the current state
            currState = states(s,:);
            x = chunkFeatures(:,currState);
            y = chunkLabels;
            stateAcc = computeKnnClassificationAcc(x,y,knnk);
        for a = 1:numberOfActions

            progress = counter/(numberOfStates*numberOfActions*numberOfPeriods);
            ph.XData = [0 progress progress 0]; 
            th.String = sprintf('%f%%',(progress*100)); 
            drawnow %update graphics
%             clc;
%             disp(['progress: ' num2str(progress*100) ' %']);
            currAction = actions(a,:);
            % computing accuracy of the current action
            x = chunkFeatures(:,currAction);
            actionAcc = computeKnnClassificationAcc(x,y,knnk);
            % reward
            R(s,a) = actionAcc -stateAcc  ;
            v = 1:length(Q); % just temporal variable
            % updating Q value
            Q(s, a) = oldQTableWeight * Q(s, a) + (1-oldQTableWeight) * ...
                (alpha * (R(s,a) + gamma *....
                max(Q(s, v~=s)) - Q(s, a))); 
            counter = counter+1;
            counter2 = counter2+1;
%                      
        end
    end
    
  Acc(period) = max(max(Q));
  [tmpMax,i] = max(Q);
  [tmpMax,j] = max(tmpMax);
  bestState(period,:) = states(i(1),:);
  bestAction(period,:) = actions(j(1),:);
  currentInd = currentInd + T;
  handles.progress.Visible = 'off';
end
scaledQ = (Q-min(min(Q)))./(max(max(Q))-min(min(Q)));
           imagesc( scaledQ, 'Parent', handles.axes3 );
           set(handles.axes3,'YDir','normal');
%             set(handles.axes3,'Colormap','default');
            axes(handles.axes3);
            colorbar;
 handles.startRunning.String = 'algorithm execution has been done';
handles.startRunning.ForegroundColor=[0 0 1];

function datasetDir_Callback(hObject, eventdata, handles)
% hObject    handle to datasetDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of datasetDir as text
%        str2double(get(hObject,'String')) returns contents of datasetDir as a double


% --- Executes during object creation, after setting all properties.
function datasetDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datasetDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
if hObject.Value==1
    handles.checkbox2.Value=0;
    handles.datasetDir.Visible='on';
    handles.text25.Visible='on';
    handles.uibuttongroup2.Visible='off';
end




function reduction_Callback(hObject, eventdata, handles)
% hObject    handle to reduction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reduction as text
%        str2double(get(hObject,'String')) returns contents of reduction as a double


% --- Executes during object creation, after setting all properties.
function reduction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reduction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function discount_Callback(hObject, eventdata, handles)
% hObject    handle to discount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of discount as text
%        str2double(get(hObject,'String')) returns contents of discount as a double


% --- Executes during object creation, after setting all properties.
function discount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to discount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function learningRate_Callback(hObject, eventdata, handles)
% hObject    handle to learningRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of learningRate as text
%        str2double(get(hObject,'String')) returns contents of learningRate as a double


% --- Executes during object creation, after setting all properties.
function learningRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to learningRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function oldWeight_Callback(hObject, eventdata, handles)
% hObject    handle to oldWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of oldWeight as text
%        str2double(get(hObject,'String')) returns contents of oldWeight as a double


% --- Executes during object creation, after setting all properties.
function oldWeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to oldWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numberOfNeighbours_Callback(hObject, eventdata, handles)
% hObject    handle to numberOfNeighbours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberOfNeighbours as text
%        str2double(get(hObject,'String')) returns contents of numberOfNeighbours as a double


% --- Executes during object creation, after setting all properties.
function numberOfNeighbours_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberOfNeighbours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
if hObject.Value==1
    handles.checkbox1.Value=0;
    handles.datasetDir.Visible='off';
    handles.text25.Visible='off';
    handles.uibuttongroup2.Visible='on';
end




function numberOfFeatures_Callback(hObject, eventdata, handles)
% hObject    handle to numberOfFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberOfFeatures as text
%        str2double(get(hObject,'String')) returns contents of numberOfFeatures as a double


% --- Executes during object creation, after setting all properties.
function numberOfFeatures_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberOfFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numberOfRecords_Callback(hObject, eventdata, handles)
% hObject    handle to numberOfRecords (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberOfRecords as text
%        str2double(get(hObject,'String')) returns contents of numberOfRecords as a double


% --- Executes during object creation, after setting all properties.
function numberOfRecords_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minBeta_Callback(hObject, eventdata, handles)
% hObject    handle to minBeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minBeta as text
%        str2double(get(hObject,'String')) returns contents of minBeta as a double


% --- Executes during object creation, after setting all properties.
function minBeta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minBeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxBeta_Callback(hObject, eventdata, handles)
% hObject    handle to maxBeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxBeta as text
%        str2double(get(hObject,'String')) returns contents of maxBeta as a double


% --- Executes during object creation, after setting all properties.
function maxBeta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxBeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minAlpha_Callback(hObject, eventdata, handles)
% hObject    handle to minAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minAlpha as text
%        str2double(get(hObject,'String')) returns contents of minAlpha as a double


% --- Executes during object creation, after setting all properties.
function minAlpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxAlpha_Callback(hObject, eventdata, handles)
% hObject    handle to maxAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxAlpha as text
%        str2double(get(hObject,'String')) returns contents of maxAlpha as a double


% --- Executes during object creation, after setting all properties.
function maxAlpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minC_Callback(hObject, eventdata, handles)
% hObject    handle to minC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minC as text
%        str2double(get(hObject,'String')) returns contents of minC as a double


% --- Executes during object creation, after setting all properties.
function minC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxC_Callback(hObject, eventdata, handles)
% hObject    handle to maxC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxC as text
%        str2double(get(hObject,'String')) returns contents of maxC as a double


% --- Executes during object creation, after setting all properties.
function maxC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function oldFeaturesRatio_Callback(hObject, eventdata, handles)
% hObject    handle to oldFeaturesRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of oldFeaturesRatio as text
%        str2double(get(hObject,'String')) returns contents of oldFeaturesRatio as a double


% --- Executes during object creation, after setting all properties.
function oldFeaturesRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to oldFeaturesRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function savingDir_Callback(hObject, eventdata, handles)
% hObject    handle to savingDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of savingDir as text
%        str2double(get(hObject,'String')) returns contents of savingDir as a double


% --- Executes during object creation, after setting all properties.
function savingDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to savingDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function progress_CreateFcn(hObject, eventdata, handles)

% Hint: place code in OpeningFcn to populate progBar
% hObject.Visible = 'off';

% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
numberOfFeatures = str2num(handles.numberOfFeatures.String);
numberOfRecords = str2num(handles.numberOfRecords.String);
minBeta = str2num(handles.minBeta.String);
maxBeta = str2num(handles.maxBeta.String);
minAlpha = str2num(handles.minAlpha.String);
maxAlpha = str2num(handles.maxAlpha.String);
minC = str2num(handles.minC.String);
maxC = str2num(handles.maxC.String);
OldFeaturesRatio = str2num(handles.oldFeaturesRatio.String);
savingDir = (handles.savingDir.String);
generateData(numberOfFeatures,numberOfRecords,minBeta,maxBeta,minAlpha,...
    maxAlpha,minC,maxC,OldFeaturesRatio,savingDir);


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function checkbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function checkbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
