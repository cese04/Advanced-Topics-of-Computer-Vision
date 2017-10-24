clc, close all, clear all
ima = imread('reto_viral.jpg');
[fil, col, ca]=size(ima);
if ca==3
    ima = rgb2gray(ima);
end
% ima=rgb2gray(ima);
% figure, subplot(121),imshow(ima)
ima = double(ima);
[x, y, z] = size(ima);

% Create the noise
f = 0.4;  %Adjust frequency (works fine between 0.05 to 0.4)
w = (2 * pi * f);  %
A = 30;   %Adjust intensity
P = 0:w:y * w-w;
R = A * sin(P);
R2 = zeros(x, y);

for i = 1:x
    R2(i, :) = R;
end

 R3 = zeros(x, y);
%Create the second noise ---------------(UNCOMMENT this section for bidirectional noise)
 f2 = 0.1; %Second frequency
 w2 = 2 * pi * f2;
 A2 = 40;  %Second intensity
 Pi = 0:w2:x * w2-w2;
 Ri = A * sin(Pi);

 for i = 1:y
    R3(:, i) = Ri;
 end

% alvaro.anzueto.rios@gmail.com
%%


% imN = R2 + ima + R3;
imN = double(ima);
me = mean(imN(:));
imN = imN - me; %Substract the mean for better performance in Fourier
% subplot(122),imshow(uint8(imN))

imaf = fft2(ima);
imNf = fft2(imN);

fr = fftshift(imaf);
frN = fftshift(imNf);
fos = log(1+abs(fr));
fis = log(1+abs(frN));
% S=abs(fr);
figure, subplot(121), imshow(fos,[]), title('Orinal image spectrum');
subplot(122), imshow(fis,[]), title('Image with noise spectrum');
%%
figure, subplot(121), surf(fis, 'EdgeColor', 'none', 'LineStyle', 'none')
subplot(122), surf(fos, 'EdgeColor', 'none', 'LineStyle', 'none')


%% 

g = size(ima);
[cx, cy] = meshgrid(1:1:g(1), 1:1:g(2));

fabs = abs(frN);

roi = 2;thresh = max(fabs(:)*.05);
local_extr = ordfilt2(fabs, roi^2, ones(roi));  % find local maximum within roi * roi range (works great with 2*2 or 3*3)

result = (fabs == local_extr) & (fabs > thresh);

figure, imshow(result),title('Local max'), hold on

m00 = sum(sum(double(result)));
m01 = sum(sum(double(cy' .* result)))/m00;
m10 = sum(sum(double(cx' .* result))    )/m00;

s01 = sqrt(sum(sum(double((cy' - m01) .^ 2 .* result)))/m00);
s10 = sqrt(sum(sum(double((cx' - m10) .^ 2 .* result)))/m00);
s11 = sqrt(sum(sum(double((cx' - m10) .* (cy'-m01) .* result)))/m00);

phi = .5 * atan((2 * s11 ^ 2)/(s10 ^ 2 - s01 ^ 2));
plot(round(m01), round(m10), 'r*','Markersize', 20)
    an = rad2deg(phi)
   
    ang = 0:0.1:2*pi;

    xp = m01+s01*real(exp(1i*(ang-phi)));
    yp = m10+s10*imag(exp(1i*ang));
    plot(xp,yp);
    hold off
    
    BW = roipoly(ima, xp, yp);
    
    result = result & ~BW;
    

[r, c] = find(result);                      %Find the coordinates of the max values
wer=0;
filt1=1-fftshift(lpfilter('gauss',7,7,10,1));
%%
for i = 1:length(r)

        a = frN(r(i) - 3:r(i) + 3, c(i) - 3:c(i) + 3);  %Set an area around the maximum
        b = mean(a(:));                    %Find the local minimum
        frN(r(i) - 3:r(i) + 3, c(i) - 3:c(i) + 3) = a.*filt1;  % assign the minimum of the local area to the entire area
        
        wer=wer+1

end
S=log(1+abs(frN));
Inew2=ifft2(ifftshift(frN));
figure,subplot(221),imshow(uint8(ima));
subplot(222),imshow(uint8(imN+me)); % Add again the mean to the image with noise and the reconstructed one
subplot(223),imshow(uint8(abs(Inew2+me)),[]);
subplot(224),surf(S,'EdgeColor','none','LineStyle','none') %Show the notched spectrum

