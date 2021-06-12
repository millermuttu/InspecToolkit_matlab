function [ wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_IPA(  X,lambda,ftir_peak_loc,ftir_peak_values )
data_string = {'C002','C006','T003','T004'};
% ftir_peak_loc = [6.6859 7.0406 8.22507 9.203];
% ftir_peak_values = [0.56089 0.86335 0.3199 0.40478];
%%
for k=1:1:size(data_string,2)    
%    load('FigOM.mat');
    [data_row,data_col] = size(X);
    peak_loc = zeros(data_row,length(ftir_peak_loc));
    peak_value = zeros(data_row,length(ftir_peak_loc));
    peak_fwhm = zeros(data_row,length(ftir_peak_loc));
    for row=1:1:data_row
        [pks,locs,W,P] = findpeaks(X(row,:),lambda);
        for j = 1:length(ftir_peak_loc)
            [val,loc] = min(abs(locs-ftir_peak_loc(j)));
            peak_loc(row,j)=locs(loc);
            peak_value(row,j) = pks(loc);
            peak_fwhm(row,j) = W(loc)/2;
        end
    end
  
    result.(data_string{k}).peak_loc_nm = peak_loc.*10^3;
    result.(data_string{k}).peak_value_nm =peak_value.*10^3;
    result.(data_string{k}).peak_fwhm_nm =peak_fwhm.*10^3;
    wavelength_accuracy = sqrt((sum((peak_loc - repmat(ftir_peak_loc,data_row,1)).^2))./data_row).*10^3;
    wavelength_mean = mean(peak_loc);
    [a,b] = max(abs(peak_loc - repmat(ftir_peak_loc,data_row,1)));
    [c,d]=  max(a);
    max_wavelength_shift_ftir = (peak_loc(b(d),d) - wavelength_mean(d)).*10^3;
    max_wavelength_shift_row_nm = ([peak_loc(b(1),1) peak_loc(b(2),2) peak_loc(b(3),3) peak_loc(b(4),4)] -wavelength_mean).*10^3;
    peak_fwhm_mean = mean(peak_fwhm).*10^3;
    wavelength_repeatability = sqrt((sum((peak_loc - repmat(wavelength_mean,data_row,1)).^2))./(data_row-1)).*10^3;
    %%
    result.(data_string{k}).wavelength_accuracy_nm = wavelength_accuracy;
    result.(data_string{k}).wavelength_repeatability_nm = wavelength_repeatability;
    result.(data_string{k}).wavelength_mean_nm =wavelength_mean.*10^3;
    result.(data_string{k}).peak_fwhm_mean_nm =peak_fwhm_mean;
    result.(data_string{k}).max_wavelength_shift_ftir_nm =max_wavelength_shift_ftir;
    result.(data_string{k}).max_wavelength_shift_row_nm =max_wavelength_shift_row_nm;
    %%
    Absorbance_accuracy = sqrt((sum((peak_value - repmat(ftir_peak_values,data_row,1)).^2))./data_row);
    Absorbance_mean = mean(peak_value);
    Absorbance_repeatability = sqrt((sum((peak_value - repmat(Absorbance_mean,data_row,1)).^2))./(data_row-1));
    %%
    result.(data_string{k}).Absorbance_accuracy = Absorbance_accuracy;
    result.(data_string{k}).Absorbance_mean = Absorbance_mean;
    result.(data_string{k}).Absorbance_repeatability =Absorbance_repeatability;
end

% op=[wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability]; 
end
