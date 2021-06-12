function varargout = Load_Help(varargin)
% LOAD_HELP MATLAB code for Load_Help.fig
%      LOAD_HELP, by itself, creates a new LOAD_HELP or raises the existing
%      singleton*.
%
%      H = LOAD_HELP returns the handle to a new LOAD_HELP or the handle to
%      the existing singleton*.
%
%      LOAD_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOAD_HELP.M with the given input arguments.
%
%      LOAD_HELP('Property','Value',...) creates a new LOAD_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Load_Help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Load_Help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Load_Help

% Last Modified by GUIDE v2.5 29-Jan-2019 18:06:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Load_Help_OpeningFcn, ...
                   'gui_OutputFcn',  @Load_Help_OutputFcn, ...
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


% --- Executes just before Load_Help is made visible.
function Load_Help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Load_Help (see VARARGIN)

% Choose default command line output for Load_Help
handles.output = hObject;
myicon = imread('data.PNG');
handles.img=myicon;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Load_Help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Load_Help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
s=imresize(handles.img,1.5);
imshow(s);
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% imshow(handles.img);

% Hint: place code in OpeningFcn to populate axes1

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Load_Help);
