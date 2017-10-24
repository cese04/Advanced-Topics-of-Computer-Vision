clc, clear all, close all
load fotos7

Ima = fotos7(:,:,:,1);

Im2 = Ima-60;
Im3 = double(Im2);
Im3 = (Im3/4).^1.6;
Im3 = uint8(medfilt2(Im3,[3,3]));
figure, subplot(121),imshow(Im3)
subplot(122), imshow(Ima)
% g1 = gradientweight(
% Im4 = 
[fil col] = size(Ima);

% Im4 = Im3<110;
Im4 = edge(Im3,'prewitt',0.02);
% Im4 = imsharpen(Ima,'Radius',2,'Amount',5);
figure, imshow(Im4)