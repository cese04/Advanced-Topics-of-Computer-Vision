%% Fourier transform function and preprocessing
% This function applies a Sobel filter for 0° and 90° , after that both are
% transformed to the frequency domain and the outputs are the resulting
% images

%% Function declaration
% In this part the image is the input for the function and as result the
% output are two images
function [fh, fv]=spect1(ima)
ima=imresize(ima,.5);
[fil,col,capa]=size(ima);

%% Sobel filtering
% If the image is in RGB converts to grayscale
if capa==3
    grey(ima);
end

imaexp=zeros(fil+2,col+2);
[fil,col]=size(imaexp);
for i=2:fil-1
    for j=2:col-1
        imaexp(i,j)=double(ima(i-1,j-1));
    end
end

%%
% *Apply the convolution matrix for horizontal filtering*
%%

%CM=[-1, 0, 1;-2, 0, 2; -1, 0, 1]
for i=2:fil-1
    for j=2:col-1
        Hh(i-1,j-1)=(1*imaexp(i-1,j-1)+ 0*imaexp(i-1,j)+(-1)*imaexp(i-1,j+1)+2*imaexp(i,j-1)+(0)*imaexp(i,j)-2*imaexp(i,j+1)+(1)*imaexp(i+1,j-1)+(0)*imaexp(i+1,j)+(0-1)*imaexp(i+1,j+1));
    end
end
%%
% *Apply the convolution matrix for vertical filtering*
%%

%CM=[1,2,1;0,0,0;-1,-2,-1]
for i=2:fil-1
    for j=2:col-1
        Hv(i-1,j-1)=((-1)*imaexp(i-1,j-1)-2*imaexp(i-1,j)+(-1)*imaexp(i-1,j+1)+0*imaexp(i,j-1)+(0)*imaexp(i,j)+(0)*imaexp(i,j+1)+1*imaexp(i+1,j-1)+2*imaexp(i+1,j)+(1)*imaexp(i+1,j+1));
    end
end

% imaf=Hh+Hv;
%% Show modified images
% figure
% subplot(221), imshow(uint8(Hh)),title('Horizontal filtering');
% subplot(222), imshow(uint8(Hv)),title('Vertical filtering');
% subplot(224), imshow(uint8(ima)),title('Original image');

%% Transformation to the frequency domain
% Here the program uses the Fast Fourier Transform(fft2) to obtain the spectrum of both images
%%
%Create the horizontal filtered spectrum
fo=fft2(Hh);
fh=fo;
% fr=fftshift(fo);
% fos=log(1+abs(fo));
% fis=log(1+abs(fr));
% S=abs(fr);
% figure,subplot(121), imshow(fos,[]),title('H ');
% subplot(122), imshow(fis,[]),title('Shifted H');

%%
%Create the vertical filtered spectrum
fo=fft2(Hv);
fv=fo;
% fr=fftshift(fo);
% fos=log(1+abs(fo));
% fis=log(1+abs(fr));
% S=abs(fr);
% figure, subplot(121), imshow(fos,[]),title('V');
% subplot(122), imshow(fis,[]),title('Shifted V');


