clc, close all, clear all
g=1.03;
cam=webcam(1);
cam.Resolution='640x480';
disp('Presione una tecla')
pause()
%Imagen de fondo
% fon=imread('back.png');
fon=snapshot(cam);
fon=double(fon);
fon=fon.^g;
%Imagen a identificar 
disp('Presione una tecla')
pause()
% Ima=imread('VC (5).png');
figure
%%
while(1)
Ima=snapshot(cam);


% fon=single(fon);
Ima=double(Ima);

Ima=Ima.^g;

im=Ima-fon;
im=im.^2;
ir=im>5000;
mask(:,:,1)=ir(:,:,1)|ir(:,:,2)|ir(:,:,3); %Do an OR among the RGB layers
mask(:,:,2)=mask(:,:,1);
mask(:,:,3)=mask(:,:,1);
iw=mask.*Ima;
[a,b]=find(mask(:,:,1));

for i=1:length(a)
    r(i,:)=Ima(a(i),b(i),:);
end

% subplot(121), hist(r,6)
 m=hist_3(r,5);
% subplot(121),imshow(uint8(fon));
% subplot(121),imshow(uint8(Ima));
subplot(122),imshow(uint8(iw));
end