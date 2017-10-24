clc, clear all, close all;
ima= imread('nic.jpg');
% Bin=im2bw(Ima,0.6);
im=norm1(ima);
[x1,y1,z1]=impixel(im);
c=mean(z1);
% A2=diag(cov(z1));
R=im(:,:,1);
G=im(:,:,2);
B=im(:,:,3);
[fil,col,capa]=size(im);

%Objeto rojo
for i=1:fil
    for j=1:col
        r=(c(1)-double(R(i,j)))^2;
        v=(c(2)-double(G(i,j)))^2;
%         a=(c(3)-double(B(i,j)))^2;
        a=0;
        t=sqrt(r+v+a);
        if (t<=.04)
            Proc(i,j)=120;
        end     
    end
end
imshow(medfilt2(Proc,[3 3])),hold on
[I,J] = find(Proc);        
my= sum(I)/length(I); 
mx= sum(J)/length(J); 
plot(mx, my,'r+');    
hold off; 
