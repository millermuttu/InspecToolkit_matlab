function moving(hObject,handles)
if handles.choice==1
    n=handles.index_selected;
    str=handles.listboxItems{n};
    WL=handles.data_index(:,1)';
    Spectra=handles.data_index(:,2)';
    X=Spectra;
    prompt = {'Enter the window size of filter:'};
    title = 'Input';
    dims = [1 35];
    definput = {'5'};
    wind = inputdlg(prompt,title,dims,definput);
    windowSize =str2double(wind);
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;
    Y = filter(b,a,X);
    cla;
    legend(handles.axes1,'hide');
    plot(WL,X);
    hold on;
    plot(WL,Y);
    legend('Orginal Spectra','MA Smoothened Spectra');
    k=length(handles.spec_data);
    handles.spec_data{k+1} = [WL',Y'];
    handles.listboxItems{k+1} = strcat(str,'_MA Smoothened');
    set(handles.tablelist,'string',handles.listboxItems);
elseif handles.choice==2
    n=handles.index_selected_set;
    str=handles.listboxItems_set{n};
    label = handles.data_index_set(2:end,1)';%label has to be row
    Y=handles.data_index_set(1,2:end)';
    x=handles.data_index_set(2:end,2:end)';
    prompt = {'Enter the window size of filter:'};
    title = 'Input';
    dims = [1 35];
    definput = {'5'};
    wind = inputdlg(prompt,title,dims,definput);
    windowSize =str2double(wind);
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;
    X = filter(b,a,x');
    cla;
    legend(handles.axes1,'hide');
    line_plot_category(label,X',Y);
    legend('MA Smoothened Spectra');
    k=handles.valset;
    handles.data_index_set(2:end,2:end)=X;
    handles.data_index_set(2:end,1)=label';
    handles.data_index_set(1,2:end)=Y';
    handles.spec_data_set{k+1} =handles.data_index_set;
    handles.listboxItems_set{k+1} = strcat(str,'_MA Smoothened');
    handles.valset=handles.valset+1;
    set(handles. Data_set,'string',handles.listboxItems_set);
end
guidata(hObject, handles);
end

