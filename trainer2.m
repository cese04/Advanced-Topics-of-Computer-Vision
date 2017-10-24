clc, clear all, close all

% Obtain the samples by cropping parts that contains skin or another color
% feature

Ima=imread('F002_RGB_01.JPG');
im=norm1(Ima);
[a2,b2]=imcrop(im);
r2=a2(:,:,1);
g2=a2(:,:,2);

Ima=imread('F003_RGB_01.JPG');
im=norm1(Ima);
[a3,b3]=imcrop(im);
r3=a3(:,:,1);
g3=a3(:,:,2);

Ima=imread('F004_RGB_01.JPG');
im=norm1(Ima);
[a4,b4]=imcrop(im);
r4=a4(:,:,1);
g4=a4(:,:,2);

Ima=imread('F005_RGB_01.JPG');
im=norm1(Ima);
[a4,b4]=imcrop(im);
r5=a4(:,:,1);
g5=a4(:,:,2);

Ima=imread('F006_RGB_01.JPG');
im=norm1(Ima);
[a4,b4]=imcrop(im);
r6=a4(:,:,1);
g6=a4(:,:,2);


Ima=imread('F008_RGB_01.JPG');
im=norm1(Ima);
[a4,b4]=imcrop(im);
r8=a4(:,:,1);
g8=a4(:,:,2);


%% Get the standard deviation and mean of the observations
tic
clear im
r5=[r2(:);r3(:);r4(:);r5(:);r6(:);r8(:)];
murn=mean(r5);
drn= std(r5);
o=0:0.01:1;
ph=exp((-0.5)*(((o-murn)/drn).^2));
 gh=(1/(drn*(sqrt((2*pi)))))*ph;
% gh=ph;
figure, plot(o,gh,'r'), hold on
 
g5=[g2(:);g3(:);g4(:);g5(:);g6(:);g8(:)];
mugn=mean(g5);
dgn=std(g5);
o=0:0.001:1;
ps=exp((-0.5)*(((o-mugn)/dgn).^2));
 gs=(1/(dgn*(sqrt((2*pi)))))*ps;
% gs=ps;
plot(o,gs,'b'), hold off


%% Create a mesh and display the gaussian distribution
load trained.mat
[r,g]=meshgrid(0:0.002:0.6,0:0.002:0.6);
ar=1.3*exp((-0.5)*(((r-mur)/dr).^2))-.9*exp((-0.5)*(((r-murn)/drn).^2));
ag=1.3*exp((-0.5)*(((g-mug)/dg).^2))-.9*exp((-0.5)*(((g-mugn)/dgn).^2));
% zz=(((1/(dr*(sqrt((2*pi)))))*ah).*((1/(dg*(sqrt((2*pi)))))*as));
zz=(ar).*(ag);

figure,mesh(r,g,zz)