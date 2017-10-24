clc, close all, clear all
Ima = imread('06_dr.jpg');
grey = rgb2gray(Ima);
r = Ima(:,:,1);
g = Ima(:,:,2);
b = Ima(:,:,3);
g = medfilt2(g,[11, 11]);
W = gradientweight(g,7);
mask = W<0.4;
mask = bwareaopen(mask, 1000);
figure, subplot(121), imshow(W)
subplot(122), imshow(mask)

%mask = 
