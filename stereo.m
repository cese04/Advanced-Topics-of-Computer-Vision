clc,close all, clear all
imaL = imread('left2.png'); %left
imaR = imread('right2.png'); %right

figure,
subplot(121), imshow(imaL)
subplot(122), imshow(imaR)

Hx = [-1,0,1;-2,0,2;-1,0,1];

Hy = [1,2,1;0,0,0;-1,-2,-1];

imaL = rgb2gray(imaL);
imaR = rgb2gray(imaR);

imL=double(imaL);
imR=double(imaR);
[x, y] = size(imaL);

%% Find the edges with a Sobel filter
ed=edge(imaR,'Sobel',.03);

% Perform morphological operations to improve the edges
ed = bwmorph(ed,'bridge');
ed = bwmorph(ed,'bridge');
se1 = strel('line',2,0);
se2 = strel('line',2,90);
ed = imdilate(ed,[se1 se2]);

ed(1,:)=1;
ed(:,1:5)=1;
ed(:,y)=0;

 subplot(122), imshow(ed), title('Edges')
 subplot(121), imshow(imaR),title('Original Image')

%% Find the difference amogn pixels
d = 15;         %Maximum disparity
dm=zeros(x,y);
for i=1:d
    n = zeros(size(imaL));
    n((1:x),(1:y-i)) = imL((1:x),(1+i:y));
    dm(:,:,i)=abs(imR-n);
end

%% Rough estimation of depth
% for i=1:d
%     

% subplot(224), imshow(Ima)
    
% for i=1:x
%     for j=1:y
%         a=zeros(1,d);
%         a(:)=dm(i,j,:);
%         [zx, xc]=min(a);
%         nm(i,j)=xc;
%     end
% end
% % nm=25-nm;
% nm=medfilt2(nm,[5 5]);
% figure,imshow(nm,[]), title('Rough estimation')
% 
% %% Using a window
% 
% % Window size 3
% IM3=zeros(size(dm));
% for k=1:d
%     h = fspecial('average', [3 3]);
%     IM3(:,:,k)=imfilter(dm(:,:,k),h);
% end
% 
% Window size 5
IM5=zeros(size(dm));
for k=1:d
    h = fspecial('average', [5 5]);
    IM5(:,:,k)=imfilter(dm(:,:,k),h);
end

%Window size 7
IM7=zeros(size(dm));
for k=1:d
    h = fspecial('average', [11 11]);
    IM7(:,:,k)=imfilter(dm(:,:,k),h);
end

IM=(dm+IM5+IM7)./3;

for i=1:x
    for j=1:y
        a=zeros(1,d);
        a(:)=IM(i,j,:);
        [zx, xc]=min(a);
        nmI(i,j)=xc;
    end
end

nmI=medfilt2(nmI,[3 3]);
figure, subplot(121),imshow(nmI,[]), title('Disparity map')

%% Using candidates
c=0;
fnl=zeros(x,y);
for i=1:x
    for j=1:y
        if ed(i,j)==1
            c=nmI(i,j+1);
        end
        fnl(i,j)=c;
    end
end

fnl=medfilt2(fnl,[7 7]);
subplot(122),imshow(fnl,[]), title('Using the edges pixels')
 figure('units','normalized','outerposition',[0 0 1 1]), surf(fnl','EdgeColor','none','FaceLighting','gouraud')
 az=45;
 el=75;
 view(az, el);