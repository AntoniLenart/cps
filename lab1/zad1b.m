clear all; close all; clc
% Parametry sinusoidy
A = 230; % Amplituda [V]
f = 50; % Częstotliwość [Hz]
t = 0:0.0001:1; % Wektor czasu dla częstotliwości próbkowania fs1=10 kHz
t2 = 0:1/51:1; % Wektor czasu dla częstotliwości próbkowania fs2=51 Hz
t3 = 0:1/50:1; % Wektor czasu dla częstotliwości próbkowania fs3=50 Hz
t4 = 0:1/49:1; % Wektor czasu dla częstotliwości próbkowania fs4=49 Hz

% Generowanie sinusoidy
y = A*sin(2*pi*f*t);
y2 = A*sin(2*pi*f*t2);
y3 = A*sin(2*pi*f*t3);
y4 = A*sin(2*pi*f*t4);

% Wyświetlanie wyników
figure;
plot(t, y, 'b-', t2, y2, 'go', t3, y3, 'ro', t4, y4, 'ko');
xlabel('Czas [s]');
ylabel('Amplituda [V]');
title('Sinusoida o częstotliwości 50 Hz i amplitudzie 230 V');
legend('fs1=10 kHz', 'fs2=51 Hz', 'fs3=50 Hz', 'fs4=49 Hz');
grid on;
pause;

%-------------------------------------------------------------------------%
% Parametry sinusoidy
t2_new = 0:1/26:1; % Wektor czasu dla częstotliwości próbkowania fs2=26 Hz
t3_new = 0:1/25:1; % Wektor czasu dla częstotliwości próbkowania fs3=25 Hz
t4_new = 0:1/24:1; % Wektor czasu dla częstotliwości próbkowania fs4=24 Hz

% Generowanie sinusoidy
y2_new = A*sin(2*pi*f*t2_new);
y3_new = A*sin(2*pi*f*t3_new);
y4_new = A*sin(2*pi*f*t4_new);

% Wyświetlanie wyników
figure;
plot(t, y, 'b-', t2_new, y2_new, 'go', t3_new, y3_new, 'ro', t4_new, y4_new, 'ko');
xlabel('Czas [s]');
ylabel('Amplituda [V]');
title('Sinusoida o częstotliwości 50 Hz i amplitudzie 230 V');
legend('fs1=10 kHz', 'fs2=26 Hz', 'fs3=25 Hz', 'fs4=24 Hz');
grid on;
