
% illustrates 2d solution, approximation, and approximation with pole
% contribution removed for the PDE and also a heatmap for the value of the
% integral at each point in a real (x,t)-plane (IC removed)

% =====================================================================
% =====================================================================
% in 'approximations.m' uncomment the exact integral calculations when
% wanting to run for exact solution - takes too long otherwise
% =====================================================================
% =====================================================================

clear
close all

% SET VALUES (col = heatmap colour)
tt = 30; %only applies to 2d graphs
ep = 0.125; %0.125 for the heatmap :: 0.5 for the 2d solutions
col = hot;

% WHICH DIAGRAM IS REQUIRED
exact = 0;
fullapprox = 1;
semiapprox = 0;

% 2D solution graph or heat map thing?
twoD = 1;
threeD = 0;

% 2d graphs
if twoD==1
    
%     set axes
    n = 1000;
    xmin = -50;
    xmax = 120;
    xgaps = (xmax-xmin)/(n-1);
    x = xmin:xgaps:xmax;
    
%     create empty matrices
    I = 0*length(x);
    J = 0*length(x);
    K = 0*length(x);
    
%     fill matrices with evaluations of the integral for each x
    for p=1:length(x)
        [PHI,X,exI] = approximations(x(p),tt,ep);
        I(p) = PHI;
        J(p) = X;
        K(p) = exI;
    end
    
%     PLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOT
%     PLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOT
%     PLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOT

    h = figure; hold all
    if fullapprox == 1
%     plot approximation
        c = plot(x,I);
    end

    if semiapprox == 1
%     plot approximation without subdominant term
       d = plot(x,J);
    end

    if exact == 1
%     plot exact solution
        e = plot(x,K);
    end

%     plot settings
    c.LineWidth = 1;
    c.Color = [0.2 0.5 0.6];
    d.LineWidth = 1;
    d.Color = [0.2 0.5 0.6];
    e.LineWidth = 1;
    e.Color = [0.2 0.5 0.6];
    ylim([-2,3.65])
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    
    % % SAVE
    set(gcf, 'Position',  [50, 50, 560, 500])
    ax = gca;
    % ax.FontSize = 12;
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [5.6, 5.3])%[pos(3), pos(4)])
    print(h,'FINALexact','-dpdf','-r0')  
end  

% HEATMAPS
if threeD==1
    
%     set axes
    n = 1000;
    xmin = -20;
    xmax = 20;
    tmin = 0;
    tmax = 20;
    xgaps = (xmax-xmin)/(n-1);
    tgaps = (tmax-tmin)/(n-1);
    x = xmin:xgaps:xmax;
    t = tmin:tgaps:tmax;
    
%     create empty matrices
    I = [];
    J = [];
    K = [];
    
%     evaluate for all values of (x,t) in grid
    for p=1:n
        for q=1:n
            [PHI,X,exI] = approximations(x(p),t(q),ep);
            I(q,p) = PHI-atan(x(p));
            J(q,p) = X-atan(x(p));
            K(q,p) = exI-atan(x(p));
        end
        disp(p/n)
    end
    
%     PLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOT
%     PLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOT
%     PLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOTPLOT

    if fullapprox == 1
%     plot for all contributions
        h = figure; hold on
        surf(x,t,-I,'EdgeColor','none')
        colormap(hot)
        hold off
    end
    
    if semiapprox == 1
%     same thing for no subdominant
        h = figure; hold on
        surf(x,t,-J,'EdgeColor','none')
        colormap(col)
        hold off
    end

    if exact == 1
%     EXACT SOLUTION
        h = figure; hold on
        surf(x,t,-K,'EdgeColor','none')
        colormap(col)
        hold off
    end


    % % SAVE
    set(gcf, 'Position',  [50, 50, 560, 500])
    ax = gca;
    % ax.FontSize = 12;
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [5.6, 5])
    print(h,'SURF_approx.png','-dpng','-r300'); 
    

end

