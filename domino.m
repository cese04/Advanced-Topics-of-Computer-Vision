clc, close all, clear all

ima = imread('fichas.jpg');
iman = norm1(ima);

ch1 = (iman(:,:,1)-0.4553).^2;
ch2 = (iman(:,:,2)-0.3591).^2;
ch3 = (iman(:,:,3)-0.1855).^2;
ch4 = sqrt(ch1+ch2+ch3);

ch4=ch4/std(ch4(:));
ch4=medfilt2(ch4,[4 4]);
ch5=ch4>1.2;
se = strel('line',50,90);

ch6=imerode(ch5,se);
imshow(ch6,[])

[L n] =bwlabel(ch6);
imshow(L,[])

MO = zeros(n,6);
figure, imshow(ima), hold on
m=1;
for i=1:n
    MO(i,:)=som(L==i);
    if MO(i,6)>1000
        MI(m,:)=MO(i,:);
        m=m+1;
    end
end
hold off

