
function varargout = gui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function discountFactor_Callback(hObject, eventdata, handles)
% hObject    handle to discountFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of discountFactor as text
%        str2double(get(hObject,'String')) returns contents of discountFactor as a double


% --- Executes during object creation, after setting all properties.
function discountFactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to discountFactor (see GCBO)
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



function reductionRatio_Callback(hObject, eventdata, handles)
% hObject    handle to reductionRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reductionRatio as text
%        str2double(get(hObject,'String')) returns contents of reductionRatio as a double


% --- Executes during object creation, after setting all properties.
function reductionRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reductionRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_KNN_Callback(hObject, eventdata, handles)
% hObject    handle to k_KNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k_KNN as text
%        str2double(get(hObject,'String')) returns contents of k_KNN as a double


% --- Executes during object creation, after setting all properties.
function k_KNN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_KNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
global ph;
global th;
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gamma = str2double(get(handles.discountFactor, 'String'));
alpha = str2double(get(handles.learningRate, 'String'));
oldQTableWeight = str2double(get(handles.oldWeight, 'String'));
knnk = str2double(get(handles.k_KNN, 'String'));
reductionRatio = str2double(get(handles.reductionRatio, 'String'));
dataDir = cell2mat(get(handles.datasetDir, 'String'));
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
numberOfPeriods=1;
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
            ph.XData = [0 progress/100 progress/100 0]; 
            th.String = sprintf('%f%%',(progress)); 
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
%             axes(handles.q_table);

%            set(handles.q_table,'Scaled','on');
%             imagesc(flipud(Q),[0 1]);           
        end
    end
    
  Acc(period) = max(max(Q));
  [tmpMax,i] = max(Q);
  [tmpMax,j] = max(tmpMax);
  bestState(period,:) = states(i(1),:);
  bestAction(period,:) = actions(j(1),:);
  currentInd = currentInd + T;
end
% scaledQ = (Q-min(min(Q)))./(max(max(Q))-min(min(Q)));
%            imagesc( scaledQ, 'Parent', handles.q_table );
%            set(handles.q_table,'YDir','normal');
%             set(handles.q_table,'Colormap','default');
%             axes(handles.q_table);
%             colorbar;

% --- Executes during object creation, after setting all properties.


% --- Executes during object creation, after setting all properties.
function progBar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to progBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'box','on','xtick',[],'ytick',[],...
    'color',[0.9375 0.9375 0.9375],'xlim',[0,1],'ylim',[0,1]); %gray94
title(hObject,'Progress')
% Hint: place code in OpeningFcn to populate progBar
global ph;
global th;
ph = patch([0 0 0 0],[0 0 1 1],[0.67578 1 0.18359]); %greenyellow
% Create the percent-complete text that will be updated
th = text(1,1,'0%','VerticalAlignment','bottom','HorizontalAlignment','right');


% --- Executes during object creation, after setting all properties.


% --- Executes during object creation, after setting all properties.
function logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject)
matlabImage = imread('logo.png');
image(matlabImage)
axis off
axis image 
% Hint: place code in OpeningFcn to populate logo
