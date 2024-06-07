% Załadowanie danych z pliku vol.mat (CT) i PTHd.mat (punkty na ścieżce)
data_vol = load('vol.mat');
vol = data_vol.vol;  

data_pth = load('PTHd.mat');
pth = data_pth.PTHd; 

% Interpolacja spline'owa punktów na ścieżce
t = 1:size(pth, 1);
tq = linspace(1, size(pth, 1), 1000); % Wygenerowanie większej liczby punktów do gładkiej krzywej
spline_x = spline(t, pth(:, 1), tq);
spline_y = spline(t, pth(:, 2), tq);
spline_z = spline(t, pth(:, 3), tq);

% Wizualizacja 3D wysegmentowanych oskrzeli i wygenerowanej ścieżki
figure;
% Wyświetlenie objętości danych (powiedzmy jako izopowierzchnię dla prostoty)
% isosurface(vol, 200);  
% Wyświetlenie gładkiej linii
plot3(spline_x, spline_y, spline_z, 'r', 'LineWidth', 2);
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
axis equal
title('Ścieżka w przestrzeni 3D');
