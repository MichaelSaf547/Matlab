function varargout = Traffic_Light(varargin)
% TRAFFIC_LIGHT MATLAB code for Traffic_Light.fig
%      TRAFFIC_LIGHT, by itself, creates a new TRAFFIC_LIGHT or raises the existing
%      singleton*.
%
%      H = TRAFFIC_LIGHT returns the handle to a new TRAFFIC_LIGHT or the handle to
%      the existing singleton*.
%
%      TRAFFIC_LIGHT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAFFIC_LIGHT.M with the given input arguments.
%
%      TRAFFIC_LIGHT('Property','Value',...) creates a new TRAFFIC_LIGHT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Traffic_Light_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Traffic_Light_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Traffic_Light

% Last Modified by GUIDE v2.5 29-Jan-2022 19:53:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Traffic_Light_OpeningFcn, ...
                   'gui_OutputFcn',  @Traffic_Light_OutputFcn, ...
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


% --- Executes just before Traffic_Light is made visible.
function Traffic_Light_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Traffic_Light (see VARARGIN)

% Choose default command line output for Traffic_Light
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.Manual,'enable','off');  
set(handles.Submit,'enable','off');  
set(handles.Automatic,'enable','off'); 
set(handles.Red,'enable','off');  
set(handles.Yellow,'enable','off');  
set(handles.Green,'enable','off'); 
set(handles.People,'enable','off');  
set(handles.Cars,'enable','off'); 

set(handles.Counter, 'String' , "00");
set(handles.Counter, 'enable', 'off')
set(handles.Car_Text, 'enable', 'off')
set(handles.People_Text, 'enable', 'off')

set(handles.Traffic_Image,'visible', 'off');

clear all;
global a;    
a = arduino();
configurePin(a,'D3','DigitalOutput'); %green
configurePin(a,'D4','DigitalOutput'); %yellow
configurePin(a,'D5','DigitalOutput'); %red
configurePin(a,'D7','DigitalOutput'); %blue cars
configurePin(a,'D8','DigitalOutput'); %white people

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D7',0);
writeDigitalPin(a,'D8',0);

global CrossImage;
CrossImage = imread('crossings.png');

global NoCrossImage;
NoCrossImage = imread('nocrossing.png');

global Auto;
Auto = false;

% UIWAIT makes Traffic_Light wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Traffic_Light_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Automatic.
function Automatic_Callback(hObject, eventdata, handles)
% hObject    handle to Automatic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Car_Text, 'enable', 'on')
set(handles.People_Text, 'enable', 'on')
% Hint: get(hObject,'Value') returns toggle state of Automatic


% --- Executes on button press in Manual.
function Manual_Callback(hObject, eventdata, handles)
% hObject    handle to Manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Car_Text, 'enable', 'off')
set(handles.People_Text, 'enable', 'off')
% Hint: get(hObject,'Value') returns toggle state of Manual



function Car_Text_Callback(hObject, eventdata, handles)
% hObject    handle to Car_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=get(hObject,'String');
if ~all(ismember(str, '1234567890'))
	set(hObject,'string','0');
    warndlg('Input must be Integers');
end
% Hints: get(hObject,'String') returns contents of Car_Text as text
%        str2double(get(hObject,'String')) returns contents of Car_Text as a double


% --- Executes during object creation, after setting all properties.
function Car_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Car_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function People_Text_Callback(hObject, eventdata, handles)
% hObject    handle to People_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=get(hObject,'String');
if ~all(ismember(str, '1234567890'))
	set(hObject,'string','0');
    warndlg('Input must be Integers');
end
% Hints: get(hObject,'String') returns contents of People_Text as text
%        str2double(get(hObject,'String')) returns contents of People_Text as a double


% --- Executes during object creation, after setting all properties.
function People_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to People_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Submit.
function Submit_Callback(hObject, eventdata, handles)
% hObject    handle to Submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.MainMode,'enable','on');
if handles.Manual.Value == 1
    set(handles.Red,'enable','on');  
    set(handles.Yellow,'enable','on');  
    set(handles.Green,'enable','on');
    set(handles.People,'enable','on');  
    set(handles.Cars,'enable','on'); 
    
    set(handles.Car_Text, 'enable', 'off');
    set(handles.People_Text, 'enable', 'off');
    set(handles.Manual,'enable','off');  
    set(handles.Submit,'enable','off');  
    set(handles.Automatic,'enable','off'); 
    
else
    global Auto;
    global a;
    global NoCrossImage;
    global CrossImage;
    
        
    Auto = true;
    set(handles.Red,'enable','off');  
    set(handles.Yellow,'enable','off');  
    set(handles.Green,'enable','off');
    
    set(handles.Traffic_Image,'visible', 'on');
    
    Cars_Length = str2num(get(handles.Car_Text,'String'));
    if Cars_Length > 500
        Cars_Length = 500;
        warndlg('Cars time is 500(Max)');
    elseif Cars_Length < 10
        Cars_Length = 10;
        warndlg('Cars time is 10(Min)');
    end
    
    People_Length = str2num(get(handles.People_Text,'String'));
    if People_Length > 200
        People_Length = 200;
        warndlg('People time is 200(Max)');
    elseif People_Length < 10
        People_Length = 10;
        warndlg('People time is 10(Min)');
    end
    
    set(handles.Counter, 'enable', 'on')
    
    set(handles.Manual,'enable','off');  
    set(handles.Submit,'enable','off');  
    set(handles.Automatic,'enable','off'); 
    set(handles.Car_Text, 'enable', 'off')
    set(handles.People_Text, 'enable', 'off')
    
    writeDigitalPin(a,'D7',1);
    
    while Auto == true
        
        writeDigitalPin(a,'D3',1);
        writeDigitalPin(a,'D4',0);
        writeDigitalPin(a,'D5',0);
        
        axes(handles.Traffic_Image);
        imshow(NoCrossImage);
        
        for Itr = Cars_Length: -1: 1
            if Auto == false
                break;
            end
            set(handles.Counter, 'String' , num2str(Itr), 'foreground', [0, 1, 0]);
            pause(1)
        end
        
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D4',1);
        writeDigitalPin(a,'D5',0);
        
        if Auto == true
            set(handles.Counter, 'String' , '00', 'foreground', [1, 1, 0]);
            pause(1);
        end
            
        
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D4',0);
        writeDigitalPin(a,'D5',1);
        
        axes(handles.Traffic_Image);
        imshow(CrossImage);
        
        for Itr = People_Length: -1: 1
            if Auto == false
                break;
            end
            set(handles.Counter, 'String' , num2str(Itr), 'foreground', [1, 0, 0]);
            pause(1)
        end
        
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D4',1);
        writeDigitalPin(a,'D5',0);
        
        if Auto == true
            set(handles.Counter, 'String' , '00', 'foreground', [1, 1, 0]);
            pause(1); 
        end 

    end
    
    writeDigitalPin(a,'D3',0);
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D5',0);
    
end


% --- Executes on button press in MainMode.
function MainMode_Callback(hObject, eventdata, handles)
% hObject    handle to MainMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.MainMode,'enable','off');  
set(handles.Counter, 'enable', 'off');
set(handles.People,'enable','off');  
set(handles.Cars,'enable','off'); 
set(handles.Red,'enable','off');  
set(handles.Yellow,'enable','off');  
set(handles.Green,'enable','off');
global Auto;
Auto = false;
set(handles.Manual,'enable','on');  
set(handles.Submit,'enable','on');  
set(handles.Automatic,'enable','on'); 
set(handles.Counter, 'String' , "00");

global a;

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
writeDigitalPin(a,'D7',0);
writeDigitalPin(a,'D8',0);


% --- Executes during object creation, after setting all properties.
function Counter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Counter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Cars.
function Cars_Callback(hObject, eventdata, handles)
% hObject    handle to Cars (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;

writeDigitalPin(a,'D7',1);
writeDigitalPin(a,'D8',0);
% Hint: get(hObject,'Value') returns toggle state of Cars


% --- Executes on button press in People.
function People_Callback(hObject, eventdata, handles)
% hObject    handle to People (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;

writeDigitalPin(a,'D7',0);
writeDigitalPin(a,'D8',1);
% Hint: get(hObject,'Value') returns toggle state of People


% --- Executes on button press in Red.
function Red_Callback(hObject, eventdata, handles)
% hObject    handle to Red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a;

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',1);

% Hint: get(hObject,'Value') returns toggle state of Red


% --- Executes on button press in Yellow.
function Yellow_Callback(hObject, eventdata, handles)
% hObject    handle to Yellow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;

writeDigitalPin(a,'D3',0);
writeDigitalPin(a,'D4',1);
writeDigitalPin(a,'D5',0);
% Hint: get(hObject,'Value') returns toggle state of Yellow


% --- Executes on button press in Green.
function Green_Callback(hObject, eventdata, handles)
% hObject    handle to Green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;

writeDigitalPin(a,'D3',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D5',0);
% Hint: get(hObject,'Value') returns toggle state of Green
