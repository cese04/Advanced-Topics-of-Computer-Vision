The file metadata.csv contains age, gender and skin type (classes 1 to 6 after Fitzpatrick) for each "Face ID".

Each folder "Fxxx" (Face ID) contains all data for one subject / person in three sub folders:

- "Spectro": 
Holds the spectrometer data acquired with an TQ IrSys 1.7 spectrometer at 16 measurement points, specified in file "Spectrometer-Measurement-Points.png" in the root folder. The data consists of one "PRN" file for each measurement point. The data format is ASCII-Text. Each line contains the wavelength in µm followed by the relative remission intensity in percent. All intensity values are given in relation to a diffuse "white" reference tile, specifically designed for the SWIR spectrum. At wavelengths above 1.6µm, noise levels increase rapidly, which might lead to negative values. At these wavelengths, a floating window averaging should be applied. 

- "RGB":
Holds the RGB portrait images taken with a Canon EOS 50D digital camera and frontal illumination using professional studio lighting. 

- "SWIR":
Holds the SWIR multispectral images taken with the SkinCam system, consisting of four wavebands (935nm, 1060nm, 1300nm and 1550nm), which are denoted in the file name. Images are frontal illuminated by an LED ring light around the camera lens, leading to highlights/direct reflections on shiny surfaces such as glasses or jewelry, which will be cut off in most cases. However, the camera's 12 bit greyscale images have been downsampled to 8 bit using varying scaling factors in order to optimize image brightness and contrast while preserving highlight detail in skin areas. A white reference tile, placed at the same position as the test subjects, has been used to calibrate the "white balance". 


Both RGB and SWIR images are ordered in the following scheme:
00 - full frontal portrait with glasses (optional)
01 - full frontal portrait, no smiling
02 - full frontal portrait, smiling with mouth closed
03 - full frontal portrait, smiling and showing teeth
04 - turned 45° to the left
05 - turned 45° to the right
06 - turned 90° to the left
07 - turned 90° to the right
