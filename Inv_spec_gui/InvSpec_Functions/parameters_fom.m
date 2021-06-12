function varargout = parameters_fom(varargin)
% PARAMETERS_FOM MATLAB code for parameters_fom.fig
%      PARAMETERS_FOM, by itself, creates a new PARAMETERS_FOM or raises the existing
%      singleton*.
%
%      H = PARAMETERS_FOM returns the handle to a new PARAMETERS_FOM or the handle to
%      the existing singleton*.
%
%      PARAMETERS_FOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMETERS_FOM.M with the given input arguments.
%
%      PARAMETERS_FOM('Property','Value',...) creates a new PARAMETERS_FOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before parameters_fom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to parameters_fom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help parameters_fom

% Last Modified by GUIDE v2.5 30-Jan-2019 17:14:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @parameters_fom_OpeningFcn, ...
                   'gui_OutputFcn',  @parameters_fom_OutputFcn, ...
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


% --- Executes just before parameters_fom is made visible.
function parameters_fom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to parameters_fom (see VARARGIN)

% Choose default command line output for parameters_fom
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes parameters_fom wait for user response (see UIRESUME)
uiwait(handles.figure1);



% --- Executes on selection change in lb1.
function lb1_Callback(hObject, eventdata, handles)
% hObject    handle to lb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% IPA
% Water
% ETH
contents = cellstr(get(hObject,'String'));% returns lb1 contents as cell array
choice=contents{get(hObject,'Value')};% returns selected item from lb1
if (strcmp(choice,'IPA'))
    index=1;
elseif (strcmp(choice,'Water'))
    index=2;
elseif (strcmp(choice,'ETH'))
    index=3;
end
handles.index =index;
guidata(hObject, handles);
%varargout{1} = getappdata(hObject,'a');
%handles.varargout(1) = a;



% --- Executes during object creation, after setting all properties.
function lb1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb2.
function lb2_Callback(hObject, eventdata, handles)
% hObject    handle to lb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'));% returns lb1 contents as cell array
choice=contents{get(hObject,'Value')};% returns selected item from lb2
% Spectra type
% Raw data
% Transmittance
% Absorbance


if (strcmp(choice,'Raw data'))
    index_new=1;
elseif (strcmp(choice,'Transmittance'))
   index_new=2;
elseif (strcmp(choice,'Absorbance'))
    index_new=3;
end
handles.index_new=index_new;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function lb2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Outputs from this function are returned to the command line.
function varargout = parameters_fom_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
% varargout{1}=get(handles.a,'value');
varargout{1}=handles.index;
varargout{2}=handles.index_new;
delete(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(get(hObject,'waitstatus'),'waiting')
    uiresume(hObject);
else
% Hint: delete(hObject) closes the figure
delete(hObject);
end
