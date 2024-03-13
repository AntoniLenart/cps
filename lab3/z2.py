import numpy as np
import matplotlib.pyplot as plt


N = 100
W_N = np.exp(1j * 2 * np.pi / N)

A = np.ones((N, N), dtype=complex) / np.sqrt(N)
for k in range(N):
    for n in range(N):
        A[k, n] = W_N ** (-k * n)

fs = 1000
t = np.arange(N) / fs
f1 = 100
f2 = 200
A1 = 100
A2 = 200
phi1 = np.pi / 7
phi2 = np.pi / 11

x_t = A1 * np.cos(2 * np.pi * f1 * t + phi1) + A2 * np.cos(2 * np.pi * f2 * t + phi2)

X = A.dot(x_t)
X_1 = X
m_zeros = np.zeros(100)
M = len(m_zeros)
x_z = np.append(x_t, m_zeros)

X_2 = np.fft.fft(x_z)/(N+M)

x_f = np.arange(0, 1000, 0.25)
X_3 = np.zeros_like(x_f)

for i, f in enumerate(x_f):
    for n in np.arange(0, N-1, 1):
        X_3[i] += x_t[n] * np.exp(-1j * 2*np.pi * n * f / fs)

frequency_axis = np.linspace(0, fs, N, endpoint=False)
magnitude = np.abs(X_1)

fig = plt.figure(figsize=(12, 6))

plt.plot(frequency_axis, magnitude, "go")
plt.title('Amplituda')
plt.xlabel('Częstotliwość (Hz)')
plt.ylabel('Amplituda')

frequency_axis = np.linspace(0, fs, N+M, endpoint=False)
magnitude = np.abs(X_2)

plt.plot(frequency_axis, magnitude, "bx")

frequency_axis = np.linspace(0, fs, len(x_f), endpoint=False)
magnitude = np.abs(X_3)

plt.plot(frequency_axis, magnitude, "k-")
plt.show()