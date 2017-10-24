clc, clear all, close all;

clc, clear all, close all
% Load the previously trained data for color data
load trained.mat
load trained2.mat

cam = webcam(3);
% cam.Resolution = '320x240';

ima = rgb2gray(snapshot(cam));
 
g = size(ima);
[cx, cy] = meshgrid(1:1:g(1), 1:1:g(2));

while(1)
    % Input image from the 
    ima = snapshot(cam);
    im = norm1(ima);
    r = im(:, :, 1);
    g = im(:, :, 2);
    
    % Obtain the probability of being skin
    ar = 1.3*exp((-0.5)*(((r - mur)/dr).^2)) - .5 * exp((-0.5)*(((r-murn)/drn).^2));
    ag = 1.3*exp((-0.5)*(((g - mug)/dg).^2)) - .5 * exp((-0.5)*(((g-mugn)/dgn).^2));

    zz1 = ar.*ag;
    zz1 = zz1/max(zz1(:));
    
    % Create a second image with the pixels that surpass the threshold
    zz2 = zz1>.1;
  
    % Compute the moments
    m00 = sum(sum(double(zz2)));
    m01 = sum(sum(double(cy' .* zz2)))/m00;
    m10 = sum(sum(double(cx' .* zz2)))/m00;

    s01 = sqrt(sum(sum(double((cy' - m01) .^ 2 .* zz2)))/m00);
    s10 = sqrt(sum(sum(double((cx' - m10) .^ 2 .* zz2)))/m00);
    s11 = sqrt(sum(sum(double((cx' - m10) .* (cy'-m01) .* zz2)))/m00);

    % Compute the relative angle
    phi = .5 * atan((2 * s11 ^ 2)/(s10 ^ 2 - s01 ^ 2));
    
    subplot(121),imshow(ima), hold on
    plot(round(m01), round(m10), 'r*','Markersize', 20)
    an = rad2deg(phi)
   
    ang = 0:0.1:2*pi;

    xp = m01 + 2 * s01 * cos(phi) * real(exp(1i * (ang-phi)));
    yp = m10 + 2 * s10 * cos(phi) * imag(exp(1i * ang));
    plot(xp,yp);
    hold off
    
    % Create an ellipsoidal mask
    BW = roipoly(ima, xp, yp);
    
    a = 100;
    myString = sprintf('Location x:%i , y:%i Angle: %i °',round(m01), round(m10), round(an));
    title(myString)
    
    % Obtain the subimage containing the face
    im2= double(BW) .* double(rgb2gray(ima))/255;

    sub = im2(round(m10-(2*s10)*cos(phi)):round(m10+(1*s10)*cos(phi)),...
        round(m01-(2*s01)*(cos(phi))):round(m01+(2*s01)*(cos(phi))));
    im = imrotate(sub,-an);
    subplot(122),imshow(im)
end