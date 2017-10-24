clc, clear all, close all

Ima=imread('3.jpg');
im=norm1(Ima);
[a,b]=imcrop(im);
r=a(:,:,1);
g=a(:,:,2);

Ima=imread('4.jpg');
im=norm1(Ima);
[a2,b2]=imcrop(im);
r2=a2(:,:,1);
g2=a2(:,:,2);

Ima=imread('5.jpg');
im=norm1(Ima);
[a3,b3]=imcrop(im);
r3=a3(:,:,1);
g3=a3(:,:,2);

Ima=imread('6.jpg');
im=norm1(Ima);
[a4,b4]=imcrop(im);
r4=a4(:,:,1);
g4=a4(:,:,2);
%% Get the standard deviation and mean of the observations
tic
r5=[r(:);r2(:);r3(:);r4(:)];
muh=mean(r5);
dh= std(r5);
o=0:0.01:1;
ph=exp((-0.5)*(((o-muh)/dh).^2));
% gh=(1/(dh*(sqrt((2*pi)))))*ph;
gh=ph;
figure, plot(o,gh,'r'), hold on
 
g5=[g(:);g2(:);g3(:);g4(:)];
mus=mean(g5);
ds=std(g5);
o=0:0.001:1;
ps=exp((-0.5)*(((o-mus)/ds).^2));
% gs=(1/(ds*(sqrt((2*pi)))))*ps;
gs=ps;
plot(o,gs,'b'), hold off


%% Create a mesh and display the gaussian distribution
[h,s]=meshgrid(0:0.002:0.6,0:0.002:0.6);
ah=exp((-0.5)*(((h-muh)/dh).^2));
as=exp((-0.5)*(((s-mus)/ds).^2));
zz=(((1/(dh*(sqrt((2*pi)))))*ah).*((1/(ds*(sqrt((2*pi)))))*as));

 figure,mesh(h,s,zz)


%% Calculate the probability for the pixels in the image

ima=imread('zapatero.jpg');
im=norm1(ima);
h=im(:,:,1);
s=im(:,:,2);

ah=exp((-0.5)*(((h-muh)/dh).^2));
as=exp((-0.5)*(((s-mus)/ds).^2));
% zz1=(((1/(dh*(sqrt((2*pi)))))*ah).*((1/(ds*(sqrt((2*pi)))))*as));
zz1=ah.*as;
zz1=zz1/max(zz1(:));

zz2=zz1>.3;
%   zz2 = bwmorph(zz2,'close');
% zz4 = zz2-zz3;
% zz2=double(zz2);
% zz2=medfilt2(zz2,[2 2]);
% figure,imshow(bwmorph(zz2,'fill'))
% figure,imshow(zz2);

%% Show the reconstructed image

ir=zeros(size(ima));
ir(:,:,1)=double(ima(:,:,1)).*zz1;
ir(:,:,2)=double(ima(:,:,2)).*zz1;
ir(:,:,3)=double(ima(:,:,3)).*zz1;

figure,imshow(uint8(ir))
toc

%% Compute the moments

g=size(zz1);
[cx,cy]=meshgrid(1:1:g(1),1:1:g(2));

m00=sum(sum(double(zz2)));
m01=sum(sum(double(cy'.*zz2)))/m00;
m10=sum(sum(double(cx'.*zz2)))/m00;

s01=sqrt(sum(sum(double((cy'-m01).^2.*zz2)))/m00);
s10=sqrt(sum(sum(double((cx'-m10).^2.*zz2)))/m00);
s11=sqrt(sum(sum(double((cx'-m10).*(cy'-m01).*zz2)))/m00);

figure,imshow(zz1), hold on
plot(round(m01),round(m10),'r*','Markersize',20), hold off

%%
ii=rgb2gray(uint8(ima));
ii=double(ii).*zz2;
  figure,surface(sqrt(ii), 255-double(ima), 'FaceColor', 'texturemap',...
 'EdgeColor','none',...
 'CDataMapping','direct')
 colormap(map);
%  view(210,75);

%% Imagette
tic
sub=zz2(round(m10-1*s10):round(m10+1*s10),round(m01-1*s01):round(m01+1*s01));
% sub=medfilt2(sub,[12 12]);
sub=1-sub;
 figure, imshow(sub), hold on;
 X=[];
 [X(:,2), X(:,1)]=find(sub');
 [idx,C] = kmeans(X,3);
%   figure;
% plot(X(idx==1,1),X(idx==1,2),'ro'); hold on;
% plot(X(idx==2,1),X(idx==2,2),'b^');
% plot(X(idx==3,1),X(idx==3,2),'g^');
toc
plot(C(:,2),C(:,1),'b.','MarkerSize',50), hold off;