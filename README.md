# MA30128_MATLAB
Matlab codes for MA30128 project - perturbation theory &amp; Stokes' phenomena

airyplots.m
  - produces the 2d Airy integral solution plot
  - plots the exponent of the Airy integrand + steepest descent contour as surface and as contour map
  - plots the Airy integral solution for complex x
  
approximations.m (function)
  - evaluates PDE solution approximation, semi approximation & exact solution
  
caustic_diagrams.m
  - plots the creation of the primary caustic when full or half family of rays enters a spherical droplet
  - refractive indices of droplet and exterior may be changed, but droplet must be more dense than exterior
  
contourdata.m (function)
  - function to extract contour data from a contour matrix
  
higher_order_stokes.m
  - plots Stokes lines (inc. higher order) for Pearcey problem
  - plots coloured representative diagram describing the changing integral path for different values of parameter
  
HOSL.m
  - the data to draw HOSL line
  
pde_solution_plotting.m
  - plots exact solution and approximations to PDE problem (Langman Chap 3) over a real x interval for fixed epsilon and time
  - also makes heatmap style plot in real (x,t)-plane for fixed epsilon
  
pearceypathode.m (function)
  - finds contours for Pearcey script
  
plotterevent.m (function)
  - creates options structure for ODE solver
  
steepest_descent_contours.m
  - currently set to Pearcey problem
  - plots steepest descent contours through each saddle on a contour map showing real value of exponent of integrand



  
  
  
