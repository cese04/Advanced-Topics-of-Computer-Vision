 
clc, clear all, close all;
ima=imread('piano.jpg');
[fil,col,capa]=size(ima);


if capa==3
    grey(ima);
end
imaexp=zeros(fil+2,col+2);
[fil,col]=size(imaexp);
for i=2:fil-1
    for j=2:col-1
        imaexp(i,j)=double(ima(i-1,j-1));
    end
end
for i=2:fil-1
    for j=2:col-1
        Hh(i-1,j-1)=(0*imaexp(i-1,j-1)+ 0*imaexp(i-1,j)+(-1)*imaexp(i-1,j+1)+0*imaexp(i,j-1)+(1)*imaexp(i,j)+0*imaexp(i,j+1)+(0)*imaexp(i+1,j-1)+(0)*imaexp(i+1,j)+(0)*imaexp(i+1,j+1));
    end
end
for i=2:fil-1
    for j=2:col-1
        Hv(i-1,j-1)=((-1)*imaexp(i-1,j-1)+ 0*imaexp(i-1,j)+(0)*imaexp(i-1,j+1)+0*imaexp(i,j-1)+(1)*imaexp(i,j)+(0)*imaexp(i,j+1)+0*imaexp(i+1,j-1)+0*imaexp(i+1,j)+(0)*imaexp(i+1,j+1));
    end
end

imaf=Hh+Hv;
figure
subplot(221), imshow(uint8(Hh));
subplot(222), imshow(uint8(Hv));
subplot(223), imshow(uint8(imaf));
%figure, imshow(uint8(imaprom1));