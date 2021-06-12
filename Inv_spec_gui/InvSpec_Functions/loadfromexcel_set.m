function [set] = loadfromexcel_set(hObject,handles)
% prompt = {'Here is how Excel import works: ' '';...
%         '1) Select Excel file.' '';...
%         '2) Go to the opened Excel file (new window).' '';...
%         '3) Select the data to import (cell selection).' '';...
%         '    - Empty cells are allowed in the selection.' '';...
%         '4) Press OK in the dialog.' '';...
%         'Dont''t tell me again.' 'ExcelMessage'};
%     
%     % Window name
% name = 'Import Excel guide';
%     
%     % Objects
% formats = struct('type', {}, 'style', {}, 'items', {}, ...
%         'format', {}, 'limits', {}, 'size', {});
% formats(2,1).type = 'text';
% formats(2,2).type = 'text';
% formats(3,2).type = 'text';
% formats(4,2).type = 'text';
% formats(5,2).type = 'text';
% formats(6,2).type = 'text';
% formats(7,1).type = 'check';
%     
%     % Default answers
% DefAns.ExcelMessage = false;
% options.CancelButton = 'on';
%     
% % Dialog
% [answer, cancelled] = myinputsdlg(prompt, name, formats, DefAns, options); % Open dialog box
% if cancelled == 1
%     return
% end
% 
% if answer.ExcelMessage % Update default settings structure
%     handles.settings.loaddata.ExcelMessage = 0; % Set new setting
%     guidata(handles.figure1,handles) % Update handles structure
%     saveDefaultSettings(handles); % Save default settings file
% end

%% Select file

filter = {'*.xls;*.xlsx;*.xlsm' 'Excel formats';...
    '*' 'All files'};
[filename,dir,chose] = uigetfile3('excel',filter,'Open Excel file','ExcelProject.xlsx','off');
if chose == 0
    return
end

%% Import from Excel. This will open the Excel file and wait for

% user-selection
[temp,txt,raw] = xlsread(fullfile(dir,filename),-1); % temp is the numeric data found in the selected cells
if isempty(temp)
    return
elseif size(temp,2)<2 || size(temp,1)<5
    mymsgbox('Too few cells selected. You must select at least two columns and five rows.')
    return
end
% listboxlistboxItems{1}=handles.Demo_1;
% handles.data_index{0}=handles.Demo_1;
if size(temp,2)>1
    set=temp;
end
% set(handles.tablelist,'string',listboxItems);
guidata(hObject, handles);
