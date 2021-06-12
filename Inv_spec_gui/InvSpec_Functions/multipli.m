function [WL_A,WL_B,T_A,T_B,outwl,resTX] = multipli(hObject,handles)
handles
if (~iscell(handles.data_index) || size(handles.data_index,2)>2)
    errordlg('Select two data from datapanel in sequential order EX: data1 * data2')
%     prompt = {'Select two data from datapanel in sequential order EX: data1 - data2'};
%     title = 'Info';
else
% load('ATTO_390new.mat');
% load('ATTO_550new.mat');
WL_A=handles.data_index{1}(:,1);
WL_B=handles.data_index{2}(:,1)
T_A=handles.data_index{1}(:,2)
T_B=handles.data_index{2}(:,2)

%%----------Multiplication---------------

[m,n]=size(WL_A);
[p,q]=size(WL_B);
[a,b]=size(T_A); 
[r,s]=size(T_B);
Res_WL=[];
%%--------Multiplication: samples of equal size-------
if(WL_A(1)==WL_B(1))&&(WL_A(n)==WL_B(q))
 intWL_A = interp(WL_A,2);
 intWL_B = interp(WL_B,2);
 intT_A = interp(T_A,2);
 intT_B = interp(T_B,2);
outwl=intWL_A;
 resTX=intT_A.*intT_B;
%   figure(1);
%   plot(WL_A,T_A,'R')
%  hold on
%  plot(WL_B,T_B,'B')
%  figure(2);
%  plot( outwl,resTX);  
else
%%----------------Multiplication: Samples of different size--------
[ outnew ] = overlapp( WL_A, WL_B,b,s );
idx=(find(outnew~=0));
out2=[ones(1,idx(1)-1), T_B];
r=length(out2)-length(T_A);
out1=[T_A, ones(1, r)];
resTX=out1.*out2;
WL_Bnew=WL_B((size(idx,2)+1):end);
outwl1=[WL_A, ones(1, r)];
outwl2=[ones(1,idx(end)),WL_Bnew];
outwl=[outwl1+outwl2];
% figure(1);
% plot(WL_A,T_A);
% hold on
% plot(WL_B,T_B);xlabel('wavelength');ylabel('Transmittance');
% legend('Original Signal');
% figure(2);
% plot(resTX);
% legend('Multiplied Signal');
end
n=handles.index_selected
a=n(1)
str1=handles.listboxItems{n(1)};
str2=handles.listboxItems{n(2)};
k=handles.val+1;
handles.spec_data{k} = [outwl,resTX];
%get(handles.listboxItems,'string');
handles.val=k;
handles.listboxItems{k} = strcat(str1,str2,'_Multiplied');
set(handles.tablelist,'string',handles.listboxItems);
end
guidata(hObject, handles);
end
