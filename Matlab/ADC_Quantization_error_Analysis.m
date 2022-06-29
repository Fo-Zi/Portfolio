% SCRIPT - ADC Quantization error analysis
% v1.0

% ----------Config ADC---------- % 
Nbits = 12;
Vref = 3.3;
LSB = Vref/(2^Nbits);

% ----------Signals to be sampled---------- %
f1 = 50*10^3 ;
Vcc1 = 1.65;
A1 = 0.001;
y1 = @(t) Vcc1 + A1*sin(2*pi*f1*t) ;    % Sinusoidal signal example with Vcc value !=0

% ----------Sampling interval---------- %
fs = 1*10^6 ;
t1 = 0 ;
t2 = 2/f1 ;  % Sampling 2 periods of y1
Ts = 1/fs ;
t = [t1:Ts:t2];

% ----------Sampled signal---------- %
figure
subplot(3,1,1)
Y = y1(t);
plot(t, y1(t),'x')
hold on;

% ----------Quantized signal---------- %
partition = 0:LSB/2:Vref-LSB/2;
codebook = 0:LSB/2:Vref;
[ind,qy1] = quantiz(y1(t),partition,codebook);  % Obtention of quantized signal (qy1)
plot(t,qy1,'o')
title('Sampled and quantized signal')
xlabel('Time (t)')
ylabel('Amplitude')
legend('Original sampled signal','Quantized signal');
xlim([0 t2])
grid

% ----------Quantization error sequence---------- %
eq1 = y1(t) - qy1;  % Discrete sequence quantiz. error
subplot(3,1,2)
plot(t,eq1,'o')
title('Quantization error amplitude')
xlabel('Time (t)')
ylabel('eq1(t)')
axis([0 t2 min(eq1) max(eq1)])
grid

% ----------Circular Cross-correlation of input signal(y1) and Quantiz. err. sequence (qy1) ---------- %
circcorr_xy = ifft(fft(y1(t).*conj(fft(qy1))));
subplot(3,1,3)
plot(t(2:end),circcorr_xy(2:end),'o')
title('Circular Cross-correlation of input signal(y1) and Quantiz. err. sequence (qy1) ')
xlabel('t')
ylabel('circcorr_xy(t)')

grid
