Each folder "Spec_xxx" contains all spectrometer data for one subject / person, acquired with an TQ IrSys 1.7 spectrometer at 16 measurement points (0 to 15). 
The location of the measurement points are specified in file "Spectrometer-Measurement-Points.png" in this folder. 
The data consists of one "PRN" file for each measurement point. 
The data format is ASCII-Text. 
Each line contains the wavelength in µm followed by the relative remission intensity in percent. 
All intensity values are given in relation to a diffuse "white" reference tile, specifically designed for the SWIR spectrum. 
At wavelengths above 1.6µm, noise levels increase rapidly, which might lead to negative values. 
At these wavelengths, a floating window averaging should be applied. 

Please note, that the order and ID numbers of the spectrometer data does not match the order and numbering of the face database.
