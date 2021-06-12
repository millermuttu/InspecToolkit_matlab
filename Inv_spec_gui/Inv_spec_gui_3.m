function varargout = Inv_spec_gui_3(varargin)
% INV_SPEC_GUI_3 MATLAB code for Inv_spec_gui_3.fig
%      INV_SPEC_GUI_3, by itself, creates a new INV_SPEC_GUI_3 or raises the existing
%      singleton*.
%
%      H = INV_SPEC_GUI_3 returns the handle to a new INV_SPEC_GUI_3 or the handle to
%      the existing singleton*.
%
%      INV_SPEC_GUI_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INV_SPEC_GUI_3.M with the given input arguments.
%
%      INV_SPEC_GUI_3('Property','Value',...) creates a new INV_SPEC_GUI_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Inv_spec_gui_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Inv_spec_gui_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Inv_spec_gui_3

% Last Modified by GUIDE v2.5 04-Feb-2019 20:04:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Inv_spec_gui_3_OpeningFcn, ...
                   'gui_OutputFcn',  @Inv_spec_gui_3_OutputFcn, ...
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

%% Part1: GUI start
% --- Executes just before Inv_spec_gui_3 is made visible.
function Inv_spec_gui_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Inv_spec_gui_3 (see VARARGIN)
%Loading Demo Data
addpath ('C:\Users\sajjan\Desktop\muttu\venture\InvSpec_matlab\Inv_spec_gui');
load('Demo_InvSpec.mat');
handles.Demo_1=[WL,Tx1];
handles.Demo_2=[WL,Tx2];
load('AS_Demo.mat');
handles.AS_Demo=x;
load('DataSet_demo.mat');
handles.DataSet_demo=data;
clear x X;
% load('FigOM.mat');
% handles.FOM_lambda=lambda;
% handles.FOM_X=X;
handles.fom_demo=load('FigOM_3.mat');
handles.val=0;
handles.valset=0;
handles.spec_data={};
handles.spec_data_set={};
handles.listboxItems={};
handles.listboxItems_set={};
% Choose default command line output for Inv_spec_gui_3
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
%% Part2: Command Window
% UIWAIT makes Inv_spec_gui_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Inv_spec_gui_3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
clc
varargout{1} = handles.output;


%% Part3: Load Data
% --- Executes on button press in Inv_Spec_Load_data.
function Inv_Spec_Load_data_Callback(hObject, eventdata, handles)
% hObject    handle to Inv_Spec_Load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.spec_data,handles.listboxItems,handles.val,handles.spec_data_set,handles.listboxItems_set,handles.valset]= loadfromexcelnew(hObject,handles);
handles;
guidata(hObject, handles);

%% Part4a: Table list indv
% --- Executes on selection change in tablelist.
function tablelist_Callback(hObject, eventdata, handles)
% hObject    handle to tablelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'));%returns tablelist contents as cell array
handles.output = hObject;
handles.choice=1;%indiacting selection of indv data
handles.data_index={};
index = get(handles.tablelist,'value');
handles.index_selected=index;
if size(index,2)>1
    for k = 1:size(index,2);
        s=handles.spec_data{index(k)};
        s1=s(:,1);
        s2=s(:,2);
        handles.data_index{k}=[s1,s2];
    end
else
    handles.data_index = handles.spec_data{index};
    handles.str.data=contents{get(hObject,'Value')}; %returns selected item from tablelist
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function tablelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tablelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% part 4b
%--- Executes on selection change in Data_set.
function Data_set_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));%returns tablelist contents as cell array
handles.str.set=contents{get(hObject,'Value')}; %returns selected item from tablelist %only fr single
handles.output = hObject;
handles.data_index_set={};
index = get(handles.Data_set,'value');
handles.index_selected_set=index;
handles.data_index_set = handles.spec_data_set{index};
% handles.str.set=
handles.choice=2;%indiacting selection of data set
guidata(hObject, handles);


% hObject    handle to Data_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Data_set contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Data_set


% --- Executes during object creation, after setting all properties.
function Data_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Part5: Plot
% --- Executes on button press in lineplot.
function lineplot_Callback(hObject, eventdata, handles)
% hObject    handle to lineplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Disp,'String','Results: ','ForegroundColor','Black');
set(handles.plots_plsr,'Visible','Off');
set(handles.plots_drop,'Visible','Off');
cla;
legend(handles.axes1,'hide');
list=[];
if handles.choice==1
    if size(handles.data_index,1)>1 %when single data chosen
        handles.WL = handles.data_index(:,1);
        handles.spec = handles.data_index(:,2);
        plot(handles.WL,handles.spec);
    else %when multiple data chosen
        handles.data_index;
        for k = 1:size(handles.data_index,2);
            r=size(handles.data_index{k}(:,1));
            list(1,k)=r(1);
        end
        if size(unique(list),2)==1
        S=cell2mat(handles.data_index);
        d=1;
        for k = 1:size(handles.data_index,2);
            store=S(:,(d:d+1));
            store(:,1);
            handles.WL=store(:,1);
            handles.spec = store(:,2);
            d=d+2;
            plot(handles.WL,handles.spec);
            xlabel('Wavelength'); ylabel('Transmittance');
            hold on;
        end
        else
            msgbox('Spectra needs to be of equal indices for plot!');
        end
    end
elseif handles.choice==2
        temp=handles.data_index_set;
        WL = temp(2:end,1);
        Y=temp(1,2:end)';
        X=temp(2:end,2:end)';
        label=WL;
        line_plot_category(label, X,Y);
        
end
xlabel('Wavelength','fontsize',12);
ylabel('Transmitance','fontsize',12);

% --- Executes during object creation, after setting all properties.
function lineplot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lineplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on lineplot and none of its controls.
function lineplot_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lineplot (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


%% Part6: Display
% --- Executes during object creation, after setting all properties.
function Disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.output = hObject;
guidata(hObject, handles);


%% Part7: FOM
% --- Executes on button press in Inv_Spec_FoM.
function Inv_Spec_FoM_Callback(hObject, eventdata, handles)
% hObject    handle to Inv_Spec_FoM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Disp,'String','Results: ','ForegroundColor','Black');
set(handles.plots_plsr,'Visible','Off');
set(handles.plots_drop,'Visible','Off');
[d1,d2,d3,d4,d5,d6,d7]=fom_main(hObject,handles);
D=char(d1,d2,d3,d4,d5,d6,d7);
set(handles.Disp,'String',D);

%% Part8: Simulate
% --- Executes on button press in Inv_Spec_Simulate.
function Inv_Spec_Simulate_Callback(hObject, eventdata, handles)
% hObject    handle to Inv_Spec_Simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Disp,'String','Results: ','ForegroundColor','Black');
set(handles.plots_plsr,'Visible','Off');
set(handles.plots_drop,'Visible','Off');
Simulate_main(hObject,handles);



% Hints: contents = cellstr(get(hObject,'String')) returns plot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot

%% Part9: Tools
% --- Executes on selection change in Tools.
function Tools_Callback(hObject, eventdata, handles)
% hObject    handle to Tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
set(handles.Disp,'String','Results: ','ForegroundColor','Black');
set(handles.plots_plsr,'Visible','Off');
set(handles.plots_drop,'Visible','Off');
contents = cellstr(get(hObject,'String'));% returns Tools contents as cell array
Tools_choice=contents{get(hObject,'Value')}% returns selected item from Tools
try
    if (strcmp(Tools_choice,'Resize'))
        cut_X(hObject,handles);
    elseif(strcmp(Tools_choice,'Duplicate'))
        duplicate(hObject,handles)
    elseif (strcmp(Tools_choice,'Transmittance to Absorbance'))
        InvSpec_tx2abs(hObject,handles);
    elseif (strcmp(Tools_choice,'Absorbance to Transmittance'))
        InvSpec_abs2tx(hObject,handles);
    end
catch ME
    id = ME.identifier;
    switch ME.identifier
        case 'MATLAB:badsubscript'
            msg = 'Error : Kindly select the new wavelngth range.';
        case 'MATLAB:UndefinedFunction'
            msg= 'Error : Kindly enter the no. of repeats.';
    end
set(handles.Disp,'String',msg,'ForegroundColor','Red');
guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function Tools_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Part10: Transformations
% --- Executes on selection change in Transform.
function Transform_Callback(hObject, eventdata, handles)
% hObject    handle to Transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Resolution Change          
% Moving Average Smoothing   
% Median Filter Smoothing    
% Savitzky Golay Smoothing                       
% SNV                        
% Normalize                  
% SG Derivative
cla;
set(handles.Disp,'String','Results: ','ForegroundColor','Black');
set(handles.plots_plsr,'Visible','Off');
set(handles.plots_drop,'Visible','Off');
contents = cellstr(get(hObject,'String'));% returns Tools contents as cell array
Tools_choice=contents{get(hObject,'Value')};% returns selected item from Tools
try
    if (strcmp(Tools_choice,'Resolution Change'))
        Resample(hObject,handles);
    elseif (strcmp(Tools_choice,'Moving Average Smoothing'))
        moving(hObject,handles);
    elseif (strcmp(Tools_choice,'Median Filter Smoothing'))
         medimedian(hObject,handles);
    elseif (strcmp(Tools_choice,'Savitzky Golay Smoothing'))
         sg_smooth(hObject,handles);
    elseif (strcmp(Tools_choice,'SG Derivative'))
         sg_derivative(hObject,handles);
    elseif (strcmp(Tools_choice,'SNV    '))
         snv(hObject,handles);
    elseif (strcmp(Tools_choice,'Normalize'))
         normalize(hObject,handles);   
    end
catch ME
    id = ME.identifier;
    switch ME.identifier
        case 'MATLAB:badsubscript'
            msg = 'Error : Kindly enter a value.';
        case 'MATLAB:UndefinedFunction'
            msg= 'Error : Kindly choose the order of derivative.';
        case 'MATLAB:dimagree'
            msg = 'Error : Kindly enetr a window length.';
        case 'MATLAB:filter:notVectorInput'
            msg= 'Error : Kindly enter the order of filter.';
        case 'MATLAB:innerdim'
            msg= 'Error : Kindly enter a window length.';
    end
set(handles.Disp,'String',msg,'ForegroundColor','Red');
guidata(hObject, handles);
end
%MATLAB:filter:notVectorInput
% MATLAB:dimagree
%InvSpec_Functions:der2nd:InvalidRange
% Hints: contents = cellstr(get(hObject,'String')) returns Transform contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Transform


% --- Executes during object creation, after setting all properties.
function Transform_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




%% Part11: Analysis
% --- Executes on selection change in Analysis.
function Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Analysis
guidata(hObject, handles);
set(handles.Disp,'String','Results: ','ForegroundColor','Black');
set(handles.plots_plsr,'Visible','Off');
set(handles.plots_drop,'Visible','Off');
contents = cellstr(get(hObject,'String'));% returns Tools contents as cell array
Tools_choice=contents{get(hObject,'Value')};% returns selected item from Tools
try
    if (strcmp(Tools_choice,'PCA'))
        [handles.XL,handles.XS,handles.expl_var,handles.X,handles.Y,handles.label]= pca_call(hObject,handles);
        cla;
        line_plot_category(handles.label,handles.X,handles.Y);
        set(handles.plots_drop,'Visible','On');
        set(handles.plots_plsr,'Visible','Off');
    elseif(strcmp(Tools_choice,'PLSR'))
        [handles.Xscores,handles.Xloading,handles.PLSPctVar,handles.yfitPLS7,handles.ncomp,handles.X,handles.Y,handles.label] = plsr_call(hObject,handles);
        cla;
        line_plot_category(handles.label,handles.X,handles.Y);
        set(handles.plots_drop,'Visible','Off');
        set(handles.plots_plsr,'Visible','On');
    elseif (strcmp(Tools_choice,'PCR'))

    elseif (strcmp(Tools_choice,'Cluster Analysis'))

    end
catch ME
    id = ME.identifier;
    switch ME.identifier
        case 'stats:pca:WrongNumComponents'
            msg= 'Error : Kindly enter the no. of PCA compoents to compute.';
        case 'stats:plsregress:BadNcomp'
            msg= 'Error : Kindly enter the no. of PLSR factors to compute.';
    end
set(handles.Disp,'String',msg,'ForegroundColor','Red');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Part12: Operations
% --- Executes on selection change in Operations.
function Operations_Callback(hObject, eventdata, handles)
% hObject    handle to Operations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Operations contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Operations
contents = cellstr(get(hObject,'String'));% returns Tools contents as cell array
Tools_choice=contents{get(hObject,'Value')}% returns selected item from Tools

if (strcmp(Tools_choice,'Addition'))
    [WL_A,WL_B,T_A,T_B,outwl,resTX] = addioftwo(hObject,handles);
    plot(WL_B, T_B);
    hold on;
    plot(WL_A,T_A);
    hold on;
    plot(outwl,resTX);
    legend('Signal1','Signal2','Added Signal');
elseif (strcmp(Tools_choice,'Multiplication'))
    [WL_A,WL_B,T_A,T_B,outwl,resTX] = multipli(hObject,handles);
    plot(WL_B, T_B);
    hold on;
    plot(WL_A,T_A);
    hold on;
    plot(outwl,resTX);
    legend('Signal1','Signal2','multiplied Signal');
elseif (strcmp(Tools_choice,'Subtraction'))
    [WL_A,WL_B,T_A,T_B,outwl,resTX] = subtractionoftwo(hObject,handles);
    plot(WL_B, T_B);
    hold on;
    plot(WL_A,T_A);
    hold on;
    plot(outwl,resTX);
    legend('Signal1','Signal2','Subtracted Signal');
end

% --- Executes during object creation, after setting all properties.
function Operations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Operations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%% end

% --- Executes on button press in remove.
function remove_Callback(hObject, eventdata, handles)
% hObject    handle to remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.choice==1 %indicates data selected from data panel
    k=handles.index_selected;
    handles.spec_data=update(handles.spec_data,k);
    handles.listboxItems=update(handles.listboxItems,k);
    handles.val=handles.val-size(k,2);
    set(handles.tablelist,'Value',1);
    set(handles.tablelist,'string',handles.listboxItems);
elseif handles.choice==2
    k=handles.index_selected_set;
    handles.spec_data_set=update(handles.spec_data_set,k);
    handles.listboxItems_set=update(handles.listboxItems_set,k);
    handles.valset=handles.valset-size(k,2);
    set(handles.Data_set,'Value',1);
    set(handles. Data_set,'string',handles.listboxItems_set);
end
guidata(hObject, handles);

% --- Executes on button press in info.
function info_Callback(hObject, eventdata, handles)
% hObject    handle to info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.choice==1
    info_1=strcat('Title :  ',handles.str.data);
    %handles.index_selected
    res=round((handles.data_index(2,1)-handles.data_index(1,1)),3);
    info_2=strcat('Resolution :  ',num2str(res));
elseif handles.choice==2
    info_1=strcat('Title :  ',handles.str.set);
    res=round((handles.data_index_set(2,1)-handles.data_index_set(1,1)),3);
    info_2=strcat('Resolution :  ',num2str(res));
end
D=char(info_1,info_2);
set(handles.Disp,'String',D);


% --- Executes on button press in clearplot.
function clearplot_Callback(hObject, eventdata, handles)
% hObject    handle to clearplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
legend(handles.axes1,'hide');
guidata(hObject, handles)

% --- Executes on selection change in plots_drop.
function plots_drop_Callback(hObject, eventdata, handles)
% hObject    handle to plots_drop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plots_drop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plots_drop
contents = cellstr(get(hObject,'String'));% returns Tools contents as cell array
Tools_choice=contents{get(hObject,'Value')};% returns selected item from Tools
if (strcmp(Tools_choice,'Scores  '))
    gscatter(handles.XS(:,1),handles.XS(:,2),handles.Y);
elseif(strcmp(Tools_choice,'Loadings     '))
    plot(handles.label,handles.XL);   
    xlabel('Xloadings','FontSize',12);
    ylabel('Wavelength','FontSize',12);
elseif (strcmp(Tools_choice,'Expl Var'))
    n=size(handles.XS,2);
    cumsum(handles.expl_var(1:1:n,1));
    plot(1:1:n,cumsum(handles.expl_var(1:1:n,1)),'-ro');
    ylabel('Number of PLS components','FontSize',12);
    xlabel('Percent Variance Explained in X','FontSize',12);
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function plots_drop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plots_drop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in plots_plsr.
function plots_plsr_Callback(hObject, eventdata, handles)
% hObject    handle to plots_plsr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plots_plsr contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plots_plsr
cla;
contents = cellstr(get(hObject,'String'));% returns Tools contents as cell array
Tools_choice=contents{get(hObject,'Value')};% returns selected item from Tools
if (strcmp(Tools_choice,'Explained variance'))
    plot(1:handles.ncomp,cumsum(100*handles.PLSPctVar(2,:)),'-bo');
    xlabel('Number of PLS components','FontSize',12);
    ylabel('Percent Variance Explained in X','FontSize',12);
elseif(strcmp(Tools_choice,'Observed vs fitted'))
    plot(handles.Y,handles.yfitPLS7,'ro');
    xlabel('Observed Response','FontSize',12);
    ylabel('Fitted Response','FontSize',12);
elseif(strcmp(Tools_choice,'Scores            '))
    gscatter(handles.Xscores(:,1),handles.Xscores(:,2),handles.Y); 
elseif(strcmp(Tools_choice,'Loadings'))
    plot(handles.label,handles.Xloading);
    ylabel('Xloadings','FontSize',12);
    xlabel('Wavelength','FontSize',12);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function plots_plsr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plots_plsr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
