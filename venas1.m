clc, clear all, close all
load fotos6

Ima = fotos6(:,:,:,1);

Im2 = Ima-110;
Im3 = double(Im2);
Im3 = Im3.^1.22;
Im3 = medfilt2(Im3,[3,3]);
figure, subplot(121),imshow(uint8(Im3))
subplot(122), imshow(Ima)
% g1 = gradientweight(
% Im4 = 
[fil col] = size(Ima);
%%
im = double(reshape(Im3, fil*col,1));
c = 10; % Numero de clases
mp = 2;
eps = 0.001;
d = zeros(c, fil*col);

%% V inicial

cont = [];
iterations = 1;
th = 1000;


v = randi([0,255],c,1);
d = zeros(c, fil*col);
tic
    while (th>0.1*c)
        for i=1:c
            d(i,:) = abs(im-v(i));
        end

        d = d+eps;
        m = zeros(size(d));
        for i=1:c
            for j=1:c
                m(i,:) = m(i,:) + (d(i,:)./(d(j,:) + eps)).^2;
            end
            
        end
        m= m.^-1;

        vp =v;
        for i=1:c
                su = m(i,:).^2;
                v(i)=sum(su'.*im)./sum(su);
        end
    % ler(iterations,:) = vp-v;
    th = sum(abs(vp-v));
    th
    iterations = iterations+1;
    end
    
for i=1:c
    m(i,:) = m(i,:)./sum(m);
end

%% Mostrar histograma
% 
% pixel = 0:255;
% for k=1:256;
% 
%     for i=1:c
%         di(i,k) = abs(pixel(k)-v(i));
%     end
% 
%     mu = zeros(size(di));
%     for i=1:c
%         for j=1:c
%             mu(i,:) = mu(i,:) + ((di(i,:)./(di(j,:)+eps))).^2;
%         end
%         mu(i,:) = mu(i,:).^-1;
%     end
% 
% end
% for i=1:c
%     m(i,:) = m(i,:)./sum(m);
% end


[q, w] = sort(v);
r = (2^16-1)/(c-1);
imf = zeros(fil, col);
for i=1:c-1
    imf = reshape(m(w(i+1),:),[fil,col])*r*i+imf;

end
% imf = medfilt2(imf);
figure, subplot(131),imshow(uint16(imf)), title('Fuzzy C-means')
subplot(132), imshow(histeq(Ima)), title('Ecualización de histograma')
subplot(133), imshow(Ima,[]), title('Original')

figure, subplot(131),histogram(uint16(imf)), title('Fuzzy C-means')
subplot(132), histogram(histeq(Ima)), title('Equalización de histograma')
subplot(133), histogram(Ima), title('Original')

% colormap jet
% colorbar