function Simulate_main(hObject,handles)
d = {'Demo Data','Load Data from Excel','Select from Data Set Panel'...
    };
[index,tf] = listdlg('PromptString','Select the type of input:','ListString',d,'listsize',[150 60]); 
legend(handles.axes1,'hide');
if index==1 %demo data-------
    WL=handles.AS_Demo(2:end,1);
    Y=handles.AS_Demo(1,2:end);
    Spec=handles.AS_Demo(2:end,2:end);
    [X_sim,Y_sim,WL] =Simulate_fn(Spec,Y,WL);
    str='AS_demo';
elseif index==2 %load data from excel---------------
    str='Data_Set';
    myicon = imread('data.PNG');
    Load_Help(myicon);
    pause(2);
%     n=handles.index_selected_set;
    [WL,X,Y] = loadfromexcel_simulate(hObject,handles);
    d = {'Yes','No',...
        };
    [index_1,tf] = listdlg('PromptString','Do you want to Resample ?','ListString',d,'listsize',[150 50]); 
    if index_1==1 %if resampling, in load excel data
        [WL,X,Y]=Resample2(WL,X,Y);
        Spec=X';
        Y=Y';
        clear X;%coz noise replicated data is stored in X
        [X_sim,Y_sim,WL] =Simulate_fn(Spec,Y,WL);
    elseif index_1==2
        Spec=X';
        Y=Y';
        [X_sim,Y_sim,WL] =Simulate_fn(Spec,Y,WL);
    end
    elseif index==3
        %index=handles.index_selected_set;
        %handles.data_index_set
        str=handles.str.set;
        WL=handles.data_index_set(2:end,1);
        Y=handles.data_index_set(1,2:end);
        Spec=handles.data_index_set(2:end,2:end);
        [X_sim,Y_sim,WL] =Simulate_fn(Spec,Y,WL);
   
end
[a,b]=size(X_sim);
handles.data_index_set=zeros(a+1,b+1);
k=handles.valset;
handles.data_index_set(2:end,2:end)=X_sim;
handles.data_index_set(2:end,1)=WL;
handles.data_index_set(1,2:end)=Y_sim;
handles.spec_data_set{k+1} =handles.data_index_set;
handles.listboxItems_set{k+1} = strcat(str,'_Simulate');
handles.valset=handles.valset+1;
set(handles. Data_set,'string',handles.listboxItems_set);
guidata(hObject, handles);
end


