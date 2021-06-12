function [XL,XS,expl_var,X,Y,label] = pca_call(hObject,handles)
label = handles.data_index_set(2:end,1);
Y=handles.data_index_set(1,2:end)';
X=handles.data_index_set(2:end,2:end);
X = X';
[XL,XS, latent, tsquared,expl_var, mu] = pca(X);
prompt = {'Enter the No of components:'};
title = 'Input';
dims = [1 35];
definput = {'5'};
input_n = inputdlg(prompt,title,dims,definput);
ncomp =str2double(input_n);
[XL,XS, latent, tsquared,expl_var, mu] = pca(X,'NumComponents',ncomp);
guidata(hObject, handles);