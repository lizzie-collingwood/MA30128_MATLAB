
% CREATES DIAGRAM SHOWING HALF OR FULL FAMILY OF RAYS PASSING THROUGH A
% SPHERICAL DROPLET FOR ANY PAIR OF REFRACTIVE INDICES

clear
close all

% number of rays (must be atleast 2)
n = 100;

% show colour gradient?
colourgradient = 0;
rainbows = 0;

% show both sides?
both = 0;

% show virtual caustic?
vc = 0;

% refractive indices (inside droplet must be greater than outside)
insidedroplet = 1.333;      % water:1.333 diamond:2.417 ice:1.31
outsidedroplet = 1.000277;         % air:1.000277
ratio = outsidedroplet/insidedroplet;

% radius and centre of circle
radius = 1;
scale = 1.3;
sizeofoutput = 20;
cx = 10;
cy = 10;
circcolour = [0 0 0];

% set axes
xmax = cx+radius*scale;
xmin = cx-radius*scale;
ymax = cy+radius*scale;
ymin = cy-radius*scale;
if both==0
    gaps = radius/(n-1);
    y = cy:gaps:(cy+radius);
else
    n = 2*n;
    gaps = 2*radius/(n-1);
    y = (cy-radius):gaps:(cy+radius);
end
h = figure(); hold all;

% coffee cup caustic
if insidedroplet==outsidedroplet
    coffee = 1;
else
    coffee = 0;
end

% gradient function
circgrad = @(x) (x-cx)/sqrt(radius^2-(x-cx)^2);

% define ray matrices
for j=1:n
    
%     colour of rays
    if colourgradient == 1
        s = 1-j/n;
        raycolour = [0.3*s, s, 0.8];
    else
        raycolour = 'k';
    end
    
%     if through upper semisphere / semihemishpere
    if abs(y(j)-cy)>0
        unit = (y(j)-cy)/abs((y(j)-cy));
    else
        unit = 1;
    end
    
%     incident rays
    incidentrays(j,1) = xmin;
    incidentrays(j,2) = y(j);
%     plot(incidentrays(j,1),incidentrays(j,2),'r*')


%     incident rays meet surface
    x = -sqrt(radius^2-(y(j)-cy)^2)+cx;
    dropsurface(j,1) = x;
    dropsurface(j,2) = y(j);
%     plot(dropsurface(j,1),dropsurface(j,2),'r*')


%     refracted ray
    theta1 = atan(abs(circgrad(x)));
    theta2 = asin(ratio*sin(pi/2 - theta1));
    lengthofray2 = 2*radius*cos(theta2);
    refractedrays(j,1) = dropsurface(j,1)+lengthofray2*sin(theta1+theta2);
    refractedrays(j,2) = dropsurface(j,2)-unit*abs(lengthofray2*cos(theta1+theta2));
%     plot(refractedrays(j,1),refractedrays(j,2),'b*')


%     reflected ray
    theta3 = atan(1/circgrad(refractedrays(j,1)));
    if unit*(refractedrays(j,2)-cy)>0
        theta4 = pi/2-theta2-theta3;
    else
        theta4 = pi/2-theta2+theta3;
    end
    reflectedrays(j,1) = refractedrays(j,1)-lengthofray2*sin(theta4);
    if theta4<pi/2
        unit2 = 1;
    else
        unit2 = -1;
    end
    reflectedrays(j,2) = refractedrays(j,2)-unit*unit2*abs(lengthofray2*cos(theta4));
%     plot(reflectedrays(j,1),reflectedrays(j,2),'g*')


%     output rays
    theta1 = atan((circgrad(x)));
    theta5 = unit*atan(circgrad(reflectedrays(j,1)));
    theta6 = (theta5-unit*theta1);
    if (reflectedrays(j,2)-cy)*unit>0 && (reflectedrays(j,2))<(cy+radius) && (reflectedrays(j,2))>(cy-radius) && coffee == 1
        rrr = -1;
        ppp = unit;
        theta6 = abs(theta5)-abs(theta1);
    else rrr = 1;
        ppp = 1;
    end
    
    outputrays(j,1) = reflectedrays(j,1)-rrr*sizeofoutput*cos(theta6);
    outputrays(j,2) = reflectedrays(j,2)-ppp*sizeofoutput*sin(theta6);
%     plot(outputrays(j,1),outputrays(j,2),'m*')

    if rainbows == 1
        x1(j,1) = reflectedrays(j,1)-10*cos(theta6*1.03);
        x1(j,2) = reflectedrays(j,2)-10*sin(theta6*1.03);
        x2(j,1) = reflectedrays(j,1)-10*cos(theta6*1.02);
        x2(j,2) = reflectedrays(j,2)-10*sin(theta6*1.02);
        x3(j,1) = reflectedrays(j,1)-10*cos(theta6*1.01);
        x3(j,2) = reflectedrays(j,2)-10*sin(theta6*1.01);
        x4(j,1) = reflectedrays(j,1)-10*cos(theta6);
        x4(j,2) = reflectedrays(j,2)-10*sin(theta6);
        x5(j,1) = reflectedrays(j,1)-10*cos(theta6*0.99);
        x5(j,2) = reflectedrays(j,2)-10*sin(theta6*0.99);
        x6(j,1) = reflectedrays(j,1)-10*cos(theta6*0.98);
        x6(j,2) = reflectedrays(j,2)-10*sin(theta6*0.98);
        x7(j,1) = reflectedrays(j,1)-10*cos(theta6*0.97);
        x7(j,2) = reflectedrays(j,2)-10*sin(theta6*0.97);
    end

%     virtual caustic
    if vc == 1
        deltax = xmax - reflectedrays(j,1);
        virtualcaustic(j,1) = xmax;
        virtualcaustic(j,2) = reflectedrays(j,2)+deltax*(reflectedrays(j,2)-outputrays(j,2))/(reflectedrays(j,1)-outputrays(j,1));
%         plot(virtualcaustic(j,1),virtualcaustic(j,2),'r*')
        l5 = plot([reflectedrays(j,1) virtualcaustic(j,1)],[reflectedrays(j,2) virtualcaustic(j,2)],':');
    end
%     plot connecting lines
    l2 = plot([dropsurface(j,1) refractedrays(j,1)], [dropsurface(j,2) refractedrays(j,2)]);
    l3 = plot([refractedrays(j,1) reflectedrays(j,1)], [refractedrays(j,2) reflectedrays(j,2)]);
    
    if rainbows == 1
        la = plot([reflectedrays(j,1) x1(j,1)], [reflectedrays(j,2) x1(j,2)]);
        lb = plot([reflectedrays(j,1) x2(j,1)], [reflectedrays(j,2) x2(j,2)]);
        lc = plot([reflectedrays(j,1) x3(j,1)], [reflectedrays(j,2) x3(j,2)]);
        ld = plot([reflectedrays(j,1) x4(j,1)], [reflectedrays(j,2) x4(j,2)]);
        le = plot([reflectedrays(j,1) x5(j,1)], [reflectedrays(j,2) x5(j,2)]);
        lf = plot([reflectedrays(j,1) x6(j,1)], [reflectedrays(j,2) x6(j,2)]);
        lg = plot([reflectedrays(j,1) x7(j,1)], [reflectedrays(j,2) x7(j,2)]);
        la.Color = 'r';
        lb.Color = [1,0.5,0];
        lc.Color = 'y';
        ld.Color = 'g';
        le.Color = 'b';
        lf.Color = [0.5 0 0.5];
        lg.Color = [0.8 0 0.6];
        l2.LineWidth = 0.001;
        l3.LineWidth = 0.001;
    else
        l1 = plot([incidentrays(j,1) dropsurface(j,1)], [incidentrays(j,2) dropsurface(j,2)]);
        l4 = plot([reflectedrays(j,1) outputrays(j,1)], [reflectedrays(j,2) outputrays(j,2)]);
    end
    
    l1.Color = raycolour;
    l2.Color = raycolour;
    l3.Color = raycolour;
    l4.Color = raycolour;
    l5.Color = raycolour;
end


% plot circle 
th = 0:pi/50:2*pi;
xunit = radius*cos(th)+cx;
yunit = radius*sin(th)+cy;
plot(xunit, yunit, 'Color', circcolour);
xlim([xmin,xmax])
ylim([ymin,ymax])


% centre axes
ax = gca;
ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
ax.Box = 'off';
ax.XTick = [];
ax.YTick = [];

% % SAVE
set(gcf, 'Position',  [50, 50, 560, 500])
ax = gca;
% ax.FontSize = 12;
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [5.6, 5.4])%[pos(3), pos(4)])
print(h,'CAUSTIC','-dpdf','-r0')


