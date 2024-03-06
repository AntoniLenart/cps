clear all; close all; clc
load("adsl_x.mat");
idx = [];
r_val = [];
x = reshape(x, 1, []);

%idx wartosci

for i=1:2017 %2049 probek - 32 prefiksowych
    prefix = x(i:i+31); %bierzemy 32 probki po kolei z sygnału
    prefix = reshape(prefix, 1, []);
    corr_prefix = xcorr(prefix,prefix); %jaka jest wartosc korelacji prefiksa - jak prefiks trafi sam na siebie to tego szukamy
    max_val_pref = round(max(corr_prefix),5); %jak jest max to prefiks trafia na siebie - wartosc ktorej szukamy

    r = xcorr(x,prefix);
    r = round(r,5);
    max_val_r = round(max(r),5); %wyciagamy maxa
    prefix_index = find(r==max_val_pref); %patrzymy na index, czy max wartosc sie znajduje
    prefix_index = abs(prefix_index - length(x))+1; 
    
    if length(prefix_index)~=1
        find(r==max_val_pref),
        idx = [idx,prefix_index];
    end
end