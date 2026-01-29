# QAM Modulation and Message Enconding in Scilab
Physics/Electronics Engineering project on QAM modulation and digital data transmission. Includes RRC filtering, IQ constellation analysis, FFT-based spectral analysis, and noise evaluation, implemented in Scilab to apply core Signals and Systems concepts in a real telecom scenario. This project implements a digital communication system based on **Quadrature Amplitude Modulation (QAM)** using **Scilab**. The system simulates the complete signal processing chain, from message encoding to transmission over noisy channels and subsequent recovery.

## 📋 Overview
The main objective of this project is to implement the theoretical-practical concepts of the "Signals and Systems" course. It demonstrates how a text message (e.g., "Egun on") is converted into a digital signal, transmitted, and decoded back into its original form.

## 🛠️ Key Features
* **16-QAM Modulation:** Uses a square constellation where each symbol represents 4 bits, mapping hexadecimal values to specific coordinates (I, Q).
* **Signal Processing:** * **Upsampling:** Expanding the spectrum to prepare the signal for modulation.
    * **Root-Raised-Cosine (RRC) Filtering:** Implemented to limit bandwidth and minimize Inter-Symbol Interference (ISI).
* **Transmission Simulation:**
    * **Ideal Channel:** Noise-free transmission to verify system logic.
    * **Noisy Channel:** Real-world simulation using **Additive White Gaussian Noise (AWGN)**.
* **Message Recovery:** Full demodulation process, including synchronization and amplitude adjustment to restore the original ASCII message.

## 🚀 How it Works
1.  **Source Coding:** Input string $\rightarrow$ ASCII $\rightarrow$ Hexadecimal $\rightarrow$ 16-QAM Mapping.
2.  **Filtering:** The I (In-phase) and Q (Quadrature) signals are upsampled and passed through an RRC filter.
3.  **Modulation:** Both signals are combined into a carrier signal $s(t)$ at a specific frequency $f_o$:
    $$s(t) = I(t) \cdot \cos(2\pi f_o t) - Q(t) \cdot \sin(2\pi f_o t)$$
4.  **Demodulation:** The receiver separates the I and Q components using low-pass filtering and downsampling to retrieve the original symbols.

## 💻 Technologies Used
* **Scilab:** Scientific software for numerical computation.
* **Core Logic:** Custom functions for mapping (`hex2IQ`), modulation, and RRC pulse shaping.

## 📈 Results
The implementation confirms that in an ideal channel, the message is recovered with 100% accuracy. The project also demonstrates how filtering significantly improves signal integrity in noisy environments.

## 👥 Authors
* **Andoni Vazquez Arza**
* **Beñat Arberas Larrinaga**
