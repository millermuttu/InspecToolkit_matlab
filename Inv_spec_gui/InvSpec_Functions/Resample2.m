function [label_new,X_new,Y]=Resample2(WL,X,Y)
label = WL;
x=X;
clear X;
old_wave=label';
old=old_wave(2)-old_wave(1);
msg=strcat('Current resolution is ',num2str(old));
uiwait(msgbox(msg)); 
prompt = {'Enter new resolution:'};
title = 'Input';
dims = [1 35];
definput = {'0.5'};
answer = inputdlg(prompt,title,dims,definput);
nr=str2num(answer{1});
for i=1:size(x,1)
    old_tx=x(i,:);
    low_limit=old_wave(1)+nr;
    end_val=length(old_wave);
    up_limit=old_wave(end_val)-nr;
    new_wave=[low_limit:nr:up_limit];
    %spectra-------------------
    spectra=zeros(1,size(old_wave,2));%corresponding to old
    spectra_w=zeros(1,size(old_wave,2));
    m=length(spectra_w);%=length(old_wave)
    spectra_tx=old_tx;

    spectra(1)=old_wave(1)-((old_wave(2)-old_wave(1))/2);
    spectra_w(m)=old_wave(m)-old_wave(m-1);

    spectra(2:end)=(old_wave(2:end)+old_wave(1:m-1))/2;
    spectra_w(1:m-1)=spectra(2:end)-spectra(1:m-1);
    %mask-------------------
    mask=zeros(1,(size(new_wave,2)+1));%corresponding to new
    mask_w=zeros(1,(size(new_wave,2)));
    p=length(mask); q=length(mask_w);%same as new wave;

    mask(1)=new_wave(1)-((new_wave(2)-new_wave(1))/2);
    mask_w(q)=new_wave(q)-new_wave(q-1);

    mask(p)=new_wave(q)+((new_wave(q)-new_wave(q-1))/2);
    mask(2:p-1)=(new_wave(2:end)+new_wave(1:q-1))/2;

    %Condition------------------
    if mask(1)<spectra(1) || mask(p)>spectra(m)
        error(generatemsgid('The new wavelengths specified must fall within the range of the old wavelength values')); 
    end
    %Generate output arrays to be populated
    res=zeros(1,(size(new_wave,2)));

    start=1; stop=1;
    %Calculate new flux and uncertainty values, loop over new bins
    for j=1:size(new_wave,2)
        %Find first old bin which is partially covered by the new bin
            while spectra(start+1) <= mask(j)
                start=start+ 1;
            end

        %Find last old bin which is partially covered by the new bin
            while spectra(stop+1) < mask(j+1)
                stop =stop+1;
            end

        %If new bin is fully within one old bin these are the same
            if stop == start
                res(j) = spectra_tx(start);

       %Otherwise multiply the first and last old bin widths by P_ij
            else
                start_factor = ((spectra(start+1) - mask(j))/(spectra(start+1)- spectra(start)));
                end_factor = ((mask(j+1) - spectra(stop))/(spectra(stop+1)- spectra(stop)));
                spectra_w(start)= spectra_w(start)*start_factor;
                spectra_w(stop)= spectra_w(stop)*end_factor   ;
        %Populate res_fluxes spectrum and uncertainty arrays
                f_widths = spectra_w(start:stop+1).*[spectra_tx(start:stop+1)];
                res(j) = sum(f_widths);
                res(j)=res(j)/sum(spectra_w(start:stop+1));

        %Put back the old bin widths to their initial values for later use
                spectra_w(start)=spectra_w(start)/start_factor;
                spectra_w(stop) = spectra_w(stop)/end_factor;
            end
    end
    X_new(i,:)=res; 
end
cla;
label_new=new_wave;
line_plot_category(label_new,X_new,Y);
legend('Resampled Spectra');
% guidata(hObject, handles);
end

