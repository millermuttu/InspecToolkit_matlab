function duplicate(hObject,handles)
n=handles.index_selected;
str=handles.listboxItems{n};
WL=handles.data_index(:,1)';
Spectra=handles.data_index(:,2)';
d = {'Replica','Duplicate with noise',...
    };
[index,tf] = listdlg('PromptString','Select the number of input:','ListString',d,'listsize',[150 50]); 
X=Spectra;
[p,q]=size(X);
if index==1
prompt = {'Enter the number of duplicates:'};
title = 'Input';
numm = inputdlg(prompt,title);
m =str2double(numm);
Y=zeros(m,q);
Y = repmat(X,m,1);
elseif index==2;
    prompt1 = {'Enter the number of duplicates with noise:'};
    title = 'Input';
    number= inputdlg(prompt1,title);
    m =str2double(number); 
    Y=zeros(m,q);
    a=0; b=0.01;
    for i=1:m
        Y(i,:)= (X+(a+(b-a).*rand(size(X(i)))));
    end
end
cla;
legend(handles.axes1,'hide');
plot(WL,X);
hold on;
plot(WL,Y);
legend('Orginal Spectra','Duplicated Spectra');
k=length(handles.spec_data);
for i=1:m
    handles.spec_data{k+i} = [WL',Y(i,:)'];
    handles.listboxItems{k+i} = strcat(str,'_Duplicates_Spectra',num2str(i));
    set(handles.tablelist,'string',handles.listboxItems);
    guidata(hObject, handles);
end
end
 
