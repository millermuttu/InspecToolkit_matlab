function Spectra = InvSpec_abs2tx(hObject,handles)
%InverseSpectra Simulator
%Summary: Change transmittance or reflection data into absorbance
%Function syntax:
% Spectra = tx2abs(Spectra)
% 
% input parameter:  
%                   Spectra     = Absorbance data
%
% output parameter: 
%                   Spectra     = Transmitance or reflection spectra
if handles.choice==1
    n=handles.index_selected;
    str=handles.listboxItems{n};
    WL=handles.data_index(:,1)';
    data=handles.data_index(:,2)';
    Spectra=10.^(-data);
    cla;
    legend(handles.axes1,'hide');
    plot(WL,Spectra);
    ylabel('Transmittance'); xlabel('Wavelength');
    % handles.data=Spectra;
    legend('Transmittance Spectra');
    k=length(handles.spec_data);
    handles.spec_data{k+1} = [WL,Spectra];
    %get(handles.listboxItems,'string');
    handles.listboxItems{k+1} = strcat(str,'_Transmittance');
    set(handles.tablelist,'string',handles.listboxItems);
elseif handles.choice==2
    n=handles.index_selected_set;
    str=handles.listboxItems_set{n};
    label = handles.data_index_set(2:end,1)';%label has to be row
    Y=handles.data_index_set(1,2:end)';
    x=handles.data_index_set(2:end,2:end)';
    X_tx=10.^(-x);
    legend(handles.axes1,'hide');
    line_plot_category(label,X_tx,Y);
    ylabel('Transmittance'); xlabel('Wavelength');
    legend('Transmitance Spectra');
    k=handles.valset;
    handles.data_index_set(2:end,2:end)=X_tx';
    handles.data_index_set(2:end,1)=label';
    handles.data_index_set(1,2:end)=Y';
    handles.spec_data_set{k+1} =handles.data_index_set;
    handles.listboxItems_set{k+1} = strcat(str,'_Transmittance');
    handles.valset=handles.valset+1;
    set(handles. Data_set,'string',handles.listboxItems_set);
end
guidata(hObject, handles);
end