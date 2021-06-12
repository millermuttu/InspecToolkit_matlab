function [d1,d2,d3,d4,d5,d6,d7]=fom_main(hObject,handles)
data=handles.fom_demo;
X=data.X;
lambda=data.lambda;
[index,index_new] = parameters_fom();
[wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_2(index,X,lambda,index_new);
d1=strcat('Wavelength Mean =  ',num2str(wavelength_mean));
d2=strcat('Wavelength Accuracy =  ',num2str(wavelength_accuracy));
d3=strcat('Wavelength Repeatability =  ',num2str(wavelength_repeatability));
d4=strcat('Max Wavelength Shift(row) in nm =  ',num2str(max_wavelength_shift_row_nm));
d5=strcat('Peak FWHM Mean =  ',num2str(peak_fwhm_mean));
d6=strcat('Absorbance Accuracy =  ',num2str(Absorbance_accuracy));
d7=strcat('Absorbance Repeatability = ',num2str(Absorbance_repeatability));
end

