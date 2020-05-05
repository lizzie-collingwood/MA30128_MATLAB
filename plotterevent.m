function [value,isterminal,direction] = plotterevent(t, Y, xmin, xmax, ymin, ymax)
   
    % Stop once we exceed a coordinate boundary
    z = Y(1) + 1i*Y(2);
    value = [real(z) - xmin; ...
             xmax - real(z); ...
             imag(z) - ymin; ...
             ymax - imag(z)];
    isterminal = [1; 1; 1; 1];
    direction = [];