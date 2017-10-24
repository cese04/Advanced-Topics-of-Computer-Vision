clc, close all, clear all
I=imread('moon.jpg');
I=I-mean(I(:));
f = fftshift(fft2(I));
fabs=abs(f);

roi=3;thresh=400;
local_extr = ordfilt2(fabs, roi^2, ones(roi));  % find local maximum within 3*3 range

result = (fabs == local_extr) & (fabs > thresh);

[r, c] = find(result);
for i=1:length(r)
    if (r(i)-128)^2+(c(i)-128)^2>400   % periodic noise locates in the position outside the 20-pixel-radius circle
%         f(r(i)-2:r(i)+2,c(i)-2:c(i)+2)=0;  % zero the frequency components
          f(r(i),c(i))=0;
    end
end

Inew=ifft2(fftshift(f));
imagesc(real(Inew)),colormap(gray),