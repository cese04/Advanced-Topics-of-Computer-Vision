% function B=hist3D(Ima);
Ima=imread('elephant.jpg');
Ima=double(Ima);
tic

n=10

for i=1:10
    for j=1:10
        for k=1:10
            A=sum((Ima(:,:,1)<i*51&Ima(:,:,2)<j*51&Ima(:,:,3)<k*51)&(Ima(:,:,1)<(i-1)*51&Ima(:,:,2)<(j-1)*51& Ima(:,:,3)<(k-1)*51));
            B(i,j,k)=sum(A(:));
        end
    end
    toc
end

