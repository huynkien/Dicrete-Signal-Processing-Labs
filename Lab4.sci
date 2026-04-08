
function style(x)
    xgrid;
    e = get(gce(),'children');
    e.thickness = 3;
    e.foreground=x;
    e.mark_style=x;
    e.mark_size=1;
    e.mark_foreground=x;
    e.mark_offset=1;
    e.mark_stride=2;
    e.polyline_style=3;
    e.line_mode="on"
endfunction

function ex5()
    
    clc; clear;
    
    atomsLoad("IPCV");
    img = imread('sample.tif');
    
    // Convert to grayscale
    gray = rgb2gray(img);
    
    scf(0); clf(0);
    
    // Original image
    subplot(221);
    imshow(img);
    title('Original Image', 'fontsize', 5);
    
    // Histogram grayscale
    subplot(222);
    [qtd, level] = imhist(gray);
    plot2d3(level, qtd);
    title('Histogram', 'fontsize', 5);
    
    // Histogram Equalization
    img_equal = imhistequal(gray);
    
    // Equalized imageimg
    subplot(223);
    imshow(img_equal);
    title('Equalized Image', 'fontsize', 5);
    
    // Histogram after equalization
    subplot(224);
    [qtde, levele] = imhist(img_equal);
    plot2d3(levele, qtde);
    title('Equalized Histogram', 'fontsize', 5);
    
    // Blur
    // Apply a 3x3 median filter for blurring
    img_blur = immedian(img, 9);
    
    // Create a new figure to display the blurred image
    scf(1);clf(1);
    subplot(121); imshow(img); 
    title('Original Image', 'fontsize', 5);
    subplot(122); imshow(img_blur); 
    title('Blurred Image', 'fontsize', 5);
    
    
    
     // Watermarking
    watermark = imread('bk_figure.jpg');
    
    // Get image size
    dims = size(img);
    h = dims(1);
    w = dims(2);
    
    // Resize watermark to match image
    watermark = imresize(watermark, [h, w]);
    
    // Transparency
    alpha = 0.3;
    
    // Blend (RGB with RGB)
    img_watermarked = uint8((1 - alpha) * double(img) + alpha * double(watermark));
    
    // Display
    scf(2); clf(2);
    imshow(img_watermarked);
    title('Watermarked Image', 'fontsize', 5);
endfunction

function ex6()
    clc;clear;
    
    // Folding and shifting method using conv
    h = [1, 0, -1];        // h(n) for n=0,1,2
    x = [1, 2, -3, 2, 1];  // x(n) for n=0,1,2,3,4
    y = conv(h, x);        // Compute convolution
    disp('Convolution using folding and shifting method:');
    disp(y);
    
    // Matrix method
    h = [1, 0, -1];
    x = [1, 2, -3, 2, 1];
    m = length(h);    // 3
    n = length(x);    // 5
    p = m + n - 1;    // 7
    
    // Construct Toeplitz matrix H
    H = zeros(p, n);
    for i = 1:p
        for j = 1:n
            k = i - j;
            if k >= 0 & k < m
                H(i,j) = h(k+1);
            end
        end
    end
    
    y_matrix = H * x';    // x' is column vector
    disp('Convolution using matrix method:');
    disp(y_matrix');
    
    // Plotting
    n_x = 0:4;
    x_values = [1, 2, -3, 2, 1];
    n_y = 0:6;
    y_values = [1, 2, -4, 0, 4, -2, -1];
    
    scf(0);clf(0);
    plot2d(n_x, x_values);  
    style(2);
    plot2d(n_y, y_values);
    style(5);
    legend(['x(n), E_x', 'y(n), E_y'], 4);
    xtitle('Discrete Signals', 'n', 'Amplitude');
endfunction

function ex7()
    clear;clc;
    
    x1 = [1, 2, -3, 2, 1];
    x2 = [1, 0, -1, -1, 1];
    
    m = length(x1);
    n = length(x2);
    a = zeros(1, max(m,n));
    if (m >n)
        for i = n+1:m
            x2(i) = 0;
        end
    elseif (n>m)
        for i = m+1:n
            x1(i) = 0;
        end
    end
    N = length(x1);
    x3 = zeros(1,N);
    a(1) = x2(1);
    for j = 2:N
        a(j) = x2(N-j+2);
    end
    for i =1:N
        x3(1) = x3(1)+x1(i)*a(i);
    end
    for k = 2:N
        for j =2:N
            x2(j) = a(j-1);
        end
        x2(1) = a(N);
        x2;
        for i = 1:N
            a(i) = x2(i);
            x3(k) = x3(k)+x1(i)*a(i);
        end
    end
    disp('Circular Convolution Result x3 = ');
    disp(x3);
    ////////////////////////////////////////////
    // Define signals
    x = [1, 2, -3, 2, 1];
    h = [1, 0, -1, -1, 1];
    N = 5;
    
    // Form circulant matrix using toeplitz
    r = [h(1), h(5:-1:2)];  // [1, 1, -1, -1, 0]
    H = toeplitz(h, r);
    
    // Compute convolution
    y_matrix = H * x';
    
    // Display result
    disp('y(n) using matrix method:');
    disp(y_matrix');
    ///////////////////////////////////////////
    // Define signals
    x = [1, 2, -3, 2, 1];
    h = [1, 0, -1, -1, 1];
    N = 5;
    
    y = y_matrix;
    
    // Time indices
    n = 0:N-1;
    
    // Plot
    scf(0);clf(0); 
    plot2d(n, x);
    style(2);
    plot2d(n, y);
    style(5);
    legend(['x(n), E_x', 'y(n), E_y'], 4);
    a=get("current_axes");
    l=a.children(1);6
    l.font_size = 5;
    title('x(n), y(n)', 'fontsize', 5);
    xlabel('n', 'fontsize', 5);
    ylabel('amplitude', 'fontsize', 5);
    
    xgrid;
endfunction

//ex5();
//ex6();
ex7();
