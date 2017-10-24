%% Classification test
% This program evaluates the classifier by using the same function for
% taking samples of an image of a fixed size and evaluating the features vector 
%
% Carlos Emiliano Solórzano Espíndola-_carlosemiliano04@gmail.com_
%
% *ETSEIB-UPC*
%
%% Initialization
% Here the program clears all before running the program, also loads the
% previous programed classfier
% 

 clc, close all, clear all
 load('classif2.mat');
%% First image for classification
% Loads the images and evalutes the  _car2()_ function in 20 samples of
% every image which will be the feature vector of 100*1 size , also displays the averaged feature vector for the samples

im1='D101.gif';

car4=zeros(120,50);
for i=1:20
    car4(i,:)=car2(im1);
    close all
end
figure,subplot(121),imshow(imread(im1))
subplot(122),bar(mean(car4(1:20,:)))

%% Second image for classification
%
im1='D1.gif';

for i=1:20
    car4(i+20,:)=car2(im1);
    close all
end
figure,subplot(121),imshow(imread(im1))
subplot(122),bar(mean(car4(21:40,:)))


%% Third image for classification
%
im1='D52.gif';

for i=1:20
    car4(i+40,:)=car2(im1);
    close all
end
figure,subplot(121),imshow(imread(im1))
subplot(122),bar(mean(car4(41:60,:)))

%% Fourth image for classification
%
im1='D49.gif';

for i=1:20
    car4(i+60,:)=car2(im1);
    close all
end
figure,subplot(121),imshow(imread(im1))
subplot(122),bar(mean(car4(61:80,:)))


%% Fifth image for classification
%
im1='D20.gif';

for i=1:20
    car4(i+80,:)=car2(im1);
    close all
end
figure,subplot(121),imshow(imread(im1))
subplot(122),bar(mean(car4(81:100,:)))


%% Sixth image for classification
%
im1='D3.gif';

for i=1:20
    car4(i+100,:)=car2(im1);
    close all
end
figure,subplot(121),imshow(imread(im1))
subplot(122),bar(mean(car4(101:120,:)))

%% Mahalanobis distance to classes 
% Here the program evaluates the Mahalanobis distance for each observation
% to each class
% 

dist=zeros(120,6);
for i=1:120
    dist(i,:)=mahal(X,car4(i,:));
end

figure(3), subplot(321),bar(dist(:,1)),title('Distance to class 1 [1,20]')
axis([0 120 0 inf])
subplot(322),bar(dist(:,2)),title('Distance to class 2 [21,40]')
axis([0 120 0 inf])
subplot(323),bar(dist(:,3)),title('Distance to class 3 [41,60]')
axis([0 120 0 inf])
subplot(324),bar(dist(:,4)),title('Distance to class 4 [61,80]')
axis([0 120 0 inf])
subplot(325),bar(dist(:,5)),title('Distance to class 5 [81,100]')
axis([0 120 0 inf])
subplot(326),bar(dist(:,6)),title('Distance to class 6 [101,120]')
axis([0 120 0 inf])

%% Evaluation algorithm
% Campares the tagged vector from the predictor to the real tag that it should
% have depending on the class, each time an error ocurrs the eva vector
% gets a value of one in the corresponding observation
comp=cell(120,3);
eva=zeros(120,1);
for i=1:120
    comp(i)={predict(X,car4(i,:))};
end

 for i=1:20
     if strcmp(comp{i},'class 1, D101')==0
         eva(i)=1;
     end
 end
 
 for i=1:20
     if strcmp(comp{i+20},'class 2, D1')==0
         eva(i+20)=1;
     end
 end
 
  for i=1:20
     if strcmp(comp{i+40},'class 3, D52')==0
         eva(i+40)=1;
     end
  end
 
   for i=1:20
     if strcmp(comp{i+60},'class 4, D49')==0
         eva(i+60)=1;
     end
   end
   
   for i=1:20
     if strcmp(comp{i+80},'class 5, D20')==0
         eva(i+80)=1;
     end
   end
 
    for i=1:20
     if strcmp(comp{i+100},'class 6, D3')==0
         eva(i+100)=1;
     end
    end
    
%% Result
% Error Percentage
% 

t=sum(eva)/1.2