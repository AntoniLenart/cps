clear all; close all; clc
% Parametry
fs = 100; % Częstotliwość próbkowania [Hz]
t = 0:1/fs:1; % Wektor czasu dla 1 sekundy
freq_range = 0:5:300; % Zakres częstotliwości od 0 do 300 Hz co 5 Hz
num_loops = numel(freq_range); % Liczba obiegów pętli

% %%Pętla generująca sinusoidy i wyświetlająca je
figure;
for i = 1:num_loops
    freq = freq_range(i);
    y = sin(2*pi*freq*t);

    % Wyświetlanie
    plot(t, y);
    hold on;
    xlabel('Czas [s]');
    ylabel('Amplituda');
    title(['Sinusoida o częstotliwości ', num2str(freq), ' Hz']);
    grid on;
    pause(0.5); % Pauza między wyświetleniami
    hold off;
end

% Porównanie sinusoid o różnych częstotliwościach
figure;
y1 = sin(2*pi*5*t);
y2 = sin(2*pi*105*t);
y3 = sin(2*pi*205*t);
plot(t, y1, 'b-', t, y2, 'kx', t, y3, 'ro');
grid on;
xlabel('Czas [s]');
ylabel('Amplituda [V]');
title("Porównanie 5, 105 i 205")
legend('5 Hz', '105 Hz', '205 Hz')

figure;
y1 = sin(2*pi*95*t);
y2 = sin(2*pi*195*t);
y3 = sin(2*pi*295*t);
plot(t, y1, 'b-', t, y2, 'kx', t, y3, 'ro');
grid on;
xlabel('Czas [s]');
ylabel('Amplituda [V]');
title("Porównanie 95, 195, 295")
legend('95 Hz', '195 Hz', '295 Hz')

figure;
y1 = sin(2*pi*95*t);
y2 = sin(2*pi*105*t);
plot(t, y1, 'b-', t, y2, 'r-');
grid on;
xlabel('Czas [s]');
ylabel('Amplituda [V]');
title("Porównanie 95, 105")
legend('95 Hz', '105 Hz')

pause;

%%Pętla generująca sinusoidy i wyświetlająca je
figure;
for i = 1:num_loops
    freq = freq_range(i);
    y = cos(2*pi*freq*t);

    % Wyświetlanie
    plot(t, y);
    hold on;
    xlabel('Czas [s]');
    ylabel('Amplituda');
    title(['Cosinusoida o częstotliwości ', num2str(freq), ' Hz']);
    grid on;
    pause(0.5); % Pauza między wyświetleniami
    hold off;
end

% Porównanie cosinusoid o różnych częstotliwościach
figure;
y1 = cos(2*pi*5*t);
y2 = cos(2*pi*105*t);
y3 = cos(2*pi*205*t);
plot(t, y1, 'b-', t, y2, 'kx', t, y3, 'ro');
grid on;
xlabel('Czas [s]');
ylabel('Amplituda [V]');
title("Porównanie 5, 105 i 205")
legend('5 Hz', '105 Hz', '205 Hz')

figure;
y1 = cos(2*pi*95*t);
y2 = cos(2*pi*195*t);
y3 = cos(2*pi*295*t);
plot(t, y1, 'b-', t, y2, 'kx', t, y3, 'ro');
grid on;
xlabel('Czas [s]');
ylabel('Amplituda [V]');
title("Porównanie 95, 195, 295")
legend('95 Hz', '195 Hz', '295 Hz')

figure;
y1 = cos(2*pi*95*t);
y2 = cos(2*pi*105*t);
plot(t, y1, 'b-', t, y2, 'r-');
grid on;
xlabel('Czas [s]');
ylabel('Amplituda [V]');
title("Porównanie 95, 105")
legend('95 Hz', '105 Hz')

