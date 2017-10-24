 clc, close all, clear all
ima=(imread('zapatero.jpg'));
ima=double(ima);
R=ima(:,:,1);
G=ima(:,:,2);
B=ima(:,:,3);
[x,y]=size(R);

I=logopp(G+R+B)/3;
Rg=logopp(R)-I;
By=logopp(B)-(I+logopp(R))/2;


 sc=(x+y)/max(x,y);
 sc=2*round(sc);
 sc=1
%%
n=medfilt2(I,[8*sc 8*sc]);
N=abs(I-n);
N=medfilt2(N,[12*sc 12*sc]);

% figure,subplot(221),imshow(uint8(I))
% subplot(222),imshow(uint8(Rg))
% subplot(223),imshow(uint8(By))
% subplot(224),imshow(N)
figure, imshow(N)

%%
% A=sum((ima(:,:,1)<51&ima(:,:,2)<51&ima(:,:,3)<51));
% B=sum(A(:))

