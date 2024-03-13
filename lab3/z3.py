import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import windows

# Dane
N = 100  # liczba probek
fs = 1000  # czestotliwosc probkowania
st = 1/fs  # krok próbkowania
T = 0.1  # czas trwania probkowania (100 probek dla 1000Hz = 0.1s)

sample = np.arange(0, T, st)  # przedział czasowy próbkowania

# Częstotliwości
f1 = 100
f2 = 125

# Amplitudy
A1 = 1
A2 = 0.0001

# Kąty fazowe
p1 = (np.pi/7)
p2 = (np.pi/11)

# Tworzenie sygnału z sumy sinusów
s1 = lambda t: A1 * np.cos(2*np.pi*f1*t + p1)
s2 = lambda t: A2 * np.cos(2*np.pi*f2*t + p2)

# Sygnał x z sumy sinusów
x = s1(sample) + s2(sample)

# Obliczanie DtFT
f = np.linspace(0, fs, N)
X = np.zeros(len(f), dtype=complex)

for fi in range(len(f)):
    for n in range(N):
        X[fi] += x[n] * np.exp(-1j*2*np.pi*f[fi]*n/fs)
X /= N

# Rysowanie widma y sygnału x
XRe = X.real  # część rzeczywista
XIm = X.imag  # część urojona
XA = np.abs(X)  # moduł
XP = np.angle(X)  # faza

# Skalowanie osi częstotliwości w Herzach

plt.figure(4)
plt.subplot(2, 1, 1)
plt.plot(f, XRe, 'b-')
plt.title('Re')
plt.xlabel('Częstotliwość [Hz]')

plt.subplot(2, 1, 2)
plt.plot(f, XIm, 'r-')
plt.title('Im')
plt.xlabel('Częstotliwość [Hz]')

plt.figure(5)
plt.subplot(2, 1, 1)
plt.plot(f, XA, 'b-')
plt.title('A')
plt.xlabel('Częstotliwość [Hz]')

plt.subplot(2, 1, 2)
plt.stem(f, XP, 'r-')
plt.title('ϕ')
plt.xlabel('Częstotliwość [Hz]')

# Okna
xbox = np.multiply(np.sinc(sample), x)
Xbox = np.zeros(len(f))

xham = np.multiply(np.hamming(N), x)
Xham = np.zeros(len(f))

xbla = np.multiply(np.blackman(N), x)
Xbla = np.zeros(len(f))

xche = np.multiply(windows.chebwin(N, 100), x)
Xche = np.zeros(len(f))

xche2 = np.multiply(windows.chebwin(N, 120), x)
Xche2 = np.zeros(len(f))

for fre in range(len(f)):
    for j in range(N):
        Xbox[fre] += (1/N) * xbox[j] * np.exp(-1j*2*np.pi*f[fre]*j/fs)
        Xham[fre] += (1/N) * xham[j] * np.exp(-1j*2*np.pi*f[fre]*j/fs)
        Xbla[fre] += (1/N) * xbla[j] * np.exp(-1j*2*np.pi*f[fre]*j/fs)
        Xche[fre] += (1/N) * xche[j] * np.exp(-1j*2*np.pi*f[fre]*j/fs)
        Xche2[fre] += (1/N) * xche2[j] * np.exp(-1j*2*np.pi*f[fre]*j/fs)

plt.figure(6)
plt.plot(f, np.abs(Xbox), "b-", f, np.abs(Xham), "r-", f, np.abs(Xbla), "k-", f, np.abs(Xche), "g-", f, np.abs(Xche2), "m-")
plt.legend(['Prostokątne', 'Hamminga', 'Blackmana', 'Czebyszewa 100 dB', 'Czebyszewa 120 dB'])

# # Wykresy okien
# plt.figure(7)
# plt.title('Okna')
# plt.plot(f, np.sinc(sample), 'b-')
# plt.plot(f, np.hamming(N), 'r-')
# plt.plot(f, np.blackman(N), 'k-')
# plt.plot(f, windows.chebwin(N, 100), 'g-')
# plt.plot(f, windows.chebwin(N, 120), 'm-')
# plt.legend(['Prostokątne', 'Hamminga', 'Blackmana', 'Czebyszewa 100', 'Czebyszewa 120'])

plt.show()
