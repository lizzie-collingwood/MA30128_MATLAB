function Yp = pearceypathode(t, Y, a)
    x = Y(1);
    y = Y(2);
    f = Y(3);
    
    z = x + 1i*y;
    fp = -1i*(z.^3 + z+ a);
    
    xt = -real(fp);
    yt = imag(fp);
    ft = fp*(xt + 1i*yt);
    
    Yp = [xt; yt; ft];