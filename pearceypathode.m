function Yp = pearceypathode(t, Y, a, airy)
    x = Y(1);
    y = Y(2);
    
    z = x + 1i*y;
    
    if airy==1
%     airy
        fp = -z.^2+a;
    else
        fp = -1i*(z.^3 + z + a);
    end
    
    xt = -real(fp);
    yt = imag(fp);
    ft = fp*(xt + 1i*yt);
    
    Yp = [xt; yt; ft];