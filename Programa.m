%%%%%%%
%Programa del reconocedor
clear all, close all, clc;
a_1=cargar_imagenes(  );
%imshow(a_1);
a_1=double(a_1);
%%%%Quizá normalizar a y/o re-escalar
a_1=a_1/255;

for i=1:10
       LPC(:,i) = lpc(a_1(:,i),15);
end

a = LPC(2:end,:);

pseudo=((a'*a)^-1)*a';
%%%%Quizá vamos a reducir los valores del vector de A
target=[1 1 1 1 1 0 0 0 0 0; 0 0 0 0 0 1 1 1 1 1];
W=target*pseudo;

%b=cargar_imagenes(  );%%%Este vector debe ser una nueva fotografia que uno mismo le haga el imcrop
    %%%Iniciamos camara
    video=videoinput('winvideo',1,'YUY2_640x480');
    set(video, 'ReturnedColorSpace','rgb')
    preview(video);
    pause
        foto=getsnapshot(video);
           nombre = 'NuevaFoto.jpg';
           imwrite(foto,nombre);
           image(foto);
           Imagen=imread(nombre);
    delete(video);

    [a1,b1]=imcrop(Imagen);  %%%Le hacemos el recorte a la nueva imagen
    A1=imresize(rgb2gray(a1),[120,100]);   %%%Redimencionamos la nueva imagen
    v=zeros(12000,1);                
    v(:,1)=reshape(A1,size(A1,1)*size(A1,2),1); %%%Hacemos que V tenga a la imagen A1 en un único vector
    b=v;
b=double(b);
b=b/255;

LPC=lpc(b,15);
b=LPC(2:end);

%%%%%Desarrollar neurona
T_1=W(1,:)*b';   %%%Transponer cuando se haga un LPC
T_2=W(2,:)*b';
