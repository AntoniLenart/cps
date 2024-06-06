function y = dektr(sym,N,Q)
% Dekoder transformatowy
% y = dektr(sym, N, Q)
%
% sym – tablica zakodowanych symboli
% N – długość bloku próbek dla transformaty MDCT
% Q – współczynniki skalujące (jeden wspólny lub wektor indywidualnych współczynników)
% y – sygnał odtworzony

H = N/2;                        % przesunięcia kolejnych bloków
M = size(sym,2);                % liczba bloków
L = H * (M+1);                  % szacowana długość sygnału zdekodowanego
y = zeros(L,1);                 % miejsce na próbki sygnału
win = sin(pi*((0:(N-1))+0.5)/N)'; % okienko do transformaty MDCT

h_wbar = waitbar(0,'Dekodowanie ramek', 'Name', 'Kodowanie transformatowe');
for m = 0:M-1
    waitbar(m/M,h_wbar);
    Fkq = sym(:,m+1);           % odczytanie kolejnego wektora symboli
    Fkr = Fkq./Q;               % odtworzenie współczynników transformaty
    % y0 = idct4(Fkr);            % obliczenie odwrotnej transformaty
    
    mdct = zeros(H,N);
    for k=0:(N/2)-1
        for n=0:N-1
            w = sqrt(4/N)*cos((2*pi)/N*(k+0.5)*(n+0.5+N/4));
            mdct(k+1,n+1) = w;
        end
    end
    smdct = mdct.';
    y0 = smdct * Fkr;

    y0 = y0.*win;               % ponowne okienkowanie
    n0 = m*H + 1;               % początek bloku    
    y(n0:n0+N-1) = y(n0:n0+N-1)+y0; % składanie bloków na zakładkę
end
close(h_wbar);