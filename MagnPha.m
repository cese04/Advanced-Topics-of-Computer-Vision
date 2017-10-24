clc, close all, clear all

im1=imread('elephant.jpg');
im2=imread('truck.jpg');

[x,y,z]=size(im1);

f1=fft2(im1);
f2=fft2(im2);

fm1=abs(f1); %Get the magnitude of both images
fm2=abs(f2);

fa1=angle(f1); %Get the phase of both images
fa2=angle(f2);

for i=1:x
    for j=1:y
        f3(i,j)=fm1(i,j).*exp(fa2(i,j)*sqrt(-1)); %Mix the magnitudes and phases
        f4(i,j)=fm2(i,j).*exp(fa1(i,j)*sqrt(-1));
    end
end

im3=ifft2(f3); %Create the new images
im4=ifft2(f4);

figure,subplot(221),imshow(im1),title('Elephant')
subplot(222),imshow(im2),title('Truck')
subplot(223),imshow(im3,[]),title('ElephantMag & TruckPhase')
subplot(224),imshow(im4,[]),title('TruckMagnitude & ElephantPhase')