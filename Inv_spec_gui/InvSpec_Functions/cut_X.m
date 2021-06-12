function [data_cut, WL_cut] = cut_X(hObject,handles)
% Summary: Cut measuement data of specific region
%
% Chemometrics Toolbox
%-------------------------------------------------------------------------
% Robert Bosch GmbH
% Robert-Bosch-Campus 1
% 71272 Renningen
%-------------------------------------------------------------------------
%
% Function syntax:
% [X_range, label_new] = cut_X(X, label, label_min, label_max)
% 
% input parameter:  
%                   X          = measurement data
%                   label      = label for columns within X
%                   label_min  = minimum of label region (included)
%                   label_max  = maximum of label region (included)
%
% output parameter: 
%                   X_range    = cutted X-data
%                   label_new  = label value according to cutted X-data
if handles.choice==1
    n=handles.index_selected;
    str=handles.listboxItems{n};
    WL=handles.data_index(:,1)';
    data=handles.data_index(:,2)';
    x=data; label=WL;
    prompt = {'Enter lower limit wavelength:','Enter upper limit wavelength:'};
    title = 'Input';
    dims = [1 35];
    a=num2str(min(label));
    b=num2str(max(label));
    definput = {a,b};
    answer = inputdlg(prompt,title,dims,definput);
    label_min  = str2num(answer{1});
    label_max  = str2num(answer{2});
    %% Cut wavelength range between label_min and label_max
    X_range = x(:,find(label >= label_min & label <= label_max));
    label_new = label(:,find(label >= label_min & label <= label_max));
    data_cut=X_range';
    WL_cut=label_new';
    cla;
    legend(handles.axes1,'hide');
    plot(WL',data');
    hold on;
    plot( WL_cut,data_cut);
    legend('Orginal Spectra','Resized Spectra');
    % handles.data=data_cut;
    % handles.WL=WL_cut;
    k=length(handles.spec_data);
    handles.spec_data{k+1} = [WL_cut,data_cut];
    %get(handles.listboxItems,'string');
    handles.listboxItems{k+1} = strcat(str,'_Resized');
    set(handles.tablelist,'string',handles.listboxItems);
elseif handles.choice==2
    n=handles.index_selected_set;
    str=handles.listboxItems_set{n};
    label = handles.data_index_set(2:end,1)';%label has to be row
    Y=handles.data_index_set(1,2:end)';
    x=handles.data_index_set(2:end,2:end)';
    prompt = {'Enter lower limit wavelength:','Enter upper limit wavelength:'};
    title = 'Input';
    dims = [1 35];
    a=num2str(min(label));
    b=num2str(max(label));
    definput = {a,b};
    answer = inputdlg(prompt,title,dims,definput);
    label_min  = str2num(answer{1});
    label_max  = str2num(answer{2});
    %% Cut wavelength range between label_min and label_max
    X_range=[];
    for i=1:size(x,1)
        X=x(i,:);
        X_range(:,i) = X(:,find(label >= label_min & label <= label_max));%o/p is column data
    end
    [a,b]=size(X_range);
    label_new = label(:,find(label >= label_min & label <= label_max));
    cla;
    legend(handles.axes1,'hide');
    line_plot_category(label_new,X_range',Y);
    legend('Resized Spectra');
    handles.data_index_set=zeros(a+1,b+1);
    k=handles.valset;
    handles.data_index_set(2:end,2:end)=X_range;
    handles.data_index_set(2:end,1)=label_new';
    handles.data_index_set(1,2:end)=Y';
    handles.spec_data_set{k+1} =handles.data_index_set;
    handles.listboxItems_set{k+1} = strcat(str,'_Resized');
    handles.valset=handles.valset+1;
    set(handles. Data_set,'string',handles.listboxItems_set);
end
guidata(hObject, handles);
end

