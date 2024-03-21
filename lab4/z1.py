import numpy as np
import matplotlib.pyplot as plt

x = np.random.random(1024)


def my_dft(x):
    N = len(x)  # Długość sygnału
    n = np.arange(N)
    k = n.reshape((N, 1))  # macierz k poprzez transpozycję wektora n.
    W = np.exp(-2j * np.pi * k * n / N)  # Oblicza macierz wag W używając formuły Eulera dla eksponensu zespolonego.
    return np.dot(W, x)  # mnożenie macierzowe między W a sygnałem x.


x_even = x[::2]
x_odd = x[1::2]

# Obliczenie DFT dla części parzystej i nieparzystej
X_even = my_dft(x_even)
X_odd = my_dft(x_odd)

N = len(x)
k = np.arange(N)
W = np.exp(-2j * np.pi * k / N)  # wektor częstotliwości W dla szybkiej transformaty Fouriera (FFT).

# Połączenie części parzystej i nieparzystej
X_fft = np.concatenate([X_even + W[:int(N/2)] * X_odd, X_even + W[int(N/2):] * X_odd])

# Obliczenie za pomocą fft
X_np_fft = np.fft.fft(x)

# Plotting
plt.subplot(2, 1, 1)
plt.plot(np.abs(X_fft), label='Custom DFT', color='blue', marker='o')
plt.plot(np.abs(X_np_fft), label='NumPy FFT', color='red', marker='s')
plt.title('Magnitude Comparison')
plt.ylim(0, 30)
plt.legend()

plt.subplot(2, 1, 2)
plt.plot(np.angle(X_fft), label='Custom DFT', color='green', marker='x')
plt.plot(np.angle(X_np_fft), label='NumPy FFT', color='orange', marker='d')
plt.title('Phase Comparison')
plt.legend()
plt.tight_layout()
plt.show()

comparison = np.allclose(X_fft, X_np_fft)
print(comparison)


x_even_even = x_even[::2]
x_even_odd = x_even[1::2]
X_even = my_dft(x_even_even)
X_odd = my_dft(x_even_odd)
N = len(x)
k = np.arange(N)
W = np.exp(-2j * np.pi * k / N / 4)
X_even_even = np.concatenate([X_even + W[:int(N/4)] * X_odd, X_even + W[:int(N/4)] * X_odd])

x_odd_even = x_odd[::2]
x_odd_odd = x_odd[1::2]
X_even = my_dft(x_odd_even)
X_odd = my_dft(x_odd_odd)
N = len(x)
k = np.arange(N)
W = np.exp(-2j * np.pi * k / N)
X_odd_odd = np.concatenate([X_even + W[:int(N/4)] * X_odd, X_even + W[:int(N/4)] * X_odd])
X_final = np.concatenate([X_even_even + W[:int(N/2)] * X_odd_odd, X_even_even + W[int(N/2):] * X_odd_odd])

comparison = np.allclose(X_fft, X_final)
print(comparison)

# Plotting
plt.subplot(2, 1, 1)
plt.plot(np.abs(X_final), label='Custom DFT', color='blue', marker='o')
plt.plot(np.abs(X_np_fft), label='NumPy FFT', color='red', marker='s')
plt.title('X_final Magnitude Comparison')
plt.ylim(0, 30)
plt.legend()

plt.subplot(2, 1, 2)
plt.plot(np.angle(X_final), label='Custom DFT', color='green', marker='x')
plt.plot(np.angle(X_np_fft), label='NumPy FFT', color='orange', marker='d')
plt.title('X_final Phase Comparison')
plt.legend()
plt.tight_layout()
plt.show()