clear all; close all; clc
% Generator wzorców cosinusowych w pętli
N = 20;
A = zeros(N,N);

for k = 1:N 
    for n = 1:N 
        if k == 0
            A(k,n) = sqrt(1/N);
        else
            A(k,n) = sqrt(2/N) * cos(pi*k*(2*n+1) / (2*N));
        end   
    end
end


% przykład obliczania iloczynu skalarnego
% w1 = A(1,:);
% w2 = A(2,:);
% w12 = w1 .* w2; 


% Sprawdzenie czy wektory w wierszach macierzy 
% są do siebie ortonormalne, czyli
% czy iloczyn skalarny wszystkich par jest równy zero. 

% Suma iloczynów odpowiadających sobie próbek:
% prod1 = sum(w12) 

B = zeros(N,N); %utworzenie macierzy B
tol = 10^(-14); %tolerancja

for l = 1:N
    w1 = A(l,:);
    for m = 1:N
        w2 = A(m,:);
        w12 = w1 .* w2;
        prod1 = sum(w12);

        % ortonormalne czyli równe 0 (bliskie 0 przez matlaba)
        % przyrównujemy je do 0
        if abs(prod1) < tol && l~=m
            prod1 = 0;
            fprintf('Para %u, %u jest ortonormalna \n', l,m);
        else 
            % na przekątnej równe 1 (bliskie 1 przez matlaba)
            % przyrównujemy je do 1
            prod1 = 1;
        end
        B(l,m) = prod1;
    end
end

% Obliczenie odwrotnej transformaty kosinusowej (IDCT)
reconstructed_A = zeros(N);
for k = 0:N-1
    for n = 0:N-1
        for i = 0:N-1
            for j = 0:N-1
                if i == 0
                    ci = sqrt(1/N);
                else
                    ci = sqrt(2/N);
                end
                if j == 0
                    cj = sqrt(1/N);
                else
                    cj = sqrt(2/N);
                end
                reconstructed_A(k+1, n+1) = reconstructed_A(k+1, n+1) + ci * cj * A(i+1, j+1) * cos((pi * i * (2 * k + 1)) / (2 * N)) * cos((pi * j * (2 * n + 1)) / (2 * N));
            end
        end
    end
end

% Obliczenie błędu
error = norm(A - reconstructed_A);
disp(['Błąd: ', num2str(error)]);

