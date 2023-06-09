import numpy as np

def generate_complex_sinusoid(A, f, phi, duration, sample_rate):
    t = np.arange(0, duration, 1/sample_rate)
    y = A * np.exp(1j * (2*np.pi*f*t + phi))
    return y

def main():
    A = 1.0         # amplitude
    f = 1.0         # frequency (Hz)
    phi = 0.0       # phase (radians)
    duration = 1.0  # duration of the waveform (seconds)
    sample_rate = 8 # sample rate (samples per second)

    waveform = generate_complex_sinusoid(A, f, phi, duration, sample_rate)

    # split into real and imaginary parts
    real_part = waveform.real
    imag_part = waveform.imag

    # convert to 16 bit
    real_part = np.int16(real_part * np.iinfo(np.int16).max)
    imag_part = np.int16(imag_part * np.iinfo(np.int16).max)

    # Combine real and imaginary parts
    combined = np.vstack((real_part, imag_part)).T

    # Write to a hex file
    with open(f"{f}hz_{A}amp_sinusoidal.txt", 'w') as f:
        for sample in combined:
            f.write(f"{sample[0]:04x} {sample[1]:04x}\n")

if __name__ == '__main__':
    main()
