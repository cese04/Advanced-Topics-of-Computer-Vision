clc, close all, clear all
%Imagen de fondo
fon=imread('back.png');
%Imagen a identificar 
Ima=imread('VC (1).png');
g=1.05;

fon=single(fon);
Ima=single(Ima);
fon=fon.^g;
Ima=Ima.^g;

im=Ima-fon;
im=abs(im);
ir=im>80;
iw=ir.*Ima;

R=Ima(:,:,1);
G=Ima(:,:,2);
B=Ima(:,:,3);
[fil,col,capa]=size(Ima);

rojo=zeros(1,fil,col);
verde=zeros(1,fil,col);
azul=zeros(1,fil,col);


rojo=R(:);
verde=G(:);
azul=B(:);

a=10;
for i=1:10
    hist(i,1)=length(find(rojo<i*255/a & rojo>=(i-1)*255/a));
end
for i=1:10
    hist(i,2)=length(find(verde<i*255/a & verde>=(i-1)*255/a));
end
for i=1:10
    hist(i,3)=length(find(azul<i*255/a & azul>=(i-1)*255/a));
end
    
figure,subplot(221),plot3(rojo,verde,azul,'.')
xlabel('Rojo') % x-axis label
ylabel('Verde') % y-axis label
zlabel('Azul') % y-axis label
subplot(222),plot3(hist(:,1),hist(:,2),hist(:,3),'.')

figure,subplot(221),imshow(uint8(fon));
subplot(222),imshow(uint8(Ima));
subplot(223),imshow(uint8(iw));