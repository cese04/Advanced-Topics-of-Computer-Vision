clc, close all, clear all
cam = webcam(1);
cam.Resolution = '640x480';

fot = rgb2gray(snapshot(cam));

save( 'ficha.jpg')