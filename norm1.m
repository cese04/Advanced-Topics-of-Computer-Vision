% clc, clear all, close all;
% Ima= imread('VC (4).png');
% figure, imshow(uint8(Ima))
function im=norm1(Ima)
Ima=double(Ima);
R=Ima(:,:,1);
G=Ima(:,:,2);
B=Ima(:,:,3);
s=(R+G+B);
r=R./s;
g=G./s;
b=B./s;
% b=B./s;
im(:,:,1)=r;
im(:,:,2)=g;
im(:,:,3)=b;
% figure,imshow(im)

% F=zeros(a,b,5);
% F(:,:,1)=imfilter(sub,hh);
% F(:,:,2)=imfilter(sub,hv);
% F(:,:,3)=imfilter(F(:,:,1),hh);
% F(:,:,4)=imfilter(F(:,:,2),hv);
% F(:,:,5)=imfilter(F(:,:,1),hv);
% 
% figure,subplot(231),imshow(F(:,:,1))
% subplot(232),imshow(F(:,:,2))
% subplot(233),imshow(F(:,:,3))
% subplot(234),imshow(F(:,:,4))
% subplot(235),imshow(F(:,:,1))