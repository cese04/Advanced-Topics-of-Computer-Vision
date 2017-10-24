%% Inicializacion
clc, clear all, close all

a=[0:0.2:10; zeros(1,51); zeros(1,51); ones(1,51)];
b=[zeros(1,51); 0:0.2:10; zeros(1,51); ones(1,51)];
c=[zeros(1,51); zeros(1,51); 0:0.2:10; ones(1,51)];


Ro=eye(4);

disp('Valor para theta')
th=input('th:');
disp('Valor de d')
d=input('d:');
disp('Valor de r')
r=input('r:');
disp('Valor de alfa')
al=input('al:');

a1 = a;
b1 = b;
c1 = c;

th=deg2rad(th);
al=deg2rad(al);

%% Primera rotación
j=0.01*sign(th);
for i=0:sign(th)*0.01:th

    Rz = [cos(j), -sin(j),0;...
        sin(j), cos(j),0;...
        0, 0, 1];
    Rz=[Rz,zeros(3,1)];
    Rz=[Rz;0,0,0,1];
    

    a1 = Rz * a1;
    b1 = Rz * b1;
    c1 = Rz * c1;


    plot3(a1(1 , :), a1(2 , :) ,a1(3 , :), 'r-', 'LineWidth', 4),hold on
    plot3(b1(1 , :), b1(2 , :) ,b1(3 , :), 'b-', 'LineWidth', 4)
    plot3(c1(1 , :), c1(2 , :) ,c1(3 , :), 'g-', 'LineWidth', 4), hold off
    axis([-10 20 -10 20 -10 20]);
    pause(0.001)
    
end
Rz = [cos(th), -sin(th),0;...
    sin(th), cos(th),0;...
    0, 0, 1];
    Rz=[Rz,zeros(3,1)];
    Rz=[Rz;0,0,0,1];

Ro = Rz * Ro;

%% Traslación en d

j=0.05*sign(d);
for i=0:sign(d)*0.05:d

    Hd=eye(3);
    Hd=[Hd;zeros(1,3)];
    Hd=[Hd,[0;0;j;1]];
    

    a1 = Hd * a1;
    b1 = Hd * b1;
    c1 = Hd * c1;


    plot3(a1(1 , :), a1(2 , :) ,a1(3 , :), 'r-', 'LineWidth', 4),hold on
    plot3(b1(1 , :), b1(2 , :) ,b1(3 , :), 'b-', 'LineWidth', 4)
    plot3(c1(1 , :), c1(2 , :) ,c1(3 , :), 'g-', 'LineWidth', 4), hold off
    axis([-10 20 -10 20 -10 20]);
    pause(0.001)
    
end
Hd=eye(3);
Hd=[Hd;zeros(1,3)];
Hd=[Hd,[0;0;d;1]];



%% Traslación en r

j=0.05*sign(r);
for i=0:sign(r)*0.05:r

    Hr=eye(3);
    Hr=[Hr;zeros(1,3)];
    Hr=[Hr,[j;0;0;1]];
    
    Hr1= Ro * Hr * Ro';

    a1 = Hr1 * a1;
    b1 = Hr1 * b1;
    c1 = Hr1 * c1;


    plot3(a1(1 , :), a1(2 , :) ,a1(3 , :), 'r-', 'LineWidth', 4),hold on
    plot3(b1(1 , :), b1(2 , :) ,b1(3 , :), 'b-', 'LineWidth', 4)
    plot3(c1(1 , :), c1(2 , :) ,c1(3 , :), 'g-', 'LineWidth', 4), hold off
    axis([-10 20 -10 20 -10 20]);
    pause(0.001)
    
end

%% Rotación en x

j=0.01*sign(th);
for i=0:sign(th)*0.01:th

    Rx = [1, 0, 0;...
    0, cos(j), -sin(j);...
    0, sin(j), cos(j)];

    Rx=[Rx,zeros(3,1)];
    Rx=[Rx;0,0,0,1];
    
    Rx1=Ro*Rx*Ro';

    a1 = Rx1 * a1;
    b1 = Rx1 * b1;
    c1 = Rx1 * c1;


    plot3(a1(1 , :), a1(2 , :) ,a1(3 , :), 'r-', 'LineWidth', 4),hold on
    plot3(b1(1 , :), b1(2 , :) ,b1(3 , :), 'b-', 'LineWidth', 4)
    plot3(c1(1 , :), c1(2 , :) ,c1(3 , :), 'g-', 'LineWidth', 4), hold off
    axis([-10 20 -10 20 -10 20]);
    pause(0.001)
    
end