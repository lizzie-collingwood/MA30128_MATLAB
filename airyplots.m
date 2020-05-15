
% CREATE THE AIRY PLOTS AND SURFACES

clear
close all

% create meshgrid
max = 4;
min = -max;
steps = (max - min)/100;
a = min:steps:max;
b = a;
[A,B] = meshgrid(a,b);
Z = A+1i.*B;

% plot 2d AIRY function solutions
x = -10:0.1:10;
ai = airy(x);
bi = airy(2,x);
j = figure;
plot(x,ai,'-r',x,bi,'-k', 'LineWidth', 1)
axis([-9.5 9.5 -1.4 1.8]);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.Box = 'off';
ax.XTick = ([-8,-6,-4,-2,0,2,4,6,8]);

% % save as a pdf
% set(gcf, 'Position',  [50, 50, 550, 450])
% ax = gca;
% ax.FontSize = 12; 
% set(j,'Units','Inches');
% pos = get(j,'Position');
% set(j,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [6,5])
% print(j,'airy2d','-dpdf','-r0')


% STEEPEST DESCENT
% set theta:
theta = 0;

% set phi function
f_func = @(Z) Z.*exp(1i*theta)-Z.^3/3;
f = f_func(Z);

% define saddle points
w_1 = exp(1i*theta/2);
w_2 = -exp(1i*theta/2);
f_w_1 = f_func(w_1);
f_w_2 = f_func(w_2);

% get real, imag, abs data
temp = airy(Z);
re = real(temp);
im = imag(temp);
v = real(airy(w_1));
v2 = real(airy(w_2));

%%
% plot REAL AIRY 3D surface
h = figure;
surfc(a,b,re,'FaceAlpha',0.45)
hold on
colormap(winter)
axis([min max min max -1 1])
caxis([min max])

plot3(real(a),imag(a),airy(a),'r','LineWidth',2)

% save as high res png
set(gcf, 'Position',  [50, 50, 550, 450])
ax = gca;
ax.FontName = 'Times';
ax.FontSize = 12; 
xlabel('$\Re(x)$','Interpreter','Latex')
ylabel('$\Im(x)$','Interpreter','Latex')
zlabel('$\Re\big(\mathrm{Ai}(x)\big)$','Interpreter','Latex')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [5,4])
print(h,'airy.png','-dpng','-r300'); 
hold off


% % plot IMAGINARY PART
% figure
% surfc(a,b,im,'FaceAlpha',0.55)
% colormap(bone)
% axis([min max min max min max])
% caxis ([min max])
% xlabel('Real(z)')
% ylabel('Imag(z)')


%%
% 2D CONTOUR PLOTS with imaginary contour through saddles

% figure()
% p = pcolor(A,B,real(f-f_w_2));

% % plot features
% xlabel('Real(z)')
% ylabel('Imag(z)')
% set(p, 'EdgeColor', 'none', 'FaceColor', 'interp');
% colorbar
% hold on
% [C1, h] = contour(A,B, imag(f-f_w_1), [0, 0], 'b', 'LineWidth', 1);
% [C2, h] = contour(A,B, imag(f-f_w_2), [0, 0], 'r', 'LineWidth', 1);

% % add the locations of the saddle points
% plot(real(w_1),imag(w_1),'ko', 'MarkerSize',5, 'MarkerFaceColor', 'b')
% plot(real(w_2),imag(w_2),'ko', 'MarkerSize',5, 'MarkerFaceColor', 'r')
% hold off

%%

% AIRY 2D CONTOUR PLOT WITH INTEGRAL PATH

% create meshgrid
a = min:steps:max;
b = a;
[A,B] = meshgrid(a,b);
Z = A+1i.*B;

close all

% contour plot
h = figure();
set(gcf, 'Position',  [400, 400, 400, 330])
contourf(A,B,real(f),30,'LineWidth',0.2);
hold on

% plot formatting
xticks([])
yticks([])
caxis([-30,30])
colormap(winter)
ylim([min,max])
xlabel('$\Re(z)$','Interpreter','Latex')
ylabel('$\Im(z)$','Interpreter','Latex')
c.Ticks = ([]);

% add the saddle points
plot(real(w_1),imag(w_1),'ko', 'MarkerSize',7, 'MarkerFaceColor', 'w','MarkerEdgeColor','w')
plot(real(w_2),imag(w_2),'ko', 'MarkerSize',7, 'MarkerFaceColor', 'w','MarkerEdgeColor','w')

% plot the path of integration
fplot(@(x) sqrt(3*((x).^2-1)),[min,0], 'w', 'LineWidth',2,'ShowPoles','off')
fplot(@(x) -sqrt(3*((x).^2-1)),[min,0], 'w', 'LineWidth',2,'ShowPoles','off')

% save as pdf
set(gcf, 'Position',  [50, 50, 450, 400])
ax = gca;
ax.FontSize = 12; 
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [6.3,5.4])
print(h,'airy_fplot','-dpdf','-r0')


hold off
%%

% PLOT AIRY EXPONENT WITH INTEGRAL CONTOUR 
close all
disp('run')

% plot phi(w)
h = figure;
surfc(a,b,real(f),'FaceAlpha',0.75)

% format plot
colormap(winter)
caxis([min max])
axis([min max min max min max])

hold on

% mark on plot the saddle points
plot3(real(w_1),imag(w_1),real(f_w_1),'ko', 'MarkerSize',7, 'MarkerFaceColor', 'w')
plot3(real(w_2),imag(w_2),real(f_w_2),'ko', 'MarkerSize',7, 'MarkerFaceColor', 'w')

% PLOTTING CONTOURS
inputdata = imag(f-f_w_2);
inputdata(real(f-f_w_2)>0) = nan;
inputdata(real(A)>0) = nan;
C1 = contourc(a,b,inputdata,[0,0]);
S1 = contourdata(C1);

for j = 1:length(S1)
    xx = S1(j).x;
    yy = S1(j).y;
    zz = xx + 1i*yy;
    ff = f_func(zz);
    plot3(real(zz), imag(zz), real(ff), 'w', 'LineWidth', 2);
end

% save as high res png
set(gcf, 'Position',  [50, 50, 550, 450])
ax = gca;
ax.FontSize = 12; 
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [5,4])
print(h,'airyexponent.png','-dpng','-r300');

hold off



