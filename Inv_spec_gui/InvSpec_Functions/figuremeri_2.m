function [ wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_2( index,X,lambda,index_new )

if index==1
    if index_new==1
       ftir_peak_loc = [6.6859 7.0406 8.22507 9.203];
       ftir_peak_values = [0.56089 0.86335 0.3199 0.40478];
       [wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_IPA(X,lambda,ftir_peak_loc,ftir_peak_values );
    end
     if index_new==2
       ftir_peak_loc = [5.6266 8.0313 8.917 9.507];
       ftir_peak_values = [0.3606 0.48028 0.47553 0.4561];
       [wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_IPA(X,lambda,ftir_peak_loc,ftir_peak_values );
    end
     
   if index_new==3
       ftir_peak_loc = [5.6266 8.0313 8.917 9.507];
       ftir_peak_values = [0.3606 0.48028 0.47553 0.4561];
       [wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_IPA(  X,lambda,ftir_peak_loc,ftir_peak_values);
    end
       
 end
 if index==2
    if index_new==1
       ftir_peak_loc = [6.6859 7.0406 8.22507 9.203];
       ftir_peak_values = [0.56089 0.86335 0.3199 0.40478];
       [wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_water( X,lambda,ftir_peak_loc,ftir_peak_values );
    end
     if index_new==2
       ftir_peak_loc = [5.6266 8.0313 8.917 9.507];
       ftir_peak_values = [0.3606 0.48028 0.47553 0.4561];
       [wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_water( X,lambda,ftir_peak_loc,ftir_peak_values );
    end
     
   if index_new==3
       ftir_peak_loc = [5.6266 8.0313 8.917 9.507];
       ftir_peak_values = [0.3606 0.48028 0.47553 0.4561];
       [wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_water( X,lambda,ftir_peak_loc,ftir_peak_values );
    end
       
 end
if index==3
    if index_new==1
       ftir_peak_loc = [6.6859 7.0406 8.22507 9.203];
       ftir_peak_values = [0.56089 0.86335 0.3199 0.40478];
       [wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_ETH(X,lambda,ftir_peak_loc,ftir_peak_values );
    end
     if index_new==2
       ftir_peak_loc = [5.6266 8.0313 8.917 9.507];
       ftir_peak_values = [0.3606 0.48028 0.47553 0.4561];
       [wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_ETH(X,lambda,ftir_peak_loc,ftir_peak_values );
    end
     
   if index_new==3
       ftir_peak_loc = [5.6266 8.0313 8.917 9.507];
       ftir_peak_values = [0.3606 0.48028 0.47553 0.4561];
       [wavelength_mean,wavelength_accuracy,wavelength_repeatability,max_wavelength_shift_row_nm,peak_fwhm_mean,Absorbance_accuracy,Absorbance_repeatability] = figuremeri_ETH(X,lambda,ftir_peak_loc,ftir_peak_values);
    end
       
 end
end    
% 