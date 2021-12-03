fs = 1000;
t = 0:1/fs:2;
y = sin(128*pi*t) + sin(256*pi*t);      

figure;
win_sz = 128;
han_win = hanning(win_sz);      % Ñ¡Ôñº£Ã÷´°

nfft = win_sz;
nooverlap = win_sz - 1;
[S, F, T] = spectrogram(y, window, nooverlap, nfft, fs);

imagesc(T, F, log10(abs(S)));
set(gca, 'YDir', 'normal');
xlabel('Time (secs)');
ylabel('Freq (Hz)');
title('short time fourier transform spectrum');