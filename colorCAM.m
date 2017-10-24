clc, close all, clear all
%Imagen de fondo
cam=webcam(1);
cam.Resolution='640x480';
disp('Presione una tecla')
pause()
tic
fon=snapshot(cam);
fon=double(fon);
fR=fon(:,:,1);
fG=fon(:,:,2);
fB=fon(:,:,3);

%Imagen a identificar 
disp('Presione una tecla')
pause()
tic
[x,y,z]=size(fon);
newIma=zeros(x,y,z);
while(1)
Ima=snapshot(cam);
Ima=double(Ima);
R=Ima(:,:,1);
G=Ima(:,:,2);
B=Ima(:,:,3);
  %Create a mask of the same size as the image
for i=1:x 
    for j=1:y
        r=(R(i,j)-fR(i,j))^2;  %Find the distance between the pixel of the background and the new one
        g=(G(i,j)-fG(i,j))^2;
        b=(B(i,j)-fB(i,j))^2;
        d=sqrt(r+b+g);
        if d>180  %If the pixel's distance is greater than the threshold is part of the object
            newIma(i,j,:)=Ima(i,j,:);
        end
    end
end
clf
imshow(uint8(newIma))
end