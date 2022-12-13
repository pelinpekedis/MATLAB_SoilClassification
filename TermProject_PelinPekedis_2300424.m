function varargout = TermProject_PelinPekedis_2300424(varargin)
% TERMPROJECT_PELINPEKEDIS_2300424 MATLAB code for TermProject_PelinPekedis_2300424.fig
%      TERMPROJECT_PELINPEKEDIS_2300424, by itself, creates a new TERMPROJECT_PELINPEKEDIS_2300424 or raises the existing
%      singleton*.
%
%      H = TERMPROJECT_PELINPEKEDIS_2300424 returns the handle to a new TERMPROJECT_PELINPEKEDIS_2300424 or the handle to
%      the existing singleton*.
%
%      TERMPROJECT_PELINPEKEDIS_2300424('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TERMPROJECT_PELINPEKEDIS_2300424.M with the given input arguments.
%
%      TERMPROJECT_PELINPEKEDIS_2300424('Property','Value',...) creates a new TERMPROJECT_PELINPEKEDIS_2300424 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TermProject_PelinPekedis_2300424_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TermProject_PelinPekedis_2300424_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TermProject_PelinPekedis_2300424

% Last Modified by GUIDE v2.5 13-Dec-2022 23:56:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TermProject_PelinPekedis_2300424_OpeningFcn, ...
                   'gui_OutputFcn',  @TermProject_PelinPekedis_2300424_OutputFcn, ...
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
end

% --- Executes just before TermProject_PelinPekedis_2300424 is made visible.
function TermProject_PelinPekedis_2300424_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TermProject_PelinPekedis_2300424 (see VARARGIN)

% Choose default command line output for TermProject_PelinPekedis_2300424
handles.output = hObject;

%global variables decleration:
% global order;
% order=[];
global filename_t;
global filepath_t;
filename_t="";
filepath_t="";
global soil_1;
global soil_2;
global soil_3;
global soil_4;
global soil_5;
global soil_6;

soil_1=[];soil_2=[];soil_3=[];soil_4=[];soil_5=[];soil_6=[];soil_7=[];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TermProject_PelinPekedis_2300424 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = TermProject_PelinPekedis_2300424_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


% --- Executes on button press in delete_push.
function delete_push_Callback(hObject, eventdata, handles)
% hObject    handle to delete_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rank=get(handles.popup1,'Value');
selection=handles.popup1.String(rank);
quest=strcat('Do you really want to delete ',{' '},selection,{' '},'? This action cannot be undone.');
answer=questdlg(quest ,'Confirm to delete','Yes','No','No');
if answer=='Yes'
    delete(handles.g1);
    delete(handles.g2);
    delete(handles.g3);
    delete(handles.g4);
    rank=get(handles.popup1,'Value');
    sz= size(handles.popup1.String);
    sz(1);
    if sz(1)==1
        handles.popup1.String={[]};
        handles.filename(rank+1)=[];
        set(handles.summary_table,'Data',{});
        axes(handles.axes1);
        cla reset
        axes(handles.axes2);
        cla reset
        axes(handles.axes3);
        cla reset
        axes(handles.axes5);
        cla reset
        guidata(hObject, handles);
        return
    elseif sz(1)==rank
        handles.filename(end)=[];
        set(handles.popup1, 'Value',1);
        handles.popup1.String(end)=[];
        set(handles.summary_table,'Data',{});
        guidata(hObject, handles);
        popup1_Callback(hObject, eventdata, handles);
    else  
        handles.filename(rank+1)=[];
        handles.popup1.String(rank)=[]
        guidata(hObject, handles);
        set(handles.summary_table,'Data',{});
        popup1_Callback(hObject, eventdata, handles);
    end

    guidata(hObject, handles);
else
    return
end
guidata(hObject, handles);
end




% --- Executes on selection change in popup1.
function popup1_Callback(hObject, eventdata, handles)
% hObject    handle to popup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rank=get(handles.popup1,'Value'); %getting the order number of chosen test in popup
filename=handles.filename(rank+1); %reaching the corresponding filename
%the reason of +1 is the first element of the array is empty and then the filenames come


data=readlines(filename); % I choose to read data like plain text
[r,c]=find(data=='#EOH=');   %I investigated .gef files and showed that the required data for plotting comes after "#EOH="
[totalr, totalc]=size(data);
req_data=data((r+1):(totalr-1),c);   %extracting data for plotting
data_string=split(req_data());   %spliting the string
[rp,cp]=find(contains(data,'#COLUMN='));   %to find how many columns are there in the results of experiment
p1=split(data(rp,cp));
number_of_columns=str2num(p1(2));

format long
data_new=str2double(data_string());   %string to number

data_new=data_new(:,(1:number_of_columns));   %extracting CPT data in a useful format

% Getting titles and units in case of a need afterwards:
for i=1:number_of_columns
    str{i}=sprintf('#COLUMNINFO= %d',i);   %when I open the .gef file, I saw that '#COLUMNINFO=' part is common
    [r4(i),c4(i)]=find(contains(data,str{i}));
    p4=strip(split(data(r4(i),c4(i)),','));
    titles{i}=[p4{3} '(' p4{2} ')'];
    units{i}=p4{2};
end

depth=data_new(:,1).*-1;   %multiplying with -1 to show distance below ground
qc=data_new(:,2);
friction=data_new(:,3).*1000;  %kPa
u2=data_new(:,6).*1000; %kPa
handles.depth=depth;
handles.qc=qc;
handles.friction=friction;
handles.u2=u2;

%max,min values and their indices was found to mark in graphs:
[max_qc,imaxqc] = max(qc);
[max_fr,imaxfr] = max(friction);
[max_u2,imaxu2] = max(u2);

[min_qc,iminqc] = min(qc);
[min_fr,iminfr] = min(friction);
[min_u2,iminu2] = min(u2);

handles.max_qc=max_qc;
handles.max_fr=max_fr;
handles.max_u2=max_u2;

handles.min_qc=min_qc;
handles.min_fr=min_fr;
handles.min_u2=min_u2;

guidata(hObject, handles);

global soil_1;
global soil_2;
global soil_3;
global soil_4;

fr_r=friction./(qc.*1000); %to determine soil profile

general=[];
for i=1:size(qc)
    if fr_r(i)<0.02      %clean sand
        soil_1(end+1)=i;
        general(i)=1;
        
    elseif fr_r(i)<0.04   %clayey sand and silt
        soil_2(end+1)=i;
        general(i)=2;
        
    elseif fr_r(i)<0.05   %silty and sandy clay
        soil_3(end+1)=i;
        general(i)=3;
       
    else
        soil_4(end+1)=i;   %clay
        general(i)=4;
       
    end
end

%scatter of soil profile:
axes(handles.axes5)
g4=scatter(general,depth,3);
handles.g4=g4;

%plotting graphs:
axes(handles.axes1);
g1=plot(qc,depth,'r',max_qc,depth(imaxqc),'m<',min_qc,depth(iminqc),'m>');
xlabel('Cone Resistance [MPa]');
ylabel('Depth [m]');
handles.g1=g1;
axes(handles.axes2);
g2=plot(friction,depth,'g',max_fr,depth(imaxfr),'m<',min_fr,depth(iminfr),'m>');
xlabel('Sleeve Friction [kPa]')
handles.g2=g2;
axes(handles.axes3);
g3=plot(u2,depth, max_u2,depth(imaxu2),'m<',min_u2,depth(iminu2),'m>');
xlabel('Pore Water Pressure [MPa]');
handles.g3=g3;


data_table = {handles.max_qc, handles.min_qc;handles.max_fr, handles.min_fr;handles.max_u2, handles.min_u2};  %data for summary table

for i=1:3
    for j=1:2
        X{i,j}=sprintf('%.2f',data_table{i,j});    % in order to display the numbers with 2 decimal point.
        if i==1
            data_table1{i,j}= strcat(X{i,j},' [',units{2},']');  %adding units to the end
        elseif i==2
            data_table1{i,j}= strcat(X{i,j},' [kPa]');
        else
            data_table1{i,j}= strcat(X{i,j},' [kPa]');
        end
    end
end

set(handles.summary_table,'Data',data_table1);  %setting the cells of summary table

guidata(hObject, handles);
end

% Hints: contents = cellstr(get(hObject,'String')) returns popup1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup1


% --- Executes during object creation, after setting all properties.
function popup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);
end


function ID_input_Callback(hObject, eventdata, handles)
% hObject    handle to ID_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ID=get(hObject,'String');
handles.ID=ID;
guidata(hObject, handles);


guidata(hObject, handles);
end
% Hints: get(hObject,'String') returns contents of ID_input as text
%        str2double(get(hObject,'String')) returns contents of ID_input as a double


% --- Executes during object creation, after setting all properties.
function ID_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ID_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in input_push.
function input_push_Callback(hObject, eventdata, handles)
% hObject    handle to input_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.ID_input.String ==""
    msgbox("Please enter a Test ID!","No Test ID","warn");    %warning message
    return
end

if ismember(handles.ID_input.String,handles.popup1.String)  %warning message about same ID
    msgbox("A test with the same ID has already been entered. Please give a different test ID.", "Same Test ID", "warn") 
    return
end

[filename, filepath]=uigetfile('*.gef','MultiSelect','off');    %opens windows file browser
if filepath==0    % controls whether a file was chosen
    set(handles.text3, 'String', 'No Input Selected!');
    set(handles.text3,'ForegroundColor','r');
    return
else
    set(handles.text3, 'String', 'Success!');
    set(handles.text3,'ForegroundColor','g');
end

%to use it later when a test chosen in pop up, the filenames and filepaths should be stored globally
global filename_t;
global filepath_t;
filename_t=[filename_t,filename];
filepath_t=[filepath_t,filepath];
handles.filename=filename_t;
handles.filepath=filepath_t;

%adding new test IDs to pop up menu:
handles.first1=handles.popup1.String;
handles.choice=handles.ID;
handles.popup1.String{end+1}=handles.choice;
var1=handles.popup1.String;

set(handles.popup1, 'Value', length(var1));

data=readlines(filename); % I choose to read data like plain text
[r,c]=find(data=='#EOH=');   %I investigated .gef files and showed that the required data for plotting comes after "#EOH="
[totalr, totalc]=size(data);
req_data=data((r+1):(totalr-1),c);   %extracting data for plotting
data_string=split(req_data());   %spliting the string
[rp,cp]=find(contains(data,'#COLUMN='));   %to find how many columns are there in the results of experiment
p1=split(data(rp,cp));
number_of_columns=str2num(p1(2));

format long
data_new=str2double(data_string());   %string to number
% [rn,cn]=size(data_new);
data_new=data_new(:,(1:number_of_columns));   %extracting CPT data in a useful format

% Getting titles and units in case of a need afterwards:
for i=1:number_of_columns
    str{i}=sprintf('#COLUMNINFO= %d',i);   %when I open the .gef file, I saw that '#COLUMNINFO=' part is common
    [r4(i),c4(i)]=find(contains(data,str{i}));
    p4=strip(split(data(r4(i),c4(i)),','));
    titles{i}=[p4{3} '(' p4{2} ')'];
    units{i}=p4{2};
end

depth=data_new(:,1).*-1;   %multiplying with -1 to show distance below ground
qc=data_new(:,2);
friction=data_new(:,3).*1000;  %kPa
u2=data_new(:,6).*1000; %kPa
handles.depth=depth;
handles.qc=qc;
handles.friction=friction;
handles.u2=u2;

%max,min values and their indices was found to mark in graphs:
[max_qc,imaxqc] = max(qc);
[max_fr,imaxfr] = max(friction);
[max_u2,imaxu2] = max(u2);

[min_qc,iminqc] = min(qc);
[min_fr,iminfr] = min(friction);
[min_u2,iminu2] = min(u2);

handles.max_qc=max_qc;
handles.max_fr=max_fr;
handles.max_u2=max_u2;

handles.min_qc=min_qc;
handles.min_fr=min_fr;
handles.min_u2=min_u2;

guidata(hObject, handles);

global soil_1;
global soil_2;
global soil_3;
global soil_4;

fr_r=friction./(qc.*1000); %to determine soil profile

general=[];
for i=1:size(qc)
    if fr_r(i)<0.02      %clean sand
        soil_1(end+1)=i;
        general(i)=1;
        
    elseif fr_r(i)<0.04   %clayey sand and silt
        soil_2(end+1)=i;
        general(i)=2;
        
    elseif fr_r(i)<0.05   %silty and sandy clay
        soil_3(end+1)=i;
        general(i)=3;
       
    else
        soil_4(end+1)=i;   %clay
        general(i)=4;
       
    end
end

%scatter of soil profile:
axes(handles.axes5)
g4=scatter(general,depth,3);
handles.g4=g4;

%plotting data:
axes(handles.axes1)
g1=plot(qc,depth,'r',max_qc,depth(imaxqc),'m<',min_qc,depth(iminqc),'m>');
xlabel('Cone Resistance [MPa]')
ylabel('Depth [m]')
handles.g1=g1;
axes(handles.axes2)
g2=plot(friction,depth,'g',max_fr,depth(imaxfr),'m<',min_fr,depth(iminfr),'m>');
xlabel('Sleeve Friction [kPa]')
handles.g2=g2;
axes(handles.axes3)
g3=plot(u2,depth, max_u2,depth(imaxu2),'m<',min_u2,depth(iminu2),'m>');
xlabel('Pore Water Pressure [MPa]')
handles.g3=g3;


data_table = {handles.max_qc, handles.min_qc;handles.max_fr, handles.min_fr;handles.max_u2, handles.min_u2};  %data for summary table

for i=1:3
    for j=1:2
        X{i,j}=sprintf('%.2f',data_table{i,j});    % in order to display the numbers with 2 decimal point.
        if i==1
            data_table1{i,j}= strcat(X{i,j},' [',units{2},']');  %adding units to the end
        elseif i==2
            data_table1{i,j}= strcat(X{i,j},' [kPa]');
        else
            data_table1{i,j}= strcat(X{i,j},' [kPa]');
        end
    end
end

set(handles.summary_table,'Data',data_table1);  %setting the cells of summary table

guidata(hObject, handles);

end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end
% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)

% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.text3=get(hObject,'String');
guidata(hObject, handles);
end


% --- Executes when entered data in editable cell(s) in summary_table.
function summary_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to summary_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
% data_table = [handles.max_qc, handles.min_qc;handles.max_fr, handles.min_fr;handles.max_u2 ,handles.min_u2]
% set(handles.summary_table,'data',data_table];

guidata(hObject, handles);
end




% --- Executes when selected cell(s) is changed in summary_table.
function summary_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to summary_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
end
