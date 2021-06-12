function snv(hObject,handles)
if handles.choice==2
    n=handles.index_selected_set;
    str=handles.listboxItems_set{n};
    label = handles.data_index_set(2:end,1);
    Y=handles.data_index_set(1,2:end)';
    X=handles.data_index_set(2:end,2:end)';
    cla;
    legend(handles.axes1,'hide');
    line_plot_category(label, X,Y);
    X_snv= ((bsxfun(@rdivide,(bsxfun(@minus, X', mean(X'))),std(X')))');
    cla;
    legend(handles.axes1,'hide');
    line_plot_category(label,X_snv,Y);
    xlabel('wavelength');ylabel('transmittance');
    title('SNV Transform');
    k=handles.valset;
    handles.data_index_set(2:end,2:end)=X_snv';
    handles.spec_data_set{k+1} =handles.data_index_set;
    handles.listboxItems_set{k+1} = strcat(str,'_SNV');
    handles.valset=handles.valset+1;
    set(handles. Data_set,'string',handles.listboxItems_set);
    guidata(hObject, handles);
else
  msgbox('SNV need batch data to funvction!');
end
end