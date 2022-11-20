f = 2;
Fs = 10;
t = 0:0.01:10;
ts = 0:0.1:10;
ft = sin(2*pi*f*t);

% plot(t, ft), grid on, hold on;
% xlabel('t/s'), ylabel('amplitude');
% xlim([0 4]), ylim([-3 3]);
% title('Original signal');

noiseVar = 1;
n = sqrt(noiseVar)*randn(1,length(ft));
ftn = n + ft;
figure();
plot(t,ft,t, ftn), grid on;
xlabel('t/s'), ylabel('amplitude');
xlim([0 4]), ylim([-3 3]);
legend('Original signal','Original signal with Noise');
title('signal with gaussian noise');

% ftn = ft;
%sample
ftns = ftn(1:10:end);

vpp = max(ftn)-min(ftn);
%for 2-bit qua
step2 = 2/3;
partition = [-step2,0,step2];
codebook = [-1,-1/3,1/3,1];
[index,quants2] = quantiz(ftns,partition,codebook);
figure();
plot(ts,ftns,'x',ts,quants2,'o');grid on
title("Original signal VS 2-bit Quantized signal")
legend('Original signal','Quantized signal');
axis([-.2 5 -1.2 1.2])

% t = [0:.1:2*pi]; % Times at which to sample the sine function
% sig = sin(t); % Original signal, a sine wave
% partition = [-1:.2:1]; % Length 11, to represent 12 intervals
% codebook = [-1.2:.2:1]; % Length 12, one entry for each interval
% [index,quants] = quantiz(sig,partition,codebook); % Quantize.
% plot(t,sig,'x',t,quants,'.')
% legend('Original signal','Quantized signal');
% axis([-.2 7 -1.2 1.2])

%for 1-bit - qua

partition = [0];
codebook = [-1,1];
[index,quants1] = quantiz(ftns,partition,codebook);
figure();
plot(ts,ftns,'x',ts,quants1,'o');grid on
title("Original signal VS 1-bit Quantized signal")
legend('Original signal','Quantized signal');
axis([-.2 5 -1.2 1.2])

% for 1-bit - fft
Y1 = fft(quants1);
L = length(ts);
P2 = abs(Y1/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
figure()
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of 1-bit")
xlabel("f (Hz)")
ylabel("|P1(f)|")
% actualSNR = 20*log10(norm(signal)/norm(x - signal));
% for 2-bit - fft
Y2 = fft(quants2);
L = length(ts);
P2 = abs(Y2/L);
P22 = P2(1:L/2+1);
P22(2:end-1) = 2*P22(2:end-1);

f = Fs*(0:(L/2))/L;
figure()
plot(f,P22) 
title("Single-Sided Amplitude Spectrum of 2-bit")
xlabel("f (Hz)")
ylabel("|P22(f)|")

[M,I] = max(P1);
Ptemp = P1;
Ptemp(I) = 0;
actualSNR = 20*log10(norm(M)/norm(Ptemp));
disp(['1-bit-SNR = ',num2str(actualSNR),'  dB']) 


[M,I] = max(P22);
Ptemp = P22;
Ptemp(I) = 0;
actualSNR = 20*log10(norm(M)/norm(Ptemp));
disp(['2-bit-SNR = ',num2str(actualSNR),'  dB']) 



