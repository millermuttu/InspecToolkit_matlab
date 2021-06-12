function sg_derivative(hObject,handles)
if handles.choice==1
    d = {'SG 1st derivative','SG 2nd derivative',...
        };
    [index,tf] = listdlg('PromptString','Select the number of input:','ListString',d,'listsize',[150 50]); 
    n=handles.index_selected;
    str=handles.listboxItems{n};
    WL=handles.data_index(:,1)';
    Spectra=handles.data_index(:,2)';
    X=Spectra;
    if index==1
        msg='SG_1st_derivative';
        prompt = {'Enter the order of filter:'};
        title = 'Input';
        dims = [1 35];
        definput = {'2'};
        order = inputdlg(prompt,title,dims,definput);
        order=str2double(order);
        prompt1 = {'Enter the window size of filter:'};
        title = 'Input';
        dims = [1 35];
        definput = {'5'};
        window = inputdlg(prompt1,title,dims,definput);
        window=str2double(window);
        X_1st_der = der1st(X, order, window);
        Y=X_1st_der;
    elseif index==2;
        msg='SG_2nd_derivative';
        prompt = {'Enter the order of filter:'};
        title = 'Input';
        dims = [1 35];
        definput = {'2'};
        order = inputdlg(prompt,title,dims,definput);
        order=str2double(order);
        prompt1 = {'Enter the window size of filter:'};
        title = 'Input';
        dims = [1 35];
        definput = {'5'};
        window = inputdlg(prompt1,title,dims,definput);
        window=str2double(window);
        X_2nd_der = der2nd(X, order, window);
        Y=X_2nd_der;
    end
    cla;
    legend(handles.axes1,'hide');
    plot(WL,X);
    legend('Orginal Spectra');
    hold on;
    plot(WL,Y);
    legend('Orginal Spectra',msg);
    k=length(handles.spec_data);
    handles.spec_data{k+1} = [WL',Y'];
    handles.listboxItems{k+1} = strcat(str,'_',msg);
    set(handles.tablelist,'string',handles.listboxItems);
elseif handles.choice==2
    d = {'SG 1st derivative','SG 2nd derivative',...
        };
    [index,tf] = listdlg('PromptString','Select the number of input:','ListString',d,'listsize',[150 50]);
    n=handles.index_selected_set;
    str=handles.listboxItems_set{n};
    label = handles.data_index_set(2:end,1)';%label has to be row
    Y=handles.data_index_set(1,2:end)';
    x=handles.data_index_set(2:end,2:end)';
    if index==1
        msg='SG_1st_derivative';
        prompt = {'Enter the order of filter:'};
        title = 'Input';
        dims = [1 35];
        definput = {'2'};
        order = inputdlg(prompt,title,dims,definput);
        order=str2double(order);
        prompt1 = {'Enter the window size of filter:'};
        title = 'Input';
        dims = [1 35];
        definput = {'5'};
        window = inputdlg(prompt1,title,dims,definput);
        window=str2double(window);
        for i=1:size(x,1)
        X=x(i,:);
        X_1st_der = der1st(X, order, window);
        X_SG(i,:)=X_1st_der;
        end
    elseif index==2;
        msg='SG_2nd_derivative';
        prompt = {'Enter the order of filter:'};
        title = 'Input';
        dims = [1 35];
        definput = {'2'};
        order = inputdlg(prompt,title,dims,definput);
        order=str2double(order);
        prompt1 = {'Enter the window size of filter:'};
        title = 'Input';
        dims = [1 35];
        definput = {'5'};
        window = inputdlg(prompt1,title,dims,definput);
        window=str2double(window);
        for i=1:size(x,1)
        X=x(i,:);
        X_2nd_der = der2nd(X, order, window);
        X_SG(i,:)=X_2nd_der;
        end
    end
    cla;
    legend(handles.axes1,'hide');
    line_plot_category(label,X_SG,Y);
    legend('SG dervivative');
    k=handles.valset;
    handles.data_index_set(2:end,2:end)=X_SG';
    handles.data_index_set(2:end,1)=label';
    handles.data_index_set(1,2:end)=Y';
    handles.spec_data_set{k+1} =handles.data_index_set;
    handles.listboxItems_set{k+1} = strcat(str,'_',msg);
    handles.valset=handles.valset+1;
    set(handles. Data_set,'string',handles.listboxItems_set);
end
    
guidata(hObject, handles);
end
 
