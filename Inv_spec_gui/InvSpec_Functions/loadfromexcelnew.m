function [Spectra,listboxItems,val,Spectra_set,listboxItems_set,valset] = loadfromexcelnew(hObject,handles)
d = {'Load Demo Data ','Load Data from Excel','Load Data Set Demo','Load Data Set'...
    };
[index,tf] = listdlg('PromptString','Select the type of input:','ListString',d,'listsize',[150 70]);
%initialising values
Spectra=handles.spec_data;
listboxItems=handles.listboxItems;
Spectra_set=handles.spec_data_set;
listboxItems_set=handles.listboxItems_set;
val=handles.val;
valset=handles.valset;
if index==1;%demo data load
    Spectra{val+1} = handles.Demo_1;
    Spectra{val+2} = handles.Demo_2;
    listboxItems{val+1} = strcat('Demo_1');
    listboxItems{val+2} = strcat('Demo_2');
    val=val+2;
    handles.val=val;
    handles.spec_data=Spectra;
    handles.listboxItems=listboxItems;
    set(handles.tablelist,'string',listboxItems);
elseif index==2;%indv data load
    [Spectra,listboxItems,val]=excel_read_fn_uni(hObject,handles);
    handles.val=val;
    handles.spec_data=Spectra;
    handles.listboxItems=listboxItems;
    set(handles.tablelist,'string',listboxItems);
elseif index==3;%data set demo load
    valset=valset+1;
    handles.valset=valset;
    data=handles.DataSet_demo;
    Spectra_set{valset}=data;
    handles.spec_data_set=Spectra_set;
    listboxItems_set{valset} = strcat('Data_Set_Demo',num2str(valset));
    handles.listboxItems_set=listboxItems_set;
    set(handles.Data_set,'string',listboxItems_set);
elseif index==4;%data set load
    [Spectra_set,listboxItems_set,valset]=excel_read_fn_set(hObject,handles);
    handles.valset=valset;
    handles.spec_data_set=Spectra_set;
    handles.listboxItems_set=listboxItems_set;
    set(handles.Data_set,'string',listboxItems_set);
end
guidata(hObject, handles);
end

% for list = 1:size(Spectra,2) %iterate through the struct
%     str = strcat('spectra',num2str(liat))
%     set(handles.tablelist,'string',str);
%     guidata(hObject, handles);
% %     set(handles.tablelist,sprintf('%s_%d','spectra',list),Spectra{list}); 
% end


