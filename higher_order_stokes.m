
% PLOT THE REPRESENTATIVE HIGHER-ORDER INTEGRAL PATH PLOT OR STOKES LINES
% (INC. HIGHER ORDER LINE) IN THE COMPLEX PLANE

clear
close all

% create figure and set size
j = figure(); hold all;
set(gcf, 'Position', [15, 328, 700, 600]);

% parameter attributes
n = 0;
theta = n*pi/6;
r_Xp = 0.3;
a0 = 0.61452;
Xp = a0 + r_Xp*exp(1i*theta);

% draw on the Stokes lines
l1 = @(a) -tan(pi/3)*(a-a0);
l2 = @(a)  tan(pi/3)*(a-a0);
l3 = @(a)  tan(pi/3)*(a+a0);
l4 = @(a) -tan(pi/3)*(a+a0);

% axes for representative circle
axmin = 0.2; axmax = 1;
aymin = -0.38; aymax = 0.38;
% % axes for view of all Stokes lines
% axmin = -1.15; axmax = 1.63;
% aymin = -1.26; aymax = 1.3;

% red colour for complete view of Stokes' lines
xxx = [0.8 0 0.1];

% % plot all the stokes lines
% plot([axmin, axmax], l1([axmin, axmax]), '-', 'Color', xxx, 'LineWidth', 2);
% plot([axmin, axmax], l2([axmin, axmax]), '-', 'Color', xxx, 'LineWidth', 2);
% plot([axmin, axmax], l3([axmin, axmax]), '-', 'Color', xxx, 'LineWidth', 2);
% plot([axmin, axmax], l4([axmin, axmax]), '-', 'Color', xxx, 'LineWidth', 2);
% plot([axmin, axmax], ([0, 0]), 'Color', xxx, 'LineWidth', 2);

% % for the colours plot:
plot([axmin, axmax], l1([axmin, axmax]), '-', 'Color', [0.6 0.3 0.9], 'LineWidth', 2.3);
plot([axmin, axmax], l2([axmin, axmax]), '-', 'Color', [1 0.6 0], 'LineWidth', 2.3);
plot([axmin, axmax], ([0, 0]), 'Color', [0 0.7 0], 'LineWidth', 2.3);

% set red and yellow ribbons
red = 2/3+linspace(0, 2, 100)/2;
yellow = -2/3+linspace(0, 2, 100)*1/3;
% set width of ribbons
rib_width = 5;

% the black dotted circle
% plot(a0 + 1*r_Xp*exp(pi*1i*linspace(0, 2, 100)), ':', 'Color', 'k', 'LineWidth', 1.5);

% plot the ribbons
plot(a0 + 0.9*r_Xp*exp(pi*1i*linspace(0, 2, 100)), 'Color', [0 0.4470 0.9], 'LineWidth', rib_width);
plot(a0 + 0.8*r_Xp*exp(pi*1i*red), 'Color', [0.8500 0 0], 'LineWidth', rib_width);
plot(a0 + 0.7*r_Xp*exp(pi*1i*yellow), 'Color', [0.9290 0.77  0.1250], 'LineWidth', rib_width);
plot(real(Xp), imag(Xp), 'k', 'MarkerSize', 10);

% plot formatting
xlim([axmin,axmax])
ylim([aymin,aymax])
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

% higher-order Stokes line
[hs1, hs2, hs3] = HOSL;
% colour for HOSL
yyy = [1 0.5 0];

% % plot HOSL lines
% plot(hs1(:,1), hs1(:,2)*tan(pi/3)/(0.384/0.614), '-', 'Color', yyy, 'LineWidth', 1.3);
% plot(hs2(:,1), hs2(:,2)*tan(pi/3)/(0.384/0.614), '-', 'Color', yyy, 'LineWidth', 1.3);
% plot(hs3(:,1), hs3(:,2)*tan(pi/3)/(0.384/0.614), '-', 'Color', yyy, 'LineWidth', 1.3);
% % HOSL plot formatting
% xlim([axmin, axmax]);
% ylim([aymin, aymax]);

hold off

% save as pdf
ax = gca;
ax.FontSize = 12; 
set(j,'Units','Inches');
pos = get(j,'Position');
set(j,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [8,7.5])
print(j,'hosl_3','-dpdf','-r0')





