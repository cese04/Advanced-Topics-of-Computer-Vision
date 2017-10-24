clc, close all, clear all
%Imagen de fondo
cam=webcam(1);
cam.Resolution='640x480';
disp('Presione una tecla')
pause()
tic
fon=snapshot(cam);
% fngr = 
% fon=double(fon);
fngr = rgb2gray(fon);
fngr = double(fngr);
% fR=fon(:,:,1);
% fG=fon(:,:,2);
% fB=fon(:,:,3);

%Imagen a identificar 
disp('Presione una tecla')
pause()
tic
[x,y,z]=size(fon);
newIma=zeros(x,y);
%%
while(1)
Ima=snapshot(cam);
% Ima=double(Ima);
gr = rgb2gray(Ima);
gr = double(gr);
  %Create a mask of the same size as the image
% for i=1:x 
%     for j=1:y
%         r=(R(i,j)-fR(i,j))^2;  %Find the distance between the pixel of the background and the new one
%         g=(G(i,j)-fG(i,j))^2;
%         b=(B(i,j)-fB(i,j))^2;
%         d=sqrt(r+b+g);
%         if d>180  %If the pixel's distance is greater than the threshold is part of the object
%             newIma(i,j,:)=Ima(i,j,:);
%         end
%     end
% end
%mask = zeros(x,y);
mask = abs(fngr-gr)>40;
mask = bwareaopen(mask,40);
for i=1:x 
    for j=1:y
        if mask(i,j) == 1  %If the pixel's distance is greater than the threshold is part of the object
            newIma(i,j)=gr(i,j);
        end
    end
end



%newIma = mask.*double(gr);
clf
imshow(uint8(newIma))
end