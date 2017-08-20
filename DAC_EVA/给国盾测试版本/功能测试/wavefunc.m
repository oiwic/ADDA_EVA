function varargout = wavefunc(varargin)
% WAVEFUNC MATLAB code for wavefunc.fig
%      WAVEFUNC, by itself, creates a new WAVEFUNC or raises the existing
%      singleton*.
%
%      H = WAVEFUNC returns the handle to a new WAVEFUNC or the handle to
%      the existing singleton*.
%
%      WAVEFUNC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVEFUNC.M with the given input arguments.
%
%      WAVEFUNC('Property','Value',...) creates a new WAVEFUNC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wavefunc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wavefunc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wavefunc

% Last Modified by GUIDE v2.5 20-Apr-2017 21:44:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wavefunc_OpeningFcn, ...
                   'gui_OutputFcn',  @wavefunc_OutputFcn, ...
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


% --- Executes just before wavefunc is made visible.
function wavefunc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wavefunc (see VARARGIN)

% Choose default command line output for wavefunc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes wavefunc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wavefunc_OutputFcn(hObject, eventdata, handles) 
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
da_ip = get(handles.edit1,'String');
da = USTCDAC(da_ip,80);
da.Open()
waveobj = waveform();
da.StartStop(240);
for style = 0:2
    switch style
        case 0;wave = waveobj.generate_sine();
        case 1;wave = waveobj.generate_squr();
        otherwise ;wave = waveobj.generate_raw();
    end
    seq = waveform.generate_seq(length(wave));
    for k = 1:4
        da.WriteWave(k,0,wave);
        da.WriteSeq(k,0,seq);
    end
    da.StartStop(15);
    da.CheckStatus();
    pause(2);
end
da.StartStop(240);
da.CheckStatus();
da.Close();


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
da_ip = get(handles.edit1,'String');
da = USTCDAC(da_ip,80);
da.set('ismaster',1);
da.Open()
da.SetTrigCount(5000);
da.SetTrigSel(0);
da.SetTrigDelay(560);
waveobj = waveform();
wave = waveobj.generate_squr();
for k = 1:4
    da.WriteWave(k,0,[wave,ones(1,16)*32767]);
end

for delay  = 0:4:31
    seq = waveform.generate_trig_seq(length(wave),delay);
    for k = 1:4
        da.WriteSeq(k,0,seq);
    end
    da.StartStop(15);
    da.CheckStatus();
    da.SendIntTrig();
    pause(2);
end
da.StartStop(240);
da.CheckStatus();
da.Close();



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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
