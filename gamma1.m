function gm=gamma1(Ima)
%clc, clear all;
%ima=imread('2c.jpg');
im=Ima;
[fil, col,x]=size(Ima);
gm=zeros(fil,col);
% Ima=rgb2gray(Ima);
n = 1.11;
for i=1:fil
    for j=1:col
        gm(i,j,1)=(double(Ima(i,j,1)-40)^(n));
        gm(i,j,2)=(double(Ima(i,j,2)-40)^(n));
        gm(i,j,3)=(double(Ima(i,j,3)-40)^(n));
    end
end
% subplot(1,2,1), imshow(uint8(im))
% title('Original')
% subplot(1,2,2), imshow(uint9(gm))
% title('Modificada')

        
