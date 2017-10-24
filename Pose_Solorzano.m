clc, clear all, close all

load('model3d-cow.mat','fv'); 
V=fv.vertices; 
F=fv.faces; 

%plot original model in 3D
figure; subplot(1,2,1);
trisurf(F,V(:,1),V(:,2),V(:,3),'FaceColor',[1,0.1,0.1],...
    'EdgeColor',[0.0 0.0 0.0]);
light('Position',[-1.0,-1.0,100.0],'Style','infinite'); 
lighting phong; 
xlabel('x'); 
ylabel('y'); 
zlabel('z');
axis equal;


I=double(imread('mvg.bmp'));

% figure, imshow(uint8(I));
% [u, v, p] = impixel(I);   Used to get the picture coordinates the first
% time

%Real dimensions of the book
x0 = 17.3/2;
y0 = 24.6/2;
z0 = x0/2;

%Calibration matrix
 A = [800 ,0 ,320 ;0 ,800 ,240 ;0 ,0 ,1];

% 3D points
X1 = [-x0, y0];
X2 = [x0, y0];
X3 = [x0, -y0];
X4 = [-x0, -y0];
X = [X1; X2; X3; X4];
X(:,3) = 1;


%% 2D Points

v = [119, 171, 420, 287];
u = [328 ,562 ,379 ,53];
U = [u ;v ;zeros(1,4)];
%% Find the H matrix
M = [];
for i = 1:length(u)
    Mi = [X(i,:), 0,0,0, -X(i,:)*u(i);
        0,0,0, X(i,:), -X(i,:)*v(i)];
    M = [M; Mi];
end


[U1, S, V2] = svd(M);

% Pick the last column of v
H = reshape(V2(:,9),3,3)'
%% Find the rotation matrix
G = A\H;
%Normalization
l = sqrt(norm(G(:, 1))*norm(G(:, 2)));
G = G/l;
c = G(:,1) + G(:, 2);
p = cross(G(:, 1), G(:, 2));
d = cross(c, p);

R1 = ((c/norm(c)) + (d/norm(d))) / sqrt(2);
R2 = ((c/norm(c)) - (d/norm(d))) / sqrt(2);

Rt = zeros(3, 4);
Rt(:, 1) = R1;
Rt(:, 2) = R2;
Rt(:, 4) = G(:, 3);
Rt(:, 3) = cross(R1, R2);

Rt
% Camera
C = -Rt(1:3, 1:3)'*Rt(:, 4)
%% Projection matrix

Rcowtobook = [0 0 1; 1 0 0; 0 1 0] * inv([-1 0 0; 0 1 0; 0 0 -1]);
V = Rcowtobook*V';
V = V';

P = A * Rt;
V(:,4) = 1;
V1 = P * V';

V1(1, :) = V1(1, :) ./ V1(3, :);
V1(2, :) = V1(2, :) ./ V1(3, :);

P
%% plot projected model in 2D
subplot(1, 2, 2); imshow(uint8(I)), hold on;

Color=repmat([1,0.1,0.1],length(V1),1);
fv2d.vertices = [V1(1, :)', V1(2,: )'];
fv2d.faces = F;
fv2d.facevertexcdata=Color;
% p = patch(fv,'FaceAlpha',1,'EdgeAlpha',0.25);
p = patch(fv2d, 'FaceAlpha', 1, 'EdgeAlpha', 0.25), hold off;
shading faceted;

%% Plot the axes and a figure
figure, imshow(uint8(I)), hold on;
a=[0:0.2:10; zeros(1,51); zeros(1,51); ones(1,51)];
b=[zeros(1,51); 0:0.2:10; zeros(1,51); ones(1,51)];
l=[zeros(1,51); zeros(1,51); 0:0.2:10; ones(1,51)];
a1= proj(a,P);
b1= proj(b,P);
l1= proj(l,P);

plot(a1(1,:),a1(2,:),'r-','LineWidth',4)
plot(b1(1,:),b1(2,:),'b-','LineWidth',4)
plot(l1(1,:),l1(2,:),'g-','LineWidth',4)

vert = 3*[-1 -1 0;1 -1 0;1 1 0;-1 1 0;-1 -1 2;1 -1 2;1 1 2;-1 1 2];
fac = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];

vert(:, 4) = 1;
vert1 = proj(vert', P);

cu.vertices = [vert1(1,:)', vert1(2,:)'];
cu.faces = fac;
Color1 = repmat([0.1,0.1,1],length(vert1),1);
cu.facevertexcdata = Color1;
patch(cu, 'FaceAlpha', .24, 'EdgeAlpha', 1)
shading faceted;
