function varargout = mactel_gui_new(varargin)

% Run this file!

%%

% MACTEL_GUI_NEW MATLAB code for mactel_gui_new.fig
%      MACTEL_GUI_NEW, by itself, creates a new MACTEL_GUI_NEW or raises the existing
%      singleton*.
%
%      H = MACTEL_GUI_NEW returns the handle to a new MACTEL_GUI_NEW or the handle to
%      the existing singleton*.
%
%      MACTEL_GUI_NEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MACTEL_GUI_NEW.M with the given input arguments.
%
%      MACTEL_GUI_NEW('Property','Value',...) creates a new MACTEL_GUI_NEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mactel_gui_new_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mactel_gui_new_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mactel_gui_new

% Last Modified by GUIDE v2.5 08-Jul-2016 23:51:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mactel_gui_new_OpeningFcn, ...
                   'gui_OutputFcn',  @mactel_gui_new_OutputFcn, ...
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


% --- Executes just before mactel_gui_new is made visible.
function mactel_gui_new_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mactel_gui_new (see VARARGIN)

% Choose default command line output for mactel_gui_new
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mactel_gui_new wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mactel_gui_new_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global answer;
global files_ab;
global folder_ab;

if ~isempty(answer)
    [files_ab, folder_ab, ~] = uigetfile('*.jpg','MultiSelect','on'); 
end


% --- Executes on button press in pushbutton1.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global answer;
global files_n;
global folder_n;

if ~isempty(answer)
    [files_n, folder_n, ~] = uigetfile('*.jpg','MultiSelect','on');
end

% --- Executes on button press in pushbutton2.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global answer;
global files_ab;
global folder_ab;
global files_n;
global images;

mkdir Reports;
images = generate_report(files_ab, files_n, folder_ab, answer);
msgbox({'Operation Completed' 'Check the report'});


% --- Executes on button press in pushbutton3.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear;
mactel_gui_new;


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global answer;

answer = get(hObject,'String');
answer = cellstr(answer);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
