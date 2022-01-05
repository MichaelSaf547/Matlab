height_Big = 30;
width_Big = 10;
axis_Height = 50;
axis_Width = 50;
height_Small = 10;
width_Small = 2;
x_Big = 20;
y_Big = 15;
x_Small = 24;
y_Small = 5;

%print the big rectangle with curvature with black color
rectangle('Position', [x_Big, y_Big, width_Big, height_Big], 'Curvature', 0.2, 'Facecolor', [0, 0, 0])
hold on 

%print the small rectangle with gray color 
rectangle('Position', [x_Small, y_Small, width_Small, height_Small], 'Facecolor', [105, 105, 105] / 255)
axis([0, axis_Height, 0, axis_Width])

%print the higher parallelogram with yellow color
P0_H = [24 11];
P1_H = [24 11.7];
P2_H = [26 13];
P3_H = [26 13.7];
C_H = [P0_H ;P1_H ; P3_H ; P2_H ; P0_H];
patch(C_H(:,1),C_H(:,2),'y')

%print the lower parallelogram with yellow color
P0_L = [24.0 7.0];
P1_L = [24.0 7.7];
P2_L = [26.0  9.0];
P3_L = [26.0 9.7];
C_L = [P0_L ;P1_L ; P3_L ; P2_L ; P0_L] ;
patch(C_L(:,1),C_L(:,2),'y')

th = 0:pi/50:2*pi;
r = 4;                    
x_All = axis_Width / 2;

y_G = 20;
xunit_G = r * cos(th) + x_All;
yunit_G = r * sin(th) + y_G;

y_Y = 30;
xunit_Y = r * cos(th) + x_All;
yunit_Y = r * sin(th) + y_Y;

y_R = 40;
xunit_R = r * cos(th) + x_All;
yunit_R = r * sin(th) + y_R;

n = 2;

while n > 0
    
    fill(xunit_G, yunit_G, [72, 72, 72] / 255)
    fill(xunit_Y, yunit_Y, [72, 72, 72] / 255)
    fill(xunit_R, yunit_R, 'r')
    pause(2)
    
    fill(xunit_G, yunit_G, [72, 72, 72] / 255)
    fill(xunit_Y, yunit_Y, 'y')
    fill(xunit_R, yunit_R, [72, 72, 72] / 255)
    pause(2)
    
    fill(xunit_G, yunit_G, 'g')
    fill(xunit_Y, yunit_Y, [72, 72, 72] / 255)
    fill(xunit_R, yunit_R, [72, 72, 72] / 255)
    pause(2)
    
    n = n - 1;
end
