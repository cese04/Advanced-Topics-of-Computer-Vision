clc, clear all, close all;
Ima= imread('F001_RGB_06.JPG');
figure, imshow(uint8(Ima))
[x1,y1,z1]=impixel(Ima);
[x2,y2,z2]=impixel(Ima);
[x3,y3,z3]=impixel(Ima);
[x4,y4,z4]=impixel(Ima);
R=Ima(:,:,1);
G=Ima(:,:,2);
B=Ima(:,:,3);
[fil,col,capa]=size(Ima);



A1=mean(z1);
B1=mean(z2);
C1=mean(z3);
D1=mean(z4);
A2=diag(cov(z1));
B2=diag(cov(z2));
C2=diag(cov(z3));
D2=diag(cov(z4))

for i=1:fil
    for j=1:col
        r=double(R(i,j));
        v=double(G(i,j));
        a=double(B(i,j));
        m1=((r-A1(1))^2)/A2(1)+((v-A1(2))^2)/A2(2)+((a-A1(3))^2)/A2(3);
        m2=((r-B1(1))^2)/B2(1)+((v-B1(2))^2)/B2(2)+((a-B1(3))^2)/B2(3);
        m3=((r-C1(1))^2)/C2(1)+((v-C1(2))^2)/C2(2)+((a-C1(3))^2)/C2(3);
        m4=((r-D1(1))^2)/D2(1)+((v-D1(2))^2)/D2(2)+((a-D1(3))^2)/D2(3);
        
        if m1<m2&&m1<m3&&m1<m4
            Proc(i,j)=1;
        end
        if m2<m1&&m2<m3&&m2<m4
            Proc2(i,j)=1;
        end
        if m3<m2&&m3<m1&&m3<m4
            Proc3(i,j)=1;
        end
        
    end
end




figure, subplot(241), imshow(uint8(Ima)),title('Original')
subplot(242),imshow((Proc)),title('Objeto 1')
subplot(243),imshow((Proc2)),title('Objeto 2')
subplot(244),imshow((Proc3)),title('Objeto 3')

[m,n,cap]=size(Proc);
Fianl1=zeros(m,n);
for i=1:m
    for j=1:n
        if (Proc(i,j)==1)
            Final1(i,j,1)=Ima(i,j,1);
            Final1(i,j,2)=Ima(i,j,2);
            Final1(i,j,3)=Ima(i,j,3);
        end     
    end
end
subplot(246),imshow(Final1), title('Objeto 1')

[m,n,cap]=size(Proc2);
%Final2=zeros(m,n);
for i=1:m
    for j=1:n
        if (Proc2(i,j)==1)
            Final2(i,j,1)=Ima(i,j,1);
            Final2(i,j,2)=Ima(i,j,2);
            Final2(i,j,3)=Ima(i,j,3);
        end     
    end
end
subplot(247),imshow(Final2), title('Objeto 2')

[m,n,cap]=size(Proc3);
%Final2=zeros(m,n);
for i=1:m
    for j=1:n
        if (Proc3(i,j)==1)
            Final3(i,j,1)=Ima(i,j,1);
            Final3(i,j,2)=Ima(i,j,2);
            Final3(i,j,3)=Ima(i,j,3);
        end     
    end
end
subplot(248),imshow(Final3), title('Objeto 3')






