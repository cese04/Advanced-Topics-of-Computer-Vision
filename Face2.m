clc, clear all, close all;

load trained.mat
load trained2.mat
tic
ima=imread('F011_RGB_02.JPG');
ref=rgb2gray(imread('F003_RGB_01.JPG'));
ref=imrotate(ref,-20);
points2 = detectSURFFeatures(ref);
[f2, vpts2] = extractFeatures(ref, points2);
im=norm1(ima);
h=im(:,:,1);
s=im(:,:,2);

ah=1.3*exp((-0.5)*(((h-mur)/dr).^2))-.5*exp((-0.5)*(((h-murn)/drn).^2));
as=1.3*exp((-0.5)*(((s-mug)/dg).^2))-.5*exp((-0.5)*(((s-mugn)/dgn).^2));

zz1=ah.*as;
zz1=zz1/max(zz1(:));

zz2=zz1>.3;
% zz2 = bwmorph(zz2,'fill');  
% zz2 = bwmorph(zz2,'close');
% zz2 = bwmorph(zz2,'fill');

%   figure,imshow(zz2);

%% Show the reconstructed image

% ir=zeros(size(ima));
% ir(:,:,1)=double(ima(:,:,1)).*zz1;
% ir(:,:,2)=double(ima(:,:,2)).*zz1;
% ir(:,:,3)=double(ima(:,:,3)).*zz1;

%% Compute the moments

g=size(zz1);
[cx,cy]=meshgrid(1:1:g(1),1:1:g(2));

m00=sum(sum(double(zz2)));
m01=sum(sum(double(cy'.*zz2)))/m00;
m10=sum(sum(double(cx'.*zz2)))/m00;

s01=sqrt(sum(sum(double((cy'-m01).^2.*zz2)))/m00);
s10=sqrt(sum(sum(double((cx'-m10).^2.*zz2)))/m00);
 s11=sqrt(sum(sum(double((cx'-m10).*(cy'-m01).*zz2.*zz2)))/m00);

figure,subplot(122),imshow(zz2), hold on
% plot(round(m01),round(m10),'r*','Markersize',20)

% t=0:1:480
% y=s10*sqrt(1-((t-m01).^2/s01^2))+m10;
% plot(t,y) 
% ang=0:0.01:2*pi;
% xp=1.2*s01*cos(ang);
% yp=1.2*s10*sin(ang);
% plot(m01+xp,m10+yp);
hold off
subplot(121), imshow(ima)
%% Imagette
tic
% n=rgb2gray(ima);

sub=double(ima(round(m10-1.2*s10):round(m10+1.2*s10),round(m01-1.5*s01):round(m01+1.5*s01)))/255;
% figure, imshow(sub), hold on
hh=[-1,0,1;-2,0,1;-1,0,1];
hv=[-1,-2,-1;0,0,0;1,2,1];

% Gx=imfilter(sub,hh);
% Gy=imfilter(sub,hv);
% Gxx=imfilter(Gx,hh);
% Gyy=imfilter(Gy,hv);
% Gxy=imfilter(Gx,hv);
% sum=Gx+Gy+Gxx+Gyy+Gxy;
% 
% % Feature vector and normalization of data
% G(:,:,1)=(Gx-mean(Gx(:)))/std(Gx(:));
% G(:,:,2)=(Gy-mean(Gy(:)))/std(Gy(:));
% G(:,:,3)=(Gxx-mean(Gxx(:)))/std(Gxx(:));
% G(:,:,4)=(Gyy-mean(Gyy(:)))/std(Gyy(:));
% G(:,:,5)=(Gxy-mean(Gxy(:)))/std(Gxy(:));

% G(:,:,1)=G(:,:,1)/std(G(:,1));
% G(:,:,2)=G(:,:,2)/std(G(:,2));
% G(:,:,3)=G(:,:,3)/std(G(:,3));
% G(:,:,4)=G(:,:,4)/std(G(:,4));
% G(:,:,5)=G(:,:,5)/std(G(:,5));

% F(:,1)=Gx(:)-mean(Gx(:));
% F(:,2)=Gy(:)-mean(Gy(:));
% F(:,3)=Gxx(:)-mean(Gxx(:));
% F(:,4)=Gyy(:)-mean(Gyy(:));
% F(:,5)=Gxy(:)-mean(Gxy(:));
% 
% F(:,1)=F(:,1)/std(F(:,1));
% F(:,2)=F(:,2)/std(F(:,2));
% F(:,3)=F(:,3)/std(F(:,3));
% F(:,4)=F(:,4)/std(F(:,4));
% F(:,5)=F(:,5)/std(F(:,5));
% [a,b] = size(Gx);
% [id, C]=kmeans(F,3);
% t=reshape(id,a,b);
% figure,surf(t)
points = detectSURFFeatures(sub);
% imshow(sub); hold on;

% plot(points.selectStrongest(10));hold off;

%  [f1, vpts1] = extractFeatures(sub, points);
%    
%   indexPairs = matchFeatures(f1, f2,'Method','NearestNeighborRatio','Prenormalized',true,'Metric','SSD') ;
%    matchedPoints1 = vpts1(indexPairs(:, 1));
%    matchedPoints2 = vpts2(indexPairs(:, 2));
%  figure; showMatchedFeatures(sub, ref, matchedPoints1, matchedPoints2);
toc