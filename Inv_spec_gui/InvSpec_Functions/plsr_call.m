function [Xscores,Xloadings,PLSPctVar,yfitPLS7,ncomp,X,Y,label] = plsr_call(hObject,handles)
label = handles.data_index_set(2:end,1);
Y=handles.data_index_set(1,2:end)';
X=handles.data_index_set(2:end,2:end);
X = X';
prompt = {'Enter the No of components:'};
title = 'Input';
dims = [1 35];
definput = {'5'};
input_n = inputdlg(prompt,title,dims,definput);
ncomp =str2double(input_n);

[Xloadings,Yloadings,Xscores,Yscores,betaPLS7,PLSPctVar] = plsregress(X,Y,ncomp);
yfitPLS7 = [ones(size(X,1),1) X]*betaPLS7;

% plot(1:ncomp,cumsum(100*PLSPctVar(2,:)),'-bo');
% plot(y,yfitPLS7,'bo');
set(handles.plots_drop,'Visible','Off');
set(handles.plots_plsr,'Visible','On');
guidata(hObject, handles);