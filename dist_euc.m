clc, clear all, close all

Ima= imread('4.JPG');

A = norm1(Ima);

V = rand(3);

clases = 3;
A1 = A(:,:,1);
A2 = A(:,:,2);
A3 = A(:,:,3);

B = [A1(:), A2(:), A3(:)]*255;

for i=1:3
    a = 0;
    for j=1:3
        a = B(:,j).^2-V(i,j).^2 + a;
    end
    D(:,j) = sqrt(a);
end

