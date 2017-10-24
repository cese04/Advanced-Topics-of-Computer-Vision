clear all, close all, clc
%% Initialization

vidDevice = imaq.VideoDevice('winvideo', 1, 'MJPG_640x480', ... % Acquire input video stream
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
gTh=0.10;
x=480;
y=640;
z=3;
newIma=zeros(x,y,z);
hblob = vision.BlobAnalysis('AreaOutputPort', false, ... % Set blob analysis handling
                                'CentroidOutputPort', true, ... 
                                'BoundingBoxOutputPort', true', ...
                                'MinimumBlobArea', 80, ...
                                'MaximumBlobArea', 3000, ...
                                'MaximumCount', 10);
hshapeinsRedBox = vision.ShapeInserter('BorderColor', 'Custom', ... % Set Red box handling
                                        'CustomBorderColor', [1 0 0], ...
                                        'Fill', true, ...
                                        'FillColor', 'Custom', ...
                                        'CustomFillColor', [1 0 0], ...
                                        'Opacity', 0.4);
                            

%% Processing Loop
while(1)
    rgbFrame = step(vidDevice); % Acquire single frame
    rgbFrame = flip(rgbFrame,2); % obtain the mirror image for displaying
    
    diffFrame = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame));
    diffFrame = medfilt2(diffFrame, [3 3]);
    binFrame = im2bw(diffFrame, gTh);
    [centroid, bbox] = step(hblob, binFrame); % Get the centroids and bounding boxes of the blobs
    centroid = uint16(centroid);
    
    %%%Ley de cosenos
    
    if(3==size(centroid,1))
        cid2=double(centroid);
        l1=sqrt( (cid2(1,1)-cid2(2,1))^2 +(cid2(1,2)-cid2(2,2))^2 );
        l2=sqrt( (cid2(2,1)-cid2(3,1))^2 +(cid2(2,2)-cid2(3,2))^2 );
        l3=sqrt( (cid2(1,1)-cid2(3,1))^2 +(cid2(1,2)-cid2(3,2))^2 );
        L=[l1,l2,l3];
        L2=[max(L),median(L),min(L), ];
        
        Theta= (L2(1)^2-L2(2)^2-L2(3)^2)/(-2*L2(2)*L2(3));
        Theta=acos(Theta)*180/pi
        
    end
    
    
    vidIn = step(hshapeinsRedBox, rgbFrame, bbox);
    for object = 1:1:length(bbox(:,1)) % Write the corresponding centroids
        centX = centroid(object,1); centY = centroid(object,2);
        vidIn = step(htextinsCent, vidIn, [centX centY], [centX-6 centY-9]); 
    end
    step(hVideoIn, vidIn);
%     step(hVideoIn, single(binFrame)); % Output video stream
    
    nFrame = nFrame+1;
    clf
end
%% Clearing Memory
release(hVideoIn); % Release all memory and buffer used
release(vidDevice);
% clear all;
clc;