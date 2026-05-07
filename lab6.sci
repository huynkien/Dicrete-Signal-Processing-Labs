// ==========================================
// LAB 6 - DIGITAL SIGNAL PROCESSING
// ==========================================

// Common function for setting font sizes
function font_size()
    ax = gca();
    ax.title.font_size = 5;
    ax.x_label.font_size = 4;
    ax.y_label.font_size = 4;
endfunction

// ==========================================
// SECTION 1: EXERCISES
// ==========================================

function ex3_a()
    // clear all; (commented to avoid clearing global scope when inside function)
    clc;
    // Define frequency range with 1000 points
    N_points = 1000;
    omega = linspace(-%pi, %pi, N_points);
    // Compute the DTFT
    X = 1 ./ (1 - 0.1 * exp(-%i * omega));
    // Calculate amplitude and phase
    amplitude = abs(X);
    phase = atan(imag(X), real(X)); // Phase in radians

    // Plot the spectra
    scf(0);clf(0);
    subplot(2,1,1);
    plot(omega, amplitude);
    xlabel('Frequency (radians/sample)', 'fontsize', 3);
    ylabel('Amplitude', 'fontsize', 3);
    title('Amplitude Spectrum of x₁(n) = 0.1^n u(n)', 'fontsize', 5);
    xgrid;

    subplot(2,1,2);
    plot(omega, phase);
    xlabel('Frequency (radians/sample)', 'fontsize', 3);
    ylabel('Phase (radians)', 'fontsize', 3);
    title('Phase Spectrum of x₁(n) = 0.1^n u(n)', 'fontsize', 5);
    xgrid;
endfunction

function ex3_b()
    // clear;
    clc;
    // Define frequency axis (normalized frequency, -π to π)
    N = 1000;
    // Number of frequency points
    omega = linspace(-%pi, %pi, N); // Frequency range from -π to π

    // Compute the DTFT: X2(e^jω) = (1 - e^(-j4ω)) / (1 - e^(-jω))
    num = 1 - exp(-%i * 4 * omega);
    // Numerator
    den = 1 - exp(-%i * omega); // Denominator
    X2 = num ./ den;
    // DTFT (element-wise division)

    // Handle potential division by zero (when e^(-jω) = 1, i.e., ω = 2kπ)
    X2(den == 0) = 4;
    // At ω = 0, 2π, etc., the value is the sum of 4 impulses

    // Compute amplitude and phase
    amplitude = abs(X2);
    phase = atan(imag(X2), real(X2));

    // Plotting
    // Amplitude Spectrum
    scf(0);clf(0);
    subplot(2,1,1);
    plot(omega, amplitude, 'b');
    xtitle('Amplitude Spectrum of x_2(n)', 'Frequency (radians/sample)', 'Amplitude');
    font_size();
    xgrid;

    // Phase Spectrum
    subplot(2,1,2);
    plot(omega, phase, 'r');
    xtitle('Phase Spectrum of x_2(n)', 'Frequency (radians/sample)', 'Phase (radians)');
    font_size();
    xgrid;
endfunction

function ex4()
    // clear;
    clc;
    // Define frequency range
    omega = linspace(-%pi, %pi, 1000);
    // Compute H(omega)
    numerator = exp(%i * 2 * omega);
    denominator = exp(%i * 2 * omega) + 0.1 * exp(%i * omega) + 0.2;
    H = numerator ./ denominator;

    // Amplitude spectrum |H(omega)| using abs
    H_mag = abs(H);
    // Phase spectrum angle H(omega) in radians using atan, imag, and real
    H_phase = atan(imag(H), real(H));
    // Create figure for amplitude spectrum
    scf(0);clf(0);
    subplot(2,1,1);
    plot(omega, H_mag, 'b');
    xlabel('Frequency (radians/sample)');
    ylabel('Amplitude');
    title('Amplitude Spectrum');
    font_size();
    xgrid;
    // Create figure for phase spectrum
    subplot(2,1,2);
    plot(omega, H_phase, 'r');
    xlabel('Frequency (radians/sample)');
    ylabel('Phase (radians)');
    title('Phase Spectrum');
    font_size();
    xgrid;
endfunction

function ex5()
    // clear;
    clc;
    // Define frequency range
    omega = linspace(-%pi, %pi, 1000);
    // Compute Y(omega)
    numerator = 1 + exp(-%i * omega);
    denominator = 1 - 0.5 * exp(-%i * omega);
    Y = numerator ./ denominator;

    // Amplitude spectrum |Y(omega)| using abs
    Y_mag = abs(Y);
    // Phase spectrum angle Y(omega) in radians using atan, imag, and real
    Y_phase = atan(imag(Y), real(Y));
    // Create figure for amplitude spectrum
    scf(0);clf(0);
    subplot(2,1,1);
    plot(omega, Y_mag, 'b');
    xlabel('Frequency (radians)');
    ylabel('Amplitude');
    title('Amplitude Spectrum of Output y(n)');
    font_size();
    xgrid;
    // Create figure for phase spectrum
    subplot(2,1,2);
    plot(omega, Y_phase, 'r');
    xlabel('Frequency (radians)');
    ylabel('Phase (radians)');
    title('Phase Spectrum of Output y(n)');
    font_size();
    xgrid;
endfunction

// ==========================================
// SECTION 2: ADDITIONAL EXERCISES
// ==========================================

function extra_4_2a()
    // clear;
    clc;
    // Define frequency range
    F = linspace(-10, 10, 1000);

    // Compute H(F)
    numerator = 2;
    denominator = 4 + %i * 2 * %pi * F;
    H = numerator ./ denominator;

    // Amplitude spectrum |H(F)|
    // using abs
    H_mag = abs(H);

    // Phase spectrum angle H(F) in radians using atan, imag, and real
    H_phase = atan(imag(H), real(H));
    // Create figure for amplitude spectrum
    scf(0); clf(0);
    subplot(1,2,1);
    plot(F, H_mag, 'b');
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title('Amplitude Spectrum of |Xa(F)|');
    font_size();
    xgrid;
    // Create figure for phase spectrum
    subplot(1,2,2);
    plot(F, H_phase, 'r');
    xlabel('Frequency (Hz)');
    ylabel('Phase (radians)');
    title('Phase Spectrum of Xa(F)');
    font_size();
    xgrid;
endfunction

function extra_4_2b()
    // clear;
    clc;
    // Define parameters
    A = 2;
    a = 6;
    // Frequency range from 0 to 25
    F = linspace(-20, 20, 1000);
    // 100 points for smooth plotting

    // Compute the amplitude spectrum
    Xa = (2 * A * a) ./ (a^2 + (2 * %pi * F).^2);
    // Plot the amplitude spectrum
    scf(0); clf(0);
    plot(F, Xa, 'b-', 'LineWidth', 2); // Blue line, thicker for visibility
    xlabel('Frequency (Hz)', 'FontSize', 2);
    ylabel('|Xa(F)|', 'FontSize', 2);
    title('Amplitude Spectrum', 'FontSize', 3);
    font_size();
    xgrid;
endfunction

function extra_4_3()
    // clear;
    clc;
    // Define parameters
    tau = 1;
    // Width of the pulse, you can change this value
    F = -5:0.01:5;
    // Frequency range from -5 to 5 Hz with a step of 0.01

    // Compute the amplitude spectrum
    X_a = tau * (sin(%pi * F * tau) ./ (%pi * F * tau)).^2;
    // Handle the case where F = 0 (to avoid division by zero)
    X_a(F == 0) = tau;
    // At F = 0, the value is tau (limit of the sinc^2 function)

    // Plot the amplitude spectrum
    scf(0); clf(0);
    plot(F, X_a, 'b', 'LineWidth', 2);
    xlabel('Frequency F (Hz)');
    ylabel('|X_a(F)|');
    title('Amplitude Spectrum');
    font_size();
    xgrid;
endfunction

function extra_4_9a()
    // clear;
    clc;
    // Define the frequency range
    w = linspace(-%pi, %pi, 1000);
    // Frequency from -pi to pi, 1000 points

    // Compute X(w) = (1 - exp(-j*6*w)) / (1 - exp(-j*w))
    numerator = 1 - exp(-%i * 6 * w);
    denominator = 1 - exp(-%i * w);

    // Avoid division by zero by adding a small epsilon to denominator
    epsilon = 1e-10;
    denominator = denominator + epsilon * (denominator == 0);
    Xw = numerator ./ denominator;
    // Compute amplitude and phase
    amplitude = abs(Xw); // Magnitude spectrum
    phase = atan(imag(Xw), real(Xw));
    // Phase spectrum in radians

    // Plotting
    // Amplitude Spectrum
    scf(0);clf(0);
    subplot(2,1,1);
    plot(w, amplitude, 'b-', 'LineWidth', 2);
    xlabel('Frequency (radians)');
    ylabel('Amplitude');
    title('Amplitude Spectrum');
    font_size();
    xgrid;

    // Phase Spectrum
    subplot(2,1,2);
    plot(w, phase, 'r-', 'LineWidth', 2);
    xlabel('Frequency (radians)');
    ylabel('Phase (radians)');
    title('Phase Spectrum');
    font_size();
    xgrid;
endfunction

function extra_4_9f()
    // clear;
    clc;
    // Define the frequency range
    w = linspace(-%pi, %pi, 1000);
    // Frequency from -pi to pi, 1000 points

    // Compute X(w) directly from the sum: sum from n=-4 to 4 of [2 - (1/2)^n] * e^(-j*w*n)
    Xw = zeros(1, length(w));
    // Initialize X(w)
    for n = -4:4
        Xw = Xw + (2 - (1/2)^n) * exp(-%i * w * n);
    end

    // Compute amplitude and phase
    amplitude = abs(Xw); // Magnitude spectrum
    phase = atan(imag(Xw), real(Xw));
    // Phase spectrum in radians

    // Plotting
    // Amplitude Spectrum
    scf(0);clf(0);
    subplot(2,1,1);
    plot(w, amplitude, 'b-', 'LineWidth', 2);
    xlabel('Frequency (radians)');
    ylabel('Amplitude');
    title('Amplitude Spectrum');
    font_size();
    xgrid;

    // Phase Spectrum
    subplot(2,1,2);
    plot(w, phase, 'r-', 'LineWidth', 2);
    xlabel('Frequency (radians)');
    ylabel('Phase (radians)');
    title('Phase Spectrum');
    font_size();
    xgrid;
endfunction

function extra_4_9g()
    // clear;
    clc;
    // Define the frequency range
    w = linspace(-%pi, %pi, 1000);
    // Frequency from -pi to pi, 1000 points

    // Compute X(w) = -2j [2*sin(2w) + sin(w)]
    Xw = -2 * %i * (2 * sin(2 * w) + sin(w));
    // Compute amplitude and phase
    amplitude = abs(Xw); // Magnitude spectrum
    phase = atan(imag(Xw), real(Xw));
    // Phase spectrum in radians

    // Plotting
    // Amplitude Spectrum
    scf(0);clf(0);
    subplot(2,1,1);
    plot(w, amplitude, 'b-', 'LineWidth', 2);
    xlabel('Frequency (radians)');
    ylabel('Amplitude');
    title('Amplitude Spectrum');
    xgrid;
    // Phase Spectrum
    subplot(2,1,2);
    plot(w, phase, 'r-', 'LineWidth', 2);
    xlabel('Frequency (radians)');
    ylabel('Phase (radians)');
    title('Phase Spectrum');
    xgrid;
endfunction

// ==========================================
// EXECUTION COMMAND
// ==========================================

extra_4_2b();
