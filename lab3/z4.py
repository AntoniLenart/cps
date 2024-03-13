import scipy.io
import numpy as np
import matplotlib.pyplot as plt

mat = scipy.io.loadmat('lab_03.mat')
vector_number = 417670 % 16 + 1

signal = mat['x_7']
signal.shape

K = 8
M = 32
N = 512
frames = []
for i in range(K):
    start = i*(N+M)+M
    end = (i+1)*(N+M)
    frames.append(signal[start:end])

# Wyznaczamy macierz A dla N=512 próbek
W_N = np.exp(1j * 2 * np.pi / N)

A = np.ones((N, N), dtype=complex) / np.sqrt(N)
for k in range(N):
    for n in range(N):
        A[k, n] = W_N ** (-k * n)

fs = 512
X_array = []
for frame in frames:
    X = A.dot(frame)
    X_array.append(X)

frequency_axis = np.linspace(0, fs, N, endpoint=False)
fig, ax = plt.subplots(8, 1, figsize=(12,24))
for i in range(K):
    magnitude = np.abs(X_array[i])
    ax[i].plot(frequency_axis, magnitude)
    ax[i].set_title("Ramka numer {}".format(i+1))
plt.tight_layout()
plt.show()

print([freq for freq, x in enumerate(np.abs(X_array[0])) if x > 1])