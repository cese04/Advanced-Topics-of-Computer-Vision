clc, close all, clear all
g=1.1;         %Value of gamma correction
%Imagen de fondo
fon=imread('back.png');
fon=single(fon);
fon=fon.^g;
% fon=double(fon);
fR=fon(:,:,1);
fG=fon(:,:,2);
fB=fon(:,:,3);
%Imagen a identificar 
Ima=imread('VC (1).png');
Ima=single(Ima);
Ima=Ima.^g;
R=Ima(:,:,1);
G=Ima(:,:,2);
B=Ima(:,:,3);
[x,y,z]=size(fon);
figure, subplot(221),imshow(uint8(fon))
subplot(222),imshow(uint8(Ima))
mask=zeros(x,y);   %Create a mask of the same size as the image

for i=1:x
    for j=1:y
        r=(R(i,j)-fR(i,j))^2;  %Find the distance between the pixel of the background and the new one
        g=(G(i,j)-fG(i,j))^2;
        b=(B(i,j)-fB(i,j))^2;
        d=sqrt(r+b+g);
        if d>140  %If the pixel's distance is greater than the threshold is part of the object
            mask(i,j)=1;
        end
    end
end

mask=double(mask);              %Show the resulting mask
subplot(223),imshow(mask);
newIma(:,:,1)=R.*mask;          %Appply the mask to the original image and create a new Image
newIma(:,:,2)=G.*mask;
newIma(:,:,3)=B.*mask;
subplot(224),imshow(uint8(newIma))




