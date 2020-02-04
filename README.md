# Noise adder for Speech Commands

The "noiseAdder" tool allows adding noise to different databases. For this case, we give the example of the database "Speech Comands" [1], sampling rate of 16 kHz. With the tool it is possible to configure the signal-to-noise ratio (SNR) interval.

Additive noises:

* White, matlab code
* Color [2]
* Babble [3]
* Fan, recorded audio

For all cases, the .wav files must be copied to the subfolders ("backward","forward", etc). In the case babble noise, the recorded .wav has a sampling frequency of 8 kHz, so an interpolation method is proposed.

### References
[1] Warden, P. (2018). Speech commands: A dataset for limited-vocabulary speech recognition. arXiv preprint arXiv:1804.03209.

[2] Zhivomirov, H., & Baranski, P. (2017). Pink, red, blue and violet noise generation with matlab implementation. Natick, MA: MathWorks.

[3] Habets, E. A., Cohen, I., & Gannot, S. (2008). Generating nonstationary multisensor signals under a spatial coherence constraint. The Journal of the Acoustical Society of America, 124(5), 2911-2917.




