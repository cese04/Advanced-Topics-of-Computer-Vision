%% Training 
% This script's main function is to create a new classifier trained with
% data obtained from subimages of six different pictures. the resulting
% classifier has the tags with the names of the classes in the order the
% images were loaded.
clc, close all, clear all

%% 1st Part: Feature extraction
% In this script a vector of 1200 obervations is created with 200 samples
% of each feature vector from random subimages of the
% original picture.

%% 
% First image for classification
im1='IMG_0169.JPG';
car4=zeros(400,50);
for i=1:20
    car4(i,:)=car2(im1);
    close all
end

%% 
% Second image for classification
im1='IMG_0164.JPG';
for i=1:200
    car4(i+200,:)=car2(im1);
    close all
end





%% 2nd part: Training process
% Here a cell array of 'tags' is created with the corresponding names for each
% observation and it's corresponding class. After that a classifier _X_ is
% created 

% Creates an array of type 'cell' for the classes labels
C=cell(400,1);
C(1:200)={'class 1, Pared'};
C(201:400)={'class 2, Piso'};


%%
% The new classifier uses the pseudoLinear type since the observation matrix
% is not a square matrix. For computing the covariance uses the
% pseudoinverse matrix
X=fitcdiscr(car4,C,'discrimType','pseudoLinear')


%% Evaluation
% Compute the Mahalanobis distance from each observation to each class
% First image for classification
im1='IMG_0167.JPG';
car4=zeros(40,50);
for i=1:20
    car4(i,:)=car2(im1);
    close all
end

%% 
% Second image for classification
im1='IMG_0165.JPG';
for i=1:20
    car4(i+20,:)=car2(im1);
    close all
end



dist=zeros(40,2);
for i=1:40
    dist(i,:)=mahal(X,car4(i,:));
end

figure, subplot(321),bar(dist(:,1)),title('Distances to class 1 [1,20]')
axis([0 40 0 inf])
subplot(322),bar(dist(:,2)),title('Distances to class 2 [21,40]')
axis([0 40 0 inf])
% subplot(323),bar(dist(:,3)),title('Distances to class 3 [401,600]')
% axis([0 1200 0 inf])
% subplot(324),bar(dist(:,4)),title('Distances to class 4 [601,800]')
% axis([0 1200 0 inf])
% subplot(325),bar(dist(:,5)),title('Distances to class 5 [801,1000]')
% axis([0 1200 0 inf])
% subplot(326),bar(dist(:,6)),title('Distances to class 1 [1001,1200]')
% axis([0 1200 0 inf])
%%
comp=cell(40,3);
eva=zeros(40,1);
for i=1:40
    comp(i)={predict(X,car4(i,:))};
end

 for i=1:20
     if strcmp(comp{i},'class 1, Pared')==0
         eva(i)=1;
     end
 end
 
 for i=1:20
     if strcmp(comp{i+20},'class 2, Piso')==0
         eva(i+20)=1;
     end
 end