% cps_13_aac.m
% Podstawy kodera audio AAC z uzyciem nakladkowej transformacji MDCT
clear all; close all;

Nmany = 5000;                % liczba przetwarzanych ramek sygnalu audio
% N = 2048;                   % teraz uzywamy tylko jednej dlugosci okna, sa dwie 256 i 2048
N= 32;  %idk po co ale 32
% N = 128;
M = N/2;                    % przesuniecie okna 50% 
Nx = N+M*(Nmany-1);         % liczba przetwarzanych probek sygnalu audio

% Sygnal wejsciowy
[x, fpr ] = audioread('DontWorryBeHappy.wav'); size(x),   % rzeczywisty wczytany
% fpr=44100; x=0.3*randn(Nx,1);                          % syntetyczny szum
% fpr=44100; x = 0.5*sin(2*pi*200/fpr*(0:Nx-1)');        % syntetyczny sinus
x = x(1:Nx,1);                                           % wez tylko poczatek  
% soundsc(x,fpr);                                          % odegraj
figure; plot(x);                                  % pokaz

% Macierze transformacji MDCT oraz IMDCT o wymiarach M=N/2 x N
win = sin(pi*((0:N-1)'+0.5)/N);    % pionowe okno do wycinania fragmentu sygnalu
k = 0:N/2-1; n=0:N-1;              % wiersze-czestotliwosci, kolumny-probki
C = sqrt(2/M)*cos(pi/M*(k'+1/2).*(n+1/2+M/2)); % macierz C (N/2)xN analizy MDCT
D = C'; % transpozycja                         % macierz D Nx(N/2)syntezy IMDCT

% Analiza-synteza AAC
y = zeros(Nx,1); sb = zeros(Nmany,M);               % sygnal wyjsciowy
for k=1:Nmany                                       % PETLA ANALIZY SYGNALU - RAMKI AUDIO
    n = 1+(k-1)*M  : N + (k-1)*M;                   % numery probek fragmentu od-do
    bx = x( n ) .* win;                             % pobranie probek do bufora .* okno
    BX = C*bx;                                      % MDCT
    % plot(BX); title('Samples in bands');          % wydruk wspolczynnikow MDCT (podpasma)
    % BX(N/4+1:N/2,1) = zeros(N/4,1);               % jakies dodatkowe przetwarzanie
    % by = D*BX;                                    % IMDCT 
    % y( n ) = y( n ) + by.*win;                    % .* okno, dodanie probek do poprzedniej ramki
    sb(k,1:M) = BX';                                % ew. zapamietanie do pozniejszej kwantyzacji
end                                                 % KONIEC PETLI 

sbmax = max( abs(sb) );                         % znajdz maksima
sc = 2^19;                                      %Q dla 32 ~18 zeby byla bezstratna, dla 128 ~ 19/20 idk
% sc = 2^(nextpow2(64000)-1);
sb = sbmax .* fix( sc .* (sb./sbmax) ) ./ sc;   % skwantuj

y = zeros(Nx,1);                                % sygnal wyjsciowy
for k=1:Nmany                                   % PETLA SYNTEZY SYGNALU
    n = 1+(k-1)*M  : N + (k-1)*M;               % numery probek od do
    BX = sb(k,1:M)';                            % odtworzenie podpasm
    by = D*BX;                                  % IMDCT
    y( n ) = y( n ) + by .* win;                % rekonstrukcja sygnalu z oknem
end                                             % KONIEC PETLI

n = 1:Nx;
soundsc(y,fpr);                                                     % odsluchaj
figure; plot(n,x,'ro',n,y,'bx'); title('Input (o), Output (x)');    % porownaj
m=M+1:Nx-M;                                                         % indeksy probek
max_abs_error = max(abs(y(m)-x(m))),                                % blad

