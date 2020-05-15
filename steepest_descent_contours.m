
% PLOTTING CONTOUR GRAPHS FOR REAL PART OF INTEGRAND EXPONENT WITH CONTOURS
% OF CONSTANT PHASE THROUGH SADDLES FOR DIFFERENT VALUES OF A PARAMETER
% -- CURRENTLY SET TO PEARCEY PDE PROBLEM

disp('run')
clear
close all

AIRY = 0;

% parameter attributes (a=a0+r_Xp*exp(i*theta))
n = 11.5;
theta = n*pi/6;
r_Xp = 0.3;

if AIRY==1
    a0 = 0;
    Xp = a0 + r_Xp*exp(1i*theta);
%     exponent of integrand AIRY
    F = @(z) -z.^3/3+Xp*z;
    Fp = @(z) -z.^2+Xp;
    Hfunc = @(Z) real(Fp(Z));
    polyfunc = [-1 0 Xp];
    polF0 = [-1, 0, Xp];
%     define number of saddles
    num_saddles = 2;
    tspan = [-10, 10];
else
    a0 = 0.61452;
    u0 = -2-2i;
    Xp = a0 + r_Xp*exp(1i*theta);
%     exponent of integrand
    F = @(z) -1i*(z.^4/4 + z.^2/2 + Xp*z);
    Fp = @(z) -1i*(z.^3 + z + Xp);
    Hfunc = @(Z) real(Fp(Z));
    polyfunc = [1, 0, 1, Xp];
    polF0 = [-1i*1/4, 0, -1i*1/2, -1i*Xp, -u0];
%     define number of saddles
    num_saddles = 3;
    tspan = [0, -10];
end

% define number of branches
num_branches = num_saddles + 1;

% Global max for drawings
xmin = -2.5; xmax = 2.5;    N_x = 100;
ymin = -2.5; ymax = 2.5;    N_y = 200;
uxmin = -1.5; uxmax = 1.5;  N_ux = 50;
uymin = -1; uymax = 1;  N_uy = 50;

% define colours for plots
mycol = 0.5*[1, 1, 1];
color_branch = ['b', 'r', 'm', 'g'];
color_saddle = [0    0.4470    0.9
                0.8500    0    0
                0.9290 0.6940  0.1250 ];
if AIRY==1
    color_saddle = [0.7 0.7 1
                    1 0.4 0.5];
end

% find locations of the saddles
polFp = polyfunc;
ztp = roots(polFp);
% Rearrange order
[tmp1, tmp2] = sort(imag(ztp));
ztp = ztp(tmp2);
utp = F(ztp);
if num_saddles ~= length(ztp)
    error('Number of saddles does not match');
end

% Solve for z0 in u0 = F(z0)
z0vals = roots(polF0);
% Sort by the imaginary part
[tmp1, tmp2] = sort(imag(z0vals));
z0vals = z0vals(tmp2);

% create plot
h = figure(1); hold all;

% Basic underlying gridding
x_grid = linspace(xmin, xmax, N_x);
y_grid = linspace(ymin, ymax, N_y);
[Xm, Ym] = meshgrid(x_grid, y_grid);
Z_grid = Xm + 1i*Ym;
U_grid = F(Z_grid);

% isotropic lines on plot of real exponent values
if AIRY==1
    contourf(x_grid,y_grid, real(U_grid - F(ztp(1))), 30, 'LineWidth', 0.1);
    colormap(winter)
    caxis([-10,7])
else
    C = contour(x_grid,y_grid, real(U_grid - F(ztp(1))), 200, ':', 'LineWidth', 1.2);
    colormap(jet)
    caxis([-10,10])
end

% formatting
xticks([])
yticks([])

% compute the contours through the saddles
fwd = @(t,Y) pearceypathode(t, Y, Xp, AIRY);
myevent = @(t,Y) plotterevent(t, Y, xmin, xmax, ymin, ymax);
options = odeset('Events', myevent);

% Shoot from turning point
ZTPpath = [];
move_away_ztp = 1e-2;
for j = 1:num_saddles
    z0 = ztp(j) + move_away_ztp*1i;
    Yinit = [real(z0), imag(z0), F(z0)];
    [tt, YY1] = ode45(fwd, tspan, Yinit, options);

    z0 = ztp(j) - move_away_ztp*1i;
    Yinit = [real(z0), imag(z0), F(z0)];
    [tt, YY2] = ode45(fwd, tspan, Yinit, options);
    ZTPpath_forwards = YY1(:,1) + 1i*YY1(:,2);
    ZTPpath_backwards = YY2(:,1) + 1i*YY2(:,2);
    ZTPpath{j} = [ZTPpath_backwards(end:-1:1); ZTPpath_forwards];
end

% plot the contours
for j = 1:num_saddles
    tmp = ZTPpath{j};
    plot(tmp, '-', 'LineWidth', 2, 'Color', color_saddle(j,:));
    plot(tmp(1), '*', 'Color', color_saddle(j,:));
end

% plot the saddle points
for j = 1:num_saddles
        figure(1)
        plot(real(ztp(j)), imag(ztp(j)), 'o', 'MarkerSize', 15, 'MarkerFaceColor', 'w', 'LineWidth',2, 'Color', color_saddle(j,:));
end

% save as high res png
set(gcf, 'Position',  [50, 50, 650, 580])
ax = gca;
ax.FontSize = 12; 
set(h,'Units','Inches');
pos = get(h,'Position');
% set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [0.8*6.5,0.8*5.8])
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [6, 6])
print(h,sprintf('trippy%d.png',n),'-dpng','-r300'); 



%% PLOT 3D PEARCEY EXPONENT

disp('run')
close all

% create meshgrid
max = 2;
min = -max;
steps = (max - min)/100;
a = min:steps:max;
b = a;
[A,B] = meshgrid(a,b);
Z = A+1i.*B;

% PLOT SURFACE
h = figure(1);
surfc(a,b,real(-F(Z)),'FaceAlpha',0.55)%, 'EdgeColor','None')
hold on
colormap(winter)

% define and label axes
axis([min max min max min max])
caxis([min max])
xlabel('$\Re(z)$','Interpreter','Latex')
ylabel('$\Im(z)$','Interpreter','Latex')

% % add the saddle points
% for j = 1:num_saddles
%     tmp = ZTPpath{j};
%     plot3(real(tmp), imag(tmp), real(-F(tmp)), '-', 'LineWidth', 2, 'Color', color_saddle(j,:));
% end

% plot the saddle points
for j = 1:num_saddles
        figure(1)
        plot3(real(ztp(j)), imag(ztp(j)), real(-F(ztp(j))), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'w', 'LineWidth',1, 'Color', 'w');%color_saddle(j,:)
end

% save as high res png
set(gcf, 'Position',  [50, 50, 550, 490])
ax = gca;
ax.FontName = 'Times';
ax.FontSize = 12; 
view([220,100,120])
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [5,5])
print(h,sprintf('pearcey3d_%d.png',n),'-dpng','-r300'); 
hold off
