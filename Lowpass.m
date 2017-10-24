clc, close all, clear all
ima=imread('reto_viral.jpg');
%ima=double(ima);
[l, k, j]=size(ima);
if j==3
    ima=rgb2gray(ima);
end
imshow(ima);
fo=fft2(ima);
figure, subplot(211), imshow(fo)
fr=fftshift(fo);
[x,y]=size(fr);
g=lpfilter('gauss',x,y,20,10);
g2=1-lpfilter('gauss',x,y,50,10);
a=1-g;
%.........Lowpass
fi=fo.*g;
%.........Bandpass
% fi=fo.*g.*g2;
%.........Highpass
fa=fo.*a;
fis=log(1+abs(fftshift(fi)));
subplot(212),imshow(fr);
S=abs(fr);
S=log(1+S);
figure,subplot(211), imshow(S,[]);
subplot(212), imshow(fis,[]);

figure,surf(S,'EdgeColor','none','LineStyle','none')


f=ifftshift(fr);
i_f=ifft2(fa);
b=ifft2(fi);
figure,subplot(211),imshow(i_f,[]);
subplot(212), imshow(b,[]);
b = histeq(uint8(b));
%b = imsharpen(b, 'Amount',2);
figure, imshow(b,[])

