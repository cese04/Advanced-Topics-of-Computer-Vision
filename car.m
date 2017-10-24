function features=car(im)
ima=imread(im);
hold on
figure(1),imshow(ima), title('Double-click a zone in the image');
[l,r,P] = impixel(ima);
cort=ima((l:l+99),(r:r+99));
[b c]=spect1(cort);
figure(1),line([l,l],[r,r+99],'LineWidth',5)
figure(1),line([l,l+99],[r,r],'LineWidth',5)
figure(1),line([l+99,l+99],[r,r+99],'LineWidth',5)
figure(1),line([l,l+99],[r+99,r+99],'LineWidth',5)
hold off
%Calculamos anillos de espectro horizontal
[x y]=size(b);
%numero de anillos
n=50;
if x>=y
h=x/n;
t=x;
end
if y>=x
h=y/n;
t=y;
end
Eh=[];
Eeh=[];
for i=1:n/2
    f=0;
g=lpfilter('ideal',x,y,h*i);
g2=1-lpfilter('ideal',x,y,h*(i-1));
fi=b.*g.*g2;
d=uint8(ifft2(fi));
e=sum(d(:));
    Eh(i)=e;


end

%Calculamos anillos de espectro vertical

%numero de anillos

Ev=[];
Eev=[];
for i=1:n/2

    g=lpfilter('ideal',x,y,h*i);
    g2=1-lpfilter('ideal',x,y,h*(i-1));
    fi=c.*g.*g2;

    d=uint8(ifft2(fi));
    e=sum(d(:));

   
    Ev(i)=e;
end

Eh=Eh/max(Eh);
Ev=Ev/max(Ev);
figure
subplot(211),(bar(Eh(1:n/2)))
subplot(212),(bar(Ev(1:n/2)))

features(1:25)=Eh;
features(26:50)=Ev;