close all
clear all
clc

load("butter.mat")

fs = 16000;
fmin = 1189;
fmax = 1229;
wmin = 2*pi*fmin;
wmax = 2*pi*fmax;

[b,a] = zp2tf(z,p,k);


[num_d, den_d] = bilinear(b, a, fs);
% Wczytanie pliku .wav
[s, fs] = audioread('s7.wav'); % Zamiast 'sX.wav' wpisz nazwę pliku, który chcesz przefiltrować

% Filtracja sygnału
filtered_signal = filter(num_d, den_d, s);

% Spektrogram przed filtracją
figure;
subplot(2,1,1);
spectrogram(s, 4096, 4096-512, [0:5:2000], fs, 'yaxis');
title('Spektrogram przed filtracją');

% Spektrogram po filtracji
subplot(2,1,2);
spectrogram(filtered_signal, 4096, 4096-512, [0:5:2000], fs, 'yaxis');
title('Spektrogram po filtracją');

% Wyświetlenie sygnałów w dziedzinie czasu
figure;
t = (0:length(s)-1)/fs;
plot(t, s, 'b', t, filtered_signal, 'r');
xlabel('Czas [s]');
ylabel('Amplituda');
legend('Przed filtracją', 'Po filtracji');
title('Sygnały w dziedzinie czasu');
