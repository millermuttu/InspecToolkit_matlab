function [X_sim,Y_sim,WL] =Simulate_fn(Spec,Y,WL)
Y_org=Y;
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
% legend(handles.axes1,'hide');
% line_plot_category(label, X,Y);
line_plot_category(label, Spec',Y_org');
prompt = {'Enter the new conc to be detected:'};
title = 'Input';
dims = [1 45];
definput = {'1.0'};
answer = inputdlg(prompt,title,dims,definput);
Y_pred=str2double(answer);
[X_new,Y_new] = reverse_plsr(X,Y,Y_pred);
% legend(handles.axes1,'hide');
size(Spec);
b=X_new(end,:)';
X_sim=horzcat(Spec,b);
Y_sim=horzcat(Y_org,Y_new(end));
cla;
line_plot_category(label,X_sim',Y_sim');
xlabel('Wavelength','fontsize',12);
ylabel('Transmitance','fontsize',12);
end

