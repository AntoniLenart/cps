clear all; close all; clc;

t = 2*pi;
base_freq = 10;
base_period = 1/base_freq;
base_time = 0:base_period:t;
base_sig = sin(base_time);

rec_freq = base_freq * 50;
rec_period = 1/rec_freq;
rec_time = 0:rec_period:t;
rec_sig = zeros(length(rec_time), 1);

for t_interval = 1:length(rec_time)
    sum = 0;
    for sample = 1:length(base_time)
        y = pi / base_period * ((t_interval-1)*rec_period - (sample-1)*base_period);
        sinc = 1;
        if y ~= 0
            sinc = sin(y) / y;
        end
        sum = sum + base_sig(sample) * sinc;
    end
    rec_sig(t_interval) = sum;
end

plot(base_time, base_sig, 'r-', rec_time, rec_sig, 'b-')
legend('Sygnał oryginalny', 'Sygnał odtworzony')
grid on;
title('Porównanie sygnału oryginalnego i odtworzonego')