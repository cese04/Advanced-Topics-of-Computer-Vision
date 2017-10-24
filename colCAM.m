 % clc,close all, clear all
clear all
g=1.2;
load 'CL2.mat'

%% Initialization

vidDevice = imaq.VideoDevice('winvideo', 1, 'YUY2_640x480', ... % Acquire input video stream
                    'ROI', [1 1 640 480], ...
                    'ReturnedColorSpace', 'rgb');
vidInfo = imaqhwinfo(vidDevice); % Acquire input video property
hblob = vision.BlobAnalysis('AreaOutputPort', false, ... % Set blob analysis handling
                                'CentroidOutputPort', true, ... 
                                'BoundingBoxOutputPort', true', ...
                                'MinimumBlobArea', 800, ...
                                'MaximumBlobArea', 3000, ...
                                'MaximumCount', 10);

htextins = vision.TextInserter('Text', 'Number of Red Object: %2d', ... % Set text for number of blobs
                                    'Location',  [7 2], ...
                                    'Color', [1 0 0], ... // red color
                                    'FontSize', 12);
htextinsCent = vision.TextInserter('Text', '+      X:%4d, Y:%4d', ... % set text for centroid
                                    'LocationSource', 'Input port', ...
                                    'Color', [1 1 0], ... // yellow color
                                    'FontSize', 14);
hVideoIn = vision.VideoPlayer('Name', 'Final Video', ... % Output video player
                                'Position', [100 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);
nFrame = 0; % Frame number initialization

x=480;
y=640;
z=3;
newIma=zeros(x,y,z);
%% Get the background information
disp('Press any button to take a snapshot of the background')
pause()
tic
fon=step(vidDevice);
fon = flip(fon,2); 
fon=single(fon);
% fon=abs((fon-.1).^g);
disp('Press any button to Start')
pause()
tic
%% Processing Loop
while(1)
    rgbFrame = step(vidDevice); % Acquire single frame
    rgbFrame = flip(rgbFrame,2); % obtain the mirror image for displaying
    Ima=single(rgbFrame)*255;

    im=Ima-fon;

    ir=im.^2>.03 ;
    mask(:,:,1)=ir(:,:,1)|ir(:,:,2)|ir(:,:,3);      %create a mask comparing the original background 
                                                    %value to the new one
    mask(:,:,2)=mask(:,:,1);
    mask(:,:,3)=mask(:,:,1);
    [a,b]=find(mask(:,:,1));
    iw=mask.*Ima;
    r=zeros(length(a),3);
    
    for i=1:length(a)
        r(i,:)=iw(a(i),b(i),:)*300;     %Create a vector with the ROI pixels
    end

    m=hist_3(r,5);          %get the 3D histogram using 5 batches
    n=reshape(m,1,125);     %Reshape the 5*5*5 histogram into a vector
    n=n/sum(n(:));          %normalize the histogram
    predict(Y,n)            %predict the class of the ROI object in front of the camera in real time
    step(hVideoIn, iw/255); % Output video stream
    nFrame = nFrame+1;
    clf
end
%% Clearing Memory
release(hVideoIn); % Release all memory and buffer used
release(vidDevice);
% clear all;
clc;