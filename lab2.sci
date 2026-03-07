clear; clc; close;

function ex2()
    clear; clc; close;
    n = -5:5;
    msignal = bool2s (n >= 0);
    plot2d3(n, msignal)
    title('Exercise 2');
endfunction

function ex3()
    clear; clc; close;
    n = -5:5;
    msignal = bool2s (n == 0);
    plot2d3(n, msignal)
    title('Exercise 3');
endfunction

function ex4()
    clear; clc; close;
    n = -5:5;
    ur = n .* bool2s (n >= 0);
    plot2d3(n, ur);
    plot(n, ur, 'b*');
    a = gca(); 
    a.data_bounds = [-6, -1; 6, 6];
    xgrid;
endfunction

function ex5()
    clear; clc; close;
    n = -1:1; x = [1, 3, -2];
    x_neg = [-2, 3, 1];
    xe = 0.5 * (x + x_neg); 
    xo = 0.5 * (x - x_neg);

    subplot(2,3,1); 
    plot2d3(n, x); 
    plot(n, x, 'b*');
    a1 = gca();
    a1.data_bounds = [-2, -4; 2, 4];
    title('Original signal x(n)'); 
    xlabel('n'); 
    ylabel('x(n)');
    xgrid;

    subplot(2,3,2); 
    plot2d3(n, xo);
     plot(n, xo, 'b*');
    a2 = gca();
    a2.data_bounds = [-2, -4; 2, 4];
    title('Odd signal component x_o(n)'); 
    xlabel('n'); 
    ylabel('x_o(n)'); 
    xgrid;

    subplot(2,3,3); 
    plot2d3(n, xe); 
    plot(n, xe, 'b*');
    a3 = gca(); 
    a3.data_bounds = [-2, -4; 2, 4];
    title('Even signal component x_e(n)'); 
    xlabel('n'); 
    ylabel('x_e(n)'); 
    xgrid;
endfunction

function ex6()
    clear; clc; close;
    n = -1:3; 
    x1 = [0, 0, 1, 3, -2]; 
    x2 = [0, 1, 2, 3, 0];
    y = x1 + x2;
    
    subplot(2,3,1);
    plot2d3(n, x1);      
    plot(n, x1, 'b*');
    a1 = gca(); 
    a1.data_bounds = [-2, -4; 4, 8];
    title('Signal x_1(n)'); 
    xlabel('n'); 
    ylabel('x_1(n)'); 
    xgrid;
    
    subplot(2,3,2); 
    plot2d3(n, x2); 
    plot(n, x2, 'b*');
    a2 = gca(); 
    a2.data_bounds = [-2, -4; 4, 8];
    title('Signal x_2(n)'); 
    xlabel('n'); 
    ylabel('x_2(n)'); 
    xgrid;
    
    subplot(2,3,3); 
    plot2d3(n, y); 
    plot(n, y, 'b*');
    a3 = gca(); 
    a3.data_bounds = [-2, -4; 4, 8];
    title('Signal y(n) = x_1(n) + x_2(n)'); 
    xlabel('n'); 
    ylabel('y(n)'); 
    xgrid;
endfunction

function ex7()
    clear; clc; close;
    n = -1:3; 
    x1 = [0, 0, 1, 3, -2]; 
    x2 = [0, 1, 2, 3, 0];
    y = x1 .* x2;
    
    subplot(2,3,1); 
    plot2d3(n, x1); 
    plot(n, x1, 'b*');
    a1 = gca(); 
    a1.data_bounds = [-2, -4; 4, 10];
    title('Signal x_1(n)'); 
    xlabel('n'); 
    ylabel('x_1(n)'); 
    xgrid;
    
    subplot(2,3,2); 
    plot2d3(n, x2); 
    plot(n, x2, 'b*');
    a2 = gca();
    a2.data_bounds = [-2, -4; 4, 10];
    title('Signal x_2(n)'); 
    xlabel('n'); 
    ylabel('x_2(n)'); 
    xgrid;
    
    subplot(2,3,3); 
    plot2d3(n, y); 
    plot(n, y, 'b*');
    a3 = gca();
    a3.data_bounds = [-2, -4; 4, 10];
    title('Signal y(n) = x_1(n).x_2(n)'); 
    xlabel('n'); 
    ylabel('y(n)'); 
    xgrid;
endfunction

function ex8a()
    clear; clc; close;
    n_x = -2:1; x = [1, -2, 3, 6];
    n_y1 = -1:2
    y1 = [6, 3, -2, 1];

    subplot(2,2,1); 
    plot2d3(n_x, x); 
    plot(n_x, x, 'b*');
    a1 = gca();
    a1.data_bounds = [-3, -4; 2, 8];
    title('Original signal x(n)'); 
    xlabel('n'); 
    ylabel('x(n)'); 
    xgrid;

    subplot(2,2,2); 
    plot2d3(n_y1, y1); 
    plot(n_y1, y1, 'b*');
    a2 = gca(); 
    a2.data_bounds = [-2, -4; 3, 8];
    title('Signal y_1(n) = x(-n)'); 
    xlabel('n'); 
    ylabel('y_1(n)'); 
    xgrid; 
endfunction

function ex8b()
    clear; clc; close;
    n_x = -2:1; 
    x = [1, -2, 3, 6];
    n_y2 = -5:1; 
    y2 = [1, -2, 3, 6, 0, 0, 0];

    subplot(2,2,1); 
    plot2d3(n_x, x); 
    plot(n_x, x, 'b*');
    a1 = gca();
    a1.data_bounds = [-3, -4; 2, 8];
    title('Original signal x(n)'); 
    xlabel('n'); 
    ylabel('x(n)'); 
    xgrid;

    subplot(2,2,2); 
    plot2d3(n_y2, y2); 
    plot(n_y2, y2, 'b*');
    a2 = gca(); 
    a2.data_bounds = [-6, -4; 2, 8];
    title('Signal y_2(n) = x(n + 3)'); 
    xlabel('n'); 
    ylabel('y_2(n)'); 
    xgrid; 
endfunction

function ex8c()
    clear; clc; close;
    n_x = -2:1;
    x = [1, -2, 3, 6];
    n_y3 = -3:0; 
    y3 = [12, 6, -4, 2];

    subplot(2,2,1); 
    plot2d3(n_x, x); 
    plot(n_x, x, 'b*');
    xlabel('n'); 
    ylabel('x(n)'); 
    a1 = gca(); 
    a1.data_bounds = [-3, -6; 2, 14];
    title('Original signal x(n)'); 
    xgrid;

    subplot(2,2,2); 
    plot2d3(n_y3, y3); 
    plot(n_y3, y3, 'b*');
    xlabel('n'); ylabel('y_3(n)'); 
    a2 = gca(); 
    a2.data_bounds = [-4, -6; 1, 14];
    title('Signal y_3(n) = 2x(-n-2)');
    xgrid;
endfunction
