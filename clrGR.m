clc, close all, clear all
%Imagen de fondo
cam=webcam(1);
cam.Resolution='1280x720'
disp('Presione una tecla')
pause()
tic
fon=snapshot(cam);
% fon=imread('back.png');
fon=rgb2gray(fon);
fon=double(fon);
% fon=double(fon);
%Imagen a identificar 
disp('Presione una tecla')
pause()
tic
[x,y,z]=size(fon);
newIma=zeros(x,y,3);
while(1)
im=snapshot(cam);
Ima=rgb2gray(im);
Ima=double(Ima);
  %Create a mask of the same size as the image
for i=1:x
    for j=1:y
        r=(Ima(i,j)-fon(i,j))^2;  %Find the distance between the pixel of the background and the new one
   
        d=sqrt(r);
        if d>50  %If the pixel's distance is greater than the threshold is part of the object
            newIma(i,j,:)=im(i,j,:);
        end
    end
end
clf
imshow(uint8(newIma))
end