% Załaduj dane skanu CT z pliku vol.mat
ct_data = load('vol.mat');
vol = squeeze(ct_data.vol);

% Segmentacja danych CT obszary w płucach wypełnione powietrzem
rv = 2; 
[x, y, z, vol] = reducevolume(vol, [rv rv rv]);
vol = smooth3(vol, 'gaussian', 3);

I = find(vol < 200); 
vol_bin = zeros(size(vol)); 
vol_bin(I) = 1;

[vol_obj, liczba_obj] = bwlabeln(vol_bin, 26);

% Wyświetlenie pierwszego slajdu w celu interakcji użytkownika
imshow(vol_obj(:,:,1))

% Przekształcenie danych obiektu do binarnej maski
I = find(round(vol_obj) == 2);
vol_final = zeros(size(vol_obj)); 
vol_final(I) = 1;

% Załaduj dane ścieżki z pliku PTHd.mat
path_data = load('PTHd.mat');
points = path_data.PTHd;

% Przekształć punkty do formatu odpowiedniego dla funkcji scatteredInterpolant
x_path = points(:, 1);
y_path = points(:, 2);
z_path = points(:, 3);

% Odwrócenie współrzędnych ścieżki w osi X
x_path = -x_path + max(x_path) + min(x_path);

% Normalizacja danych ścieżki do zakresu danych CT
x_path = x_path - min(x_path);
y_path = y_path - min(y_path);
z_path = z_path - min(z_path);

x_path = x_path / max(x_path) * size(vol, 2);
y_path = y_path / max(y_path) * size(vol, 1);
z_path = z_path / max(z_path) * size(vol, 3);

% Użyj funkcji scatteredInterpolant do interpolacji dla każdej współrzędnej
F = scatteredInterpolant(x_path, y_path, z_path, 'natural', 'linear');

% Tworzenie drobniejszej siatki dla interpolacji
x_fine = linspace(min(x_path), max(x_path), 1000);
y_fine = linspace(min(y_path), max(y_path), 1000);

[X_fine, Y_fine] = meshgrid(x_fine, y_fine);
Z_fine = F(X_fine, Y_fine);

% Wizualizacja 3D skanu CT i interpolowanej ścieżki
figure;
hold on;

% Wizualizacja obiektu skanu CT
hiso = patch(isosurface(abs(vol_final - 1), 0), 'FaceColor', [1, .75, .65], 'EdgeColor', 'none');
axis tight; box on;
camproj p;
daspect([1 1 1]);
lighting phong;
axis off;
view([0, -45]);
camlight;
alpha(0.5);

% Wizualizacja interpolowanej ścieżki
faces = delaunay(X_fine, Y_fine);
hpath = patch('Vertices', [X_fine(:), Y_fine(:), Z_fine(:)], 'Faces', faces, ...
              'FaceColor', 'interp', 'EdgeColor', 'none', 'FaceAlpha', 0.5);

% Dodanie oryginalnych punktów ścieżki
plot3(x_path, y_path, z_path, 'bo', 'DisplayName', 'Points');

xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
title('Smoothed Curve Representing the Center of the Bronchus with CT Scan');
hold off;

% Ustawienia dla lepszej wizualizacji
axis equal;
view(3); % Ustawienie widoku 3D
rotate3d on; % Włączenie interaktywnej rotacji
