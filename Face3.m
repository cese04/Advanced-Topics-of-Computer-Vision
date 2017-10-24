clc, clear all, close all;

load trained.mat
load trained2.mat
cam=webcam(1);
cam.Resolution='640x480';
% disp('Presione una tecla')
% pause()

% ima=imread('F003_RGB_02.JPG');
 ima=rgb2gray(snapshot(cam));

    g = size(ima);
    [cx, cy] = meshgrid(1:1:g(1), 1:1:g(2));

while(1)
    tic
    ima=snapshot(cam);
    im=norm1(ima);
    h=im(:,:,1);
    s=im(:,:,2);

    ah=1.3*exp((-0.5)*(((h-mur)/dr).^2))-.5*exp((-0.5)*(((h-murn)/drn).^2));
    as=1.3*exp((-0.5)*(((s-mug)/dg).^2))-.5*exp((-0.5)*(((s-mugn)/dgn).^2));

    zz1=ah.*as;
    zz1=zz1/max(zz1(:));

    zz2=zz1>.2;
    % zz2 = bwmorph(zz2,'fill');  
    % zz2 = bwmorph(zz2,'close');
    % zz2 = bwmorph(zz2,'fill');

    %   figure,imshow(zz2);

    %% Show the reconstructed image


    % Compute the moments


    m00 = sum(sum(double(zz2)));
    m01 = sum(sum(double(cy' .* zz2)))/m00;
    m10 = sum(sum(double(cx' .* zz2)))/m00;

    s01 = sqrt(sum(sum(double((cy' - m01) .^ 2 .* zz2)))/m00);
    s10 = sqrt(sum(sum(double((cx' - m10) .^ 2 .* zz2)))/m00);
    s11 = sqrt(sum(sum(double((cx' - m10) .* (cy'-m01) .* zz2)))/m00);

    %  phi=atan(s10/s11)/(s01/s11);
    phi = .5 * atan((2 * s11 ^ 2)/(s10 ^ 2 - s01 ^ 2));
    subplot(121),imshow(zz2), hold on
    plot(round(m01), round(m10), 'r*','Markersize', 20)
    an = rad2deg(phi)
    % t=0:1:480
    % y=s10*sqrt(1-((t-m01).^2/s01^2))+m10;
    % plot(t,y) 
    ang = 0:0.1:2*pi;
%      p=exp(j*(-phi+ang));
%     xp = 1.2 * s01 * cos(-phi+ang);
%     yp = 1.2 * s10 * sin(ang);
%     plot(m01+2*s01*cos(phi)*real(exp(i*(ang-phi))),m10+2*s10*cos(phi)*imag(exp(i*ang)))
    xp=m01+2*s01*cos(phi)*real(exp(i*(ang-phi)));
    yp=m10+2*s10*cos(phi)*imag(exp(i*ang));
%     plot(xp,yp);
    hold off
    
%      BW = roipoly(ima, xp, yp);
% %     BW=flip(BW);
%     
%     a = 100;
%     myString = sprintf('Location x:%i , y:%i Angle: %i °',round(m01), round(m10), round(an));
%     title(myString)
%     
%     im2= double(BW) .* double(rgb2gray(ima))/255;
% %     ima= double(BW) .* double(rgb2gray(ima));
%     sub = im2(round(m10-(2*s10)*cos(phi)):round(m10+(1*s10)*cos(phi)),...
%         round(m01-(2*s01)*(cos(phi))):round(m01+(2*s01)*(cos(phi))));
%     im = imrotate(sub,-an);
%      subplot(122),imshow(im)

    
end