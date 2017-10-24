clc, close all, clear all

ima = imread('ex7.jpg');

[x, y, z] = size(ima);
% Initialize the detectors
faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');
eyesDetector = vision.CascadeObjectDetector('EyePairBig');


%Analyze the image
bboxes = step(faceDetector, ima);
bboxes1 = step(eyesDetector, ima);
imaFaces = insertObjectAnnotation(ima, 'rectangle', bboxes, 'Face');
imaEyes = insertObjectAnnotation(ima, 'rectangle', bboxes1, 'Eyes');

% Display the results
figure, subplot(121), imshow(imaFaces), title('Detected faces');
subplot(122), imshow(imaEyes), title('Detected eyes')

