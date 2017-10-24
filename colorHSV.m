clc, close all, clear all
%Imagen de fondo
fon=imread('back.png');

fon=gamma1(fon);
fon=uint8(fon);
fon=rgb2hsv(fon);
fon=double(fon);
fH=fon(:,:,1);
fS=fon(:,:,2);
fV=fon(:,:,3);
%Imagen a identificar 
Ima=imread('VC (5).png');
Ima=gamma1(Ima);
Ima=uint8(Ima);
Ima=rgb2hsv(Ima);
Ima=double(Ima);
H=Ima(:,:,1);
S=Ima(:,:,2);
V=Ima(:,:,3);
[x,y,z]=size(fon);
figure, subplot(221),imshow(fon)
subplot(222),imshow(Ima)
mask=zeros(x,y);   %Create a mask of the same size as the image
for i=1:x
    for j=1:y
        h=(H(i,j)-fH(i,j))^2;  %Find the distance between the pixel of the background and the new one
        s=(S(i,j)-fS(i,j))^2;
        v=(V(i,j)-fV(i,j))^2;
        d=sqrt(h+v+s);
        if d>0.5  %If the pixel's distance is greater than the threshold is part of the object
            mask(i,j)=1;
        end
    end
end
mask=double(mask);              %Show the resulting mask
subplot(223),imshow(mask);
newIma(:,:,1)=H.*mask;          %Appply the mask to the original image and create a new Image
newIma(:,:,2)=S.*mask;
newIma(:,:,3)=V.*mask;
newIma=hsv2rgb(newIma);
subplot(224),imshow(newIma)