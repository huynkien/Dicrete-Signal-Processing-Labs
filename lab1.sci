clc; clear;

function ex1()
    clear ; clc;
    //-------1.1.a--------//
    x=1:4
    disp(x+1)
    //-------1.1.b--------//
    x=1:4;
    y=5:8;
    disp(x.*y)
    //-------1.1.c--------//
    x = linspace(0, %pi, 10);
    disp(sin(x))
endfunction


function ex2()
    clear; clc; close;
    // Parameters
    F = 50; 
    A = 3; 
    Fs = 300; 
    T = 1/Fs;
    
    // Analog signal
    t = linspace(0, 5*(1/F), 1000);
    xa = A * sin(2 * %pi * F * t);

    subplot(1,3,1);
    plot(t, xa);
    e = gce(); 
    e.children.thickness = 2;
    title('Analog Signal x_a(t)');
    xgrid;

    // Discrete-time signal
    n = 0: (5 * Fs/F); 
    xn = A * sin(2 * %pi * F * (n * T)); // 

    subplot(1,3,2);
    plot2d3(n, xn);
    e = gce(); 
    e.children.thickness = 2;
    title('Discrete-Time Signal x(n)');
    xgrid;

    // Quantization
    Delta = 0.1;
    threshold = 1e-5; // Threshold for small values
    xn(abs(xn) < threshold) = 0; // Set small values to zero
    xq = Delta * floor(xn / Delta); 

    subplot(1,3,3);
    plot2d3(n, xq);
    e = gce(); 
    e.children.thickness = 2;
    title('Quantized Signal x_q(n)');
    xgrid;
endfunction


