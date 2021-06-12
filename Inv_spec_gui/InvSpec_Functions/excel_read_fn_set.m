function [Spectra_set,listboxItems_set,valset] = excel_read_fn_set(hObject,handles)
valset=handles.valset+1;
Spectra_set=handles.spec_data;
listboxItems_set=handles.listboxItems_set;
myicon = imread('data.PNG');
Load_Help(myicon);
pause(2);
set = loadfromexcel_set(hObject,handles);
Spectra_set{valset} = [set];
listboxItems_set{valset} = strcat('Data set',num2str(valset));
guidata(hObject, handles);
end

