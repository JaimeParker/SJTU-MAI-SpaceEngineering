clear, clc;
% create sin signal
f = 2;
Fs = 10;              % Sampling frequency                    
t = 0 : 0.01 : 9.99;
ts = 0 : 0.05 : 9.95;
ft = sin(2 * pi * f * t);

% add gussian noise
ft_noise = ft + randn(1, 1000);
figure(1);
plot(t, ft_noise), grid on, hold on;
xlabel('t/s'), ylabel('amplitude');
xlim([0 4]), ylim([-3 3]);
title('signal with gaussian noise');

% sample
ft_noise_sample = ft_noise(1:5:end);
stem(ts, ft_noise_sample);

% fft
figure(2);
fft_ft_noise_sample = fft(ft_noise_sample);
L_sample = 200;
P2 = abs(fft_ft_noise_sample / L_sample);
P1 = P2(1 : L_sample / 2 + 1);
P1(2:end-1) = 2*P1(2:end-1);
f_show = Fs * (0 : (L_sample / 2)) / L_sample;
plot(f_show,P1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
