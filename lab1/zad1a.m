% Parametry sinusoidy
A = 230; % Amplituda [V]
f = 50; % Częstotliwość [Hz]
t = 0:0.0001:0.1; % Wektor czasu dla częstotliwości próbkowania fs1=10 kHz
t2 = 0:0.002:0.1; % Wektor czasu dla częstotliwości próbkowania fs2=500 Hz
t3 = 0:0.005:0.1; % Wektor czasu dla częstotliwości próbkowania fs3=200 Hz

% Generowanie sinusoidy
y = A*sin(2*pi*f*t);
y2 = A*sin(2*pi*f*t2);
y3 = A*sin(2*pi*f*t3);

% Wyświetlanie wyników
figure;
plot(t, y, 'b-', t2, y2, 'ro', t3, y3, 'kx');
xlabel('Czas [s]');
ylabel('Amplituda [V]');
title('Sinusoida o częstotliwości 50 Hz i amplitudzie 230 V');
legend('fs1=10 kHz', 'fs2=500 Hz', 'fs3=200 Hz');
grid on;
