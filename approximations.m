
function [PHI,X,exI] = approximations(s,t,ep)

% COMPUTE APPROXIMATION FOR ANY VALUE OF S AND T
% ALSO COMPUTES EXACT VALUE



%     FUNCTIONS
% time dependent functions
f1 = @(s_, t_, p) 1i*p*s_ + p + 1i*p.*(1 - p.^2)*t_;
f2 = @(s_, t_, p) -1i*p*s_ + p - 1i*p.*(1 - p.^2)*t_;
% time independent functions
f3 = @(s_, t_, p) p.*(1+1i*s_);
f4 = @(s_, t_, p) p.*(1-1i*s_);


% SADDLE CONTRIBUTIONS - only from time dependent integrals
saddleT1 = exp(+3*1i*pi/4-1i*sqrt(4*(s+t-1i)^3/(27*t))/ep)*sqrt(pi*ep)*(3*t*(s+t-1i))^(1/4)/(2*(2*t-s+1i));
saddleT2 = exp(-3*1i*pi/4+1i*sqrt(4*(s+t+1i)^3/(27*t))/ep)*sqrt(pi*ep)*(3*t*(s+t+1i))^(1/4)/(2*(2*t-s-1i));
SAD = saddleT1 + saddleT2;


% POLE CONTRIBUTIONS - from every integral
poleT1 = -pi*exp(-(1+1i*s)/ep)/2;
poleT2 = -pi*exp(-(1-1i*s)/ep)/2;
poleS1 = -pi*exp(-(1+1i*s)/ep)/2;
poleS2 = -pi*exp(-(1-1i*s)/ep)/2;
polT = poleT1 + poleT2;
polS = poleS1 + poleS2;
POL = polT + polS;
POL = -pi*exp(-1/ep)*cos(s/ep);


% END POINT CONTRIBUTIONS - from every integral + ICs
endT1 = 1i*ep^2/(2*(s+t-1i)^2);
endT2 = -1i*ep^2/(2*(s+t+1i)^2);
endS1 = 1i*ep^2/(2*(1+1i*s)^2);
endS2 = -1i*ep^2/(2*(1-1i*s)^2);
endS = 4*s*ep^2/(2*(1+s^2)^2);
IC = atan(s);
END = endT1 + endT2 + endS + IC;


% COMPUTE APPROXIMATION
if  real(t)<1/sqrt(3)-real(s)
    PHI = END;
    X = PHI;
elseif real(s)<0
    PHI = END + SAD;
    X = PHI;
elseif real(t)>(1/sqrt(3)+(2-1/sqrt(3))*real(s)/2.97)
    PHI = END + SAD + POL;
    X = END + SAD;
else
    PHI = END + SAD;
    X = PHI;
end

% EXACT INTEGRAL
% %     DEFINE INTEGRANDS
% integrand1 = @(p) -1i*p.*exp(-f1(s,t,p)/ep)./(2*(1 - p.^2));
% integrand2 = @(p) 1i*p.*exp(-f2(s,t,p)/ep)./(2*(1 - p.^2));
% integrand3 = @(p) 1i*p.*exp(-f3(s,t,p)/ep)./(2*(1 - p.^2));
% integrand4 = @(p) -1i*p.*exp(-f4(s,t,p)/ep)./(2*(1 - p.^2));
% %     EXACT INTEGRATION
% exI1 = quadgk(integrand1,0,inf);
% exI2 = quadgk(integrand2,0,inf);
% exI3 = quadgk(integrand3,0,inf);
% exI4 = quadgk(integrand4,0,inf);
% 
% exI = exI1 + exI2 + exI3 + exI4 + atan(s);

exI = 0;

end








