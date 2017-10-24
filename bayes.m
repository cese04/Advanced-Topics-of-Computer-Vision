clc, close all, clear all;
ima=imread('alex.jpg');
HSV=rgb2hsv(ima);  %lectura de imagen y transformacion a hsv
[a,b]=imcrop(HSV);
H=a(:,:,1);
S=a(:,:,2);
 
%En esta seccion se seleciona de los diferentes rostros una muestra, de
%piel en este caso, pero el calsificador permite que la muestra sea del
%objeto deseado, ya sea cabello u otra cosa que se desee clasificar
% figure
ima2=imread('zapatero.jpg');
HSV2=rgb2hsv(ima2);
[a2,b2]=imcrop(HSV2);
H2=a2(:,:,1);
S2=a2(:,:,2);
 
 
 
% figure
ima3=imread('nadal.jpg');
HSV3=rgb2hsv(ima3);
[a3,b3]=imcrop(HSV3);
H3=a3(:,:,1);
S3=a3(:,:,2);
 
%Se juntan las muestras de piel en un solo vector y se sacan los datos
%estadisticos necesario para formar la campana de gauss y nustra ecuacion
%para el clasificador
%Se plotean ambas caracteristicas, la H y la S de las muestras tomadas de
%las imagenes
 
h4=[H(:);H2(:);H3(:)];
muh=mean(h4);
dh= std(h4);
o=0:0.01:1;
ph=exp((-0.5)*(((o-muh)/dh).^2));
gh=(1/(dh*(sqrt((2*pi)))))*ph;
figure, plot(o,gh,'r'), hold on
 
s4=[S(:);S2(:);S3(:)];
mus=mean(s4);
ds=std(s4);
o=0:0.001:1;
ps=exp((-0.5)*(((o-mus)/ds).^2));
gs=(1/(ds*(sqrt((2*pi)))))*ps;
plot(o,gs,'b'), hold off
%Se procede a mostrar la campana de gauss en una grafica 3D  usando la
%caracteristica H y S como ejes del plano en 2D y la probabilidad de
%repeticion entre ellos como nuestro plano z
 
[h,s]=meshgrid(0:0.001:0.3,0:0.001:0.6);
ah=exp((-0.5)*(((h-muh)/dh).^2));
as=exp((-0.5)*(((s-mus)/ds).^2));
zz=(((1/(dh*(sqrt((2*pi)))))*ah).*((1/(ds*(sqrt((2*pi)))))*as));

figure,mesh(h,s,zz)
 
%ya obtenida nuestra ecuacion de la campana de gauss, se procede a pasar
%una nueva imagen, transformarla a hsv y barrer pixel por pixel en busca
%del patron a clasificar que queremos, ademas de hacer una nueva imagen que
%solo contenga este objeto, en este caso la piel 
%%
tic
 pru=imread('nadal.jpg');
figure,imshow(pru);
hsvp = rgb2hsv(pru);
[fil,col,capa]=size(hsvp);

for i=1:fil
    for j=1:col
        ah=exp((-0.5)*(((hsvp(i,j,1)-muh)/dh).^2));
        as=exp((-0.5)*(((hsvp(i,j,2)-mus)/ds).^2));
        zzp(i,j) = ((1/(ds*sqrt(2*pi)))*as.*((1/(dh*sqrt(2*pi)))*ah));
      
%         if (zzp(i,j)<=5 && zzp(i,j)>=2)
%             hsvp2(i,j,1)=hsvp(i,j,1);
%             hsvp2(i,j,2)=hsvp(i,j,2);
%             hsvp2(i,j,3)=hsvp(i,j,3);
%         else
%             
%             hsvp2(i,j,3)=0;
%         end
 
    end
end
% ima2= hsv2rgb(hsvp2);
% zzp=uint8(zzp);
% zzp=medfilt2(zzp);
toc
figure,imshow(uint8(zzp));

