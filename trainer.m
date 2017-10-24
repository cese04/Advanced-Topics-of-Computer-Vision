clc, clear all, close all

Ima=imread('F001_RGB_01.JPG');
im=norm1(Ima);
[a,b]=imcrop(im);
r=a(:,:,1);
g=a(:,:,2);

Ima=imread('F010_RGB_01.JPG');
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

Ima=imread('F007_RGB_01.JPG');
im=norm1(Ima);
[a4,b4]=imcrop(im);
r7=a4(:,:,1);
g7=a4(:,:,2);

Ima=imread('F008_RGB_01.JPG');
im=norm1(Ima);
[a4,b4]=imcrop(im);
r8=a4(:,:,1);
g8=a4(:,:,2);


Ima=imread('F009_RGB_01.JPG');
im=norm1(Ima);
[a4,b4]=imcrop(im);
r9=a4(:,:,1);
g9=a4(:,:,2);
%% Get the standard deviation and mean of the observations
tic
clear im
r5=[r(:);r2(:);r3(:);r4(:);r5(:);r6(:);r7(:);r8(:);r9(:)];
mur=mean(r5);
dr= std(r5);
o=0:0.01:1;
ph=exp((-0.5)*(((o-mur)/dr).^2));
 gh=(1/(dr*(sqrt((2*pi)))))*ph;
% gh=ph;
figure, plot(o,gh,'r'), hold on
 
g5=[g(:);g2(:);g3(:);g4(:);g5(:);g6(:);g7(:);g8(:);g9(:)];
mug=mean(g5);
dg=std(g5);
o=0:0.001:1;
ps=exp((-0.5)*(((o-mug)/dg).^2));
 gs=(1/(dg*(sqrt((2*pi)))))*ps;
% gs=ps;
plot(o,gs,'b'), hold off

it = imread('nic.jpg');
ah=exp((-0.5)*(((h-mur)/dr).^2));
as=exp((-0.5)*(((s-mug)/dg).^2));
zz=(((1/(dr*(sqrt((2*pi)))



%% Create a mesh and display the gaussian distribution
[h,s]=meshgrid(0:0.002:0.6,0:0.002:0.6);
ah=exp((-0.5)*(((h-mur)/dr).^2));
as=exp((-0.5)*(((s-mug)/dg).^2));
% zz=(((1/(dr*(sqrt((2*pi)))))*ah).*((1/(dg*(sqrt((2*pi)))))*as));
zz=(ah).*(as);

 figure,mesh(h,s,zz)