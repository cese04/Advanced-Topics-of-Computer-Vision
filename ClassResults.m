

%% Classification test
%This program evaluates the classifier by using the same function for
%taking samples of an image of a fixed size and evaluating the features vector 
%
%Carlos Emiliano Solórzano Espíndola- _carlosemiliano04@gmail.com_
%
% *ETSEIB-UPC*
%% Initialization
%
%Here the program clears all before running the program, also loads the
%previous programed classfier
% 

 clc, close all, clear all
 load('classif2.mat');
%% First image for classification
%
%  Loads the images and evalutes the  _car2()_ function in 200 samples of
%  every image
%

im1='D101.gif';
figure(1),imshow(imread(im1))
car4=zeros(1200,50);
for i=1:200
    car4(i,:)=car2(im1);
    close all
end

figure(2),bar(mean(car4(1:200,:)))

%% Second image for classification
%
im1='D1.gif';
figure,imshow(imread(im1))
for i=1:200
    car4(i+200,:)=car2(im1);
    close all
end
figure(2),bar(mean(car4(201:400,:)))

%% Third image for classification
%
im1='D52.gif';
figure(1),imshow(imread(im1))
for i=1:200
    car4(i+400,:)=car2(im1);
    close all
end
figure(2),bar(mean(car4(401:600,:)))
%% Fourth image for classification
%
im1='D49.gif';
figure(1),imshow(imread(im1))
for i=1:200
    car4(i+600,:)=car2(im1);
    close all
end
figure(2),bar(mean(car4(601:800,:)))

%% Fifth image for classification
%
im1='D20.gif';
figure(1),imshow(imread(im1))
for i=1:200
    car4(i+800,:)=car2(im1);
    close all
end
figure(2),bar(mean(car4(801:1000,:)))

%% Sixth image for classification
%
im1='D3.gif';
figure(1),imshow(imread(im1))
for i=1:200
    car4(i+1000,:)=car2(im1);
    close all
end
figure(2),bar(mean(car4(1001:1200,:)))
%% Mahalanobis distance to classes 
% 
%  Here the program evaluates the Mahalanobis distance for each observation
%  to each class
% 

dist=zeros(1200,6);
for i=1:1200
    dist(i,:)=mahal(X,car4(i,:));
end

figure, subplot(321),bar(dist(:,1)),title('Distance to class 1 [1,200]')
subplot(322),bar(dist(:,2)),title('Distance to class 2 [201,400]')
subplot(323),bar(dist(:,3)),title('Distance to class 3 [401,600]')
subplot(324),bar(dist(:,4)),title('Distance to class 4 [601,800]')
subplot(325),bar(dist(:,5)),title('Distance to class 5 [801,1000]')
subplot(326),bar(dist(:,6)),title('Distance to class 6 [1001,1200]')


%% Evaluation algorithm

comp=cell(1200,3);
eva=zeros(1200,1);
for i=1:1200
    comp(i)={predict(X,car4(i,:))};
end

 for i=1:200
     if strcmp(comp{i},'class 1, D101')==1
         eva(i)=0;
     end
 end
 
 for i=1:200
     if strcmp(comp{i+200},'class 2, D1')==1
         eva(i+200)=0;
     end
 end
 
  for i=1:200
     if strcmp(comp{i+400},'class 3, D52')==1
         eva(i+400)=0;
     end
  end
 
   for i=1:200
     if strcmp(comp{i+600},'class 4, D49')==1
         eva(i+600)=0;
     end
   end
   
   for i=1:200
     if strcmp(comp{i+800},'class 5, D20')==1
         eva(i+800)=0;
     end
   end
 
    for i=1:200
     if strcmp(comp{i+1000},'class 6, D3')==1
         eva(i+1000)=0;
     end
    end
    
    %%
    % 
    %  Error Percentage
    % 


t=sum(eva)/12