function Simulate(hObject,handles)
d = {'Demo Data','Load Data from Excel',...
    };
[index,tf] = listdlg('PromptString','Select the type of input:','ListString',d,'listsize',[150 50]); 
if index==1
    WL=handles.AS_Demo(2:end,1);
    Y=handles.AS_Demo(1,2:end);
    Spec=handles.AS_Demo(2:end,2:end);
    %replicating data with noise
    Spec_dup=[];
    Z=[];
    d=1;
    for j=1:size(Y,2)
        X=Spec(:,j);
        Z=noise(X',10);
        Spec_dup(:,d:d+9)=[repmat(Y(j),1,10);Z'];
        d=d+10;
    end
    C=Spec_dup(1,:)';
    data=Spec_dup(2:end,:)';
    clear X Y;
    X=data;
    Y=C;
    label=WL;
    cla;
    legend(handles.axes1,'hide');
    line_plot_category(label, X,Y);
    prompt = {'The demo data loads 0.3, 0.7 and 2.0 conc. of AS. Choose the new conc to be detected:'};
    title = 'Input';
    dims = [1 45];
    definput = {'1.0'};
    answer = inputdlg(prompt,title,dims,definput);
    Y_pred=str2double(answer);
    [X_new,Y_new] = reverse_plsr(X,Y,Y_pred);
    cla;
    legend(handles.axes1,'hide');
    line_plot_category(label, X_new,Y_new);
    xlabel('Wavelength','fontsize',12);
    ylabel('Transmitance','fontsize',12);
%     title('','fontsize',12);
elseif index==2;
    myicon = imread('data.PNG');
    Load_Help(myicon);
    pause(2);
    [WL,X,Y] = loadfromexcel_simulate(hObject,handles);
    %replicating data with noise
    Spec_dup=[];
    Z=[];
    d=1;
    Spec=X';
    clear X;
    for j=1:size(Y,1)
        X=Spec(:,j);
        Z=noise(X',10);
        Spec_dup(:,d:d+9)=[repmat(Y(j),1,10);Z'];
        d=d+10;
    end
    C=Spec_dup(1,:)';
    data=Spec_dup(2:end,:)';
    clear X Y;
    X=data;
    Y=C;
    label=WL;
    cla;
    legend(handles.axes1,'hide');
    line_plot_category(label, X,Y);
    xlabel('Wavelength','fontsize',12);
    ylabel('Transmitance','fontsize',12);
    prompt = {'Enter the new conc to be detected:'};
    title = 'Input';
    dims = [1 45];
    definput = {'1.0'};
    answer = inputdlg(prompt,title,dims,definput);
    Y_pred=str2double(answer);
    [X_new,Y_new] = reverse_plsr(X,Y,Y_pred);
    cla;
    legend(handles.axes1,'hide');
    line_plot_category(label, X_new,Y_new);
    xlabel('Wavelength','fontsize',12);
    ylabel('Transmitance','fontsize',12);
end
guidata(hObject, handles);
end

