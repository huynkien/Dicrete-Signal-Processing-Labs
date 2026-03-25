function [yn, yorigin] = delay(xn, xorigin, k)
    //clc; close;
    scf();
    yn = xn;
    yorigin = xorigin - k;
    disp('yn = ', yn);
    disp('yorigin =', yorigin);
    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;
    
    subplot(2, 1, 1);
    plot2d3(nx, xn);
    plot(nx, xn, 'b*');
    ax = gca();
    ax.data_bounds = [min(nx)-1, min(xn)-1; max(nx)+k+1, max(xn)+1];
    title('Signal x(n)');
    xlabel('n');
    ylabel('x(n)');
    xgrid;
    
    subplot(2, 1, 2);
    plot2d3(ny, yn);
    plot(ny, yn, 'b*');
    ay = gca();
    ay.data_bounds = [min(ny)-k-1, min(yn)-1; max(ny)+1, max(yn)+1];
    title('Signal y(n) = Delay x(n)');
    xlabel('n');
    ylabel('y(n)');
    xgrid;
endfunction

function [yn, yorigin] = advance(xn, xorigin, k)
    //clc; close;
    yn = xn;
    yorigin = xorigin + k;
    disp('yn = ', yn);
    disp('yorigin =', yorigin);
    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;
    
    subplot(2, 1, 1);
    plot2d3(nx, xn);
    plot(nx, xn, 'b*');
    ax = gca();
    ax.data_bounds = [min(nx)-k-1, min(xn)-1; max(nx)+1, max(xn)+1];
    title('Signal x(n)');
    xlabel('n');
    ylabel('x(n)');
    xgrid;
    
    subplot(2, 1, 2);
    plot2d3(ny, yn);
    plot(ny, yn, 'b*');
    ay = gca();
    ay.data_bounds = [min(ny)-1, min(yn)-1; max(ny)+k+1, max(yn)+1];
    title('Signal y(n) = Advance x(n)');
    xlabel('n');
    ylabel('y(n)');
    xgrid;
endfunction

function [yn, yorigin] = fold(xn, xorigin)
    //clc; close;
    scf();
    yn = xn($:-1:1);
    yorigin = length(xn) - xorigin + 1;
    disp('yn = ', yn);
    disp('yorigin =', yorigin);
    nx = (1:length(xn)) - xorigin;
    ny = (1:length(yn)) - yorigin;
    
    subplot(2, 1, 1);
    plot2d3(nx, xn);
    plot(nx, xn, 'b*');
    ax = gca();
    ax.data_bounds = [min(nx)-1, min(xn)-1; max(nx)+2, max(xn)+1];
    title('Signal x(n)');
    xlabel('n');
    ylabel('x(n)');
    xgrid;
    
    subplot(2, 1, 2);
    plot2d3(ny, yn);
    plot(ny, yn, 'b*');
    ay = gca();
    ay.data_bounds = [min(ny)-2, min(yn)-1; max(ny)+1, max(yn)+1];
    title('Signal y(n) = Fold x(n)');
    xlabel('n');
    ylabel('y(n)');
    xgrid;
endfunction

function [yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
    //clc; close;
    // Determine time ranges for x1(n) and x2(n)
    n1_start = 1 - x1origin;
    n1_end   = length(x1n) - x1origin;
    n2_start = 1 - x2origin;
    n2_end   = length(x2n) - x2origin;
    // y(n) range is the union of the two ranges
    n_start  = min(n1_start, n2_start);
    n_end    = max(n1_end  , n2_end);
    yorigin  = 1 - n_start;
    // Init time vector ny and zeros array for yn
    ny = n_start:n_end;
    yn = zeros(1, length(ny));
    // Add samples wherever each signal is defined
    for i = 1:length(ny)
        if (ny(i) >= n1_start) & (ny(i) <= n1_end) then
            index1 = ny(i) + x1origin;   // Map n to index in x1n
            yn(i)  = yn(i) + x1n(index1);
        end
        if (ny(i) >= n2_start) & (ny(i) <= n2_end) then
            index2 = ny(i) + x2origin;   // Map n to index in x2n
            yn(i)  = yn(i) + x2n(index2);
        end
    end

    // Plot x1(n), x2(n), and y(n) in the same figure
    subplot(3,1,1); // Plot x1(n)
    plot2d3(n1_start:n1_end, x1n); plot(n1_start:n1_end, x1n, 'b*');
    ax1 = gca(); // Adjust axes to fit all signals
    ax1.data_bounds = [n1_start-2, min(x1n)-1; n1_end+1, max(x1n)+1];
    title('Signal x1(n)'); xlabel('n'); ylabel('x1'); xgrid;

    subplot(3,1,2); // Plot x2(n)
    plot2d3(n2_start:n2_end, x2n); plot(n2_start:n2_end, x2n, 'b*');
    ax2 = gca(); 
    ax2.data_bounds = [n2_start-1, min(x2n)-1; n2_end+2, max(x2n)+1];
    title('Signal x2(n)'); xlabel('n'); ylabel('x2'); xgrid;

    subplot(3,1,3); // Plot y(n)
    plot2d3(ny, yn); plot(ny, yn, 'b*');
    ay = gca(); 
    ay.data_bounds = [n_start-1, min(yn)-1; n_end+1, max(yn)+1];
    title('Signal y(n) = x1(n) + x2(n)'); xlabel('n'); ylabel('y'); xgrid;
endfunction

function [yn, yorigin] = multi(x1n, x1origin, x2n, x2origin)
    //clc; close;
    // Find y(n) interval and y origin
    n1_start = 1 - x1origin;
    n1_end   = length(x1n) - x1origin;
    n2_start = 1 - x2origin;
    n2_end   = length(x2n) - x2origin;
    // y(n) range is the union of the two ranges
    n_start  = min(n1_start, n2_start);
    n_end    = max(n1_end  , n2_end);
    yorigin  = 1 - n_start;
    
    // Create time vector and signal y(n) vector
    ny  = n_start:n_end;
    yn = zeros(1, length(ny));
    
    // Multiply only if both signals have samples at time n
    for i = 1:length(ny)
        if (ny(i) >= max(n1_start, n2_start)) & (ny(i) <= min(n1_end, n2_end)) then
            index1 = ny(i) + x1origin;
            index2 = ny(i) + x2origin;
            // Since both signals exist at this n, 
            // then plus with the product of the two samples
            yn(i)  = yn(i) + x1n(index1) * x2n(index2);
        end
    end
    
    // Draw x1 signal
    subplot(3,1,1);
    plot2d3(n1_start:n1_end, x1n);
    plot(n1_start:n1_end, x1n, 'b*');
    ax1 = gca(); // Adjust axes to fit all signals;
    ax1.data_bounds = [n1_start-2, min(x1n)-1; n1_end+1, max(x1n)+1];
    title('Signal x1(n)'); xlabel('n'); ylabel('x1'); xgrid;
    
    // Draw x2 signal
    subplot(3,1,2);
    plot2d3(n2_start:n2_end, x2n);
    plot(n2_start:n2_end, x2n, 'b*');
    ax2 = gca();
    ax2.data_bounds = [n2_start-1, min(x2n)-1; n2_end+2, max(x2n)+1];
    title('Signal x2(n)'); xlabel('n'); ylabel('x2'); xgrid;
    
    // Draw y(n) = x1(n) * x2(n) signal
    subplot(3,1,3);
    plot2d3(ny, yn);
    plot(ny, yn, 'b*');
    ay = gca();
    ay.data_bounds = [n_start-1, min(yn)-1; n_end+1, max(yn)+1];
    title('Signal y(n) = x1(n).x2(n)'); xlabel('n'); ylabel('y'); xgrid;
endfunction

function [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
    //clc; close;

    // n-index ranges of x(n) and h(n)
    nx = (1:length(xn)) - xorigin;
    nh = (1:length(hn)) - horigin;

    // y(n) has length length(x)+length(h)-1
    n_start = min(nx) + min(nh);
    n_end   = max(nx) + max(nh);
    ny      = n_start:n_end;
    yorigin = 1 - n_start;
    yn      = zeros(1, length(ny));

    // Discrete convolution: y(n) = sum_k x(k) h(n-k)
    // Pairwise implementation: n = nx(ix) + nh(ih)
    for ix = 1:length(xn)
        for ih = 1:length(hn)
            n_val = nx(ix) + nh(ih);
            iy = n_val - n_start + 1;
            yn(iy) = yn(iy) + xn(ix) * hn(ih);
        end
    end

    // Display result and compare with built-in function for verification
    disp('Implemented convolution yn = ', yn);
    disp('yorigin = ', yorigin);
    disp('Built-in convolution = ', conv(xn, hn)); // Built-in convolution 
endfunction

//[yn, yorigin] =   delay([1, -2, 3, 6], 3, 1);
//[yn, yorigin] = advance([1, -2, 3, 6], 3, 1);
//[yn, yorigin] =    fold([1, -2, 3, 6], 3);
//[yn, yorigin] =     add([0, 1, 3, -2], 1, [1, 1, 2, 3], 2);
//[yn, yorigin] =   multi([0, 1, 3, -2], 1, [1, 1, 2, 3], 2);
//[yn, yorigin] =   convolution([0, 1, 3, -2], 1, [1, 1, 2,  3], 2);


function bai21()
    clc; close;
    scf();
    xn = [0, 1/3, 2/3, 1, 1, 1, 1];
    xn_range = [-3:3];
    xn_origin = 4;
    // a)
    plot2d3(xn_range, xn); plot(xn_range, xn, 'b*');
    ax = gca(); ax.data_bounds = [-4, -1; 4, 2];
    title('Signal x(n) - exercise 2.1'); xlabel('n'); ylabel('x(n)'); xgrid;
    
    // c)
    [xn, xn_origin] = fold(xn, xn_origin);
    [xn, xn_origin] = delay(xn, xn_origin, 4);
endfunction

function bai22_original(xn, xorigin)
    scf();
    nx = (1:length(xn)) - xorigin;
    plot2d3(nx, xn); plot(nx, xn, 'b*');
    ax = gca(); ax.data_bounds = [-3, -0.5; 5, 1.5];
    title('Signal x(n) - Original'); xlabel('n'); ylabel('x(n)'); xgrid;
endfunction

// a) x(n-2)
function bai22_a(xn, xorigin)
    scf();
    disp('--- (a) x(n-2) ---');
    [ya, ya_origin] = delay(xn, xorigin, 2);
endfunction


// b) x(4-n)
function bai22_b(xn, xorigin)
    scf();
    disp('--- (b) x(4-n) ---');
    [x_folded, origin_folded] = fold(xn, xorigin);
    [yb, yb_origin] = delay(x_folded, origin_folded, 4);
endfunction


// c) x(n+2)
function bai22_c(xn, xorigin)
    scf();
    disp('--- (c) x(n+2) ---');
    [yc, yc_origin] = advance(xn, xorigin, 2);
endfunction

// d) x(n)u(2-n)
function bai22_d(xn, xorigin)
    scf();
    disp('--- (d) x(n)u(2-n) ---');
    // Create u(2-n) = 1 at n <= 2, = 0 at n > 2
    un = [1, 1, 1, 1, 1, 0, 0]; 
    uorigin = 3; 
    [yd, yd_origin] = multi(xn, xorigin, un, uorigin);
endfunction


// e) x(n-1) * delta(n-3) 
function bai22_e(xn, xorigin)
    scf();
    disp('--- (e) x(n-1)*delta(n-3) ---');
    [x_delayed1, org_delayed1] = delay(xn, xorigin, 1);
    // Create delta(n-3) = 1 at n=3, = 0 elsewhere
    scf();
    deltan = [0, 0, 0, 1]; // n = [0, 1, 2, 3]
    delta_origin = 1;      // n=0 at index 1
    [ye, ye_origin] = multi(x_delayed1, org_delayed1, deltan, delta_origin);
endfunction

// f) x(n^2)
function bai22_f(xn, xorigin)
    scf();
    disp('--- (f) x(n^2) ---');
    nf = [-2:2]; // n^2 mean at n = 0, 1, 4
    yf = zeros(1, length(nf));
    for i = 1:length(nf)
        n_sq = nf(i)^2;
        if (n_sq >= -2) & (n_sq <= 4) then
            yf(i) = xn(n_sq + xorigin);
        end
    end
    plot2d3(nf, yf); plot(nf, yf, 'b*');
    ax_f = gca(); ax_f.data_bounds = [-3, -0.5; 3, 1.5];
    title('Signal y(n) = x(n^2)'); xlabel('n'); ylabel('y'); xgrid;
endfunction


// g) Even: xe(n) = 0.5 * (x(n) + x(-n))
function bai22_g(xn, xorigin)
    scf();
    disp('--- (g) Even part ---');
    [x_folded, origin_folded] = fold(xn, xorigin);
    scf();
    [x_add, org_add] = add(xn, xorigin, x_folded, origin_folded);
    xe = 0.5 * x_add; 
    
    // Redraw even
    scf();
    ne = (1:length(xe)) - org_add;
    plot2d3(ne, xe); plot(ne, xe, 'b*');
    ax_e = gca(); ax_e.data_bounds = [-5, -0.5; 5, 1.5];
    title('Even part x_e(n)'); xlabel('n'); ylabel('y'); xgrid;
endfunction

// h) Odd: xo(n) = 0.5 * (x(n) - x(-n))
function bai22_h(xn, xorigin)
    scf();

    [x_folded, origin_folded] = fold(xn, xorigin);
    scf();
    x_folded_neg = -1 * x_folded;
    [x_sub, org_sub] = add(xn, xorigin, x_folded_neg, origin_folded);
    xo = 0.5 * x_sub;
    
    // Redraw odd
    scf();
    no = (1:length(xo)) - org_sub;
    plot2d3(no, xo); plot(no, xo, 'b*');
    ax_o = gca(); ax_o.data_bounds = [-5, -1; 5, 1];
    title('Odd part x_o(n)'); xlabel('n'); ylabel('y'); xgrid;
endfunction

function run_all_bai22()
    clc; close;
    
    // Init x(n)
    xn = [0, 1, 1, 1, 1, 0.5, 0.5];
    xorigin = 3; 

    // Call functions
    //bai22_original(xn, xorigin);
    //bai22_a(xn, xorigin);
    //bai22_b(xn, xorigin);
    //bai22_c(xn, xorigin);
    //bai22_d(xn, xorigin);
    //bai22_e(xn, xorigin);
    //bai22_f(xn, xorigin);
    bai22_g(xn, xorigin);
    //bai22_h(xn, xorigin);
endfunction

// Run all excercise 2.2
run_all_bai22();


