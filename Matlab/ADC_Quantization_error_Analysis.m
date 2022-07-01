% SCRIPT - ADC Quantization error analysis
% v1.0

% ----------Config ADC---------- % 
Nbits = 12;
Vref = 3.3;
LSB = Vref/(2^Nbits);

% ----------Signals to be sampled---------- %
f1 = 50*10^3 ;  % Signal freq of 50kHz
Vcc1 = 1.65;  
A1 = 0.4;   % Sin amplitude
y1 = @(t) Vcc1 + A1*sin(2*pi*f1*t) ;    % Sinusoidal signal example with Vcc value !=0

% ----------Sampling interval---------- %
fs = 2*10^6 ; % Sampling freq of 1MHz
t1 = 0 ;
t2 = 2/f1 ;  % Sampling 2 periods of y1
Ts = 1/fs ;
t = [t1:Ts:t2];

% ----------Sampled signal---------- %
Y = y1(t);

% ----------Quantized signal---------- %
partition = 0+LSB/2:LSB/2:Vref;     % Under this intervals, the signal is quantized
codebook = 0:LSB/2:Vref;            % rounding down (floor)
[ind,qY] = quantiz(Y,partition,codebook);  % Obtention of quantized signal (qY)

% ----------Quantization error sequence---------- %
EqY = Y - qY;  % Discrete sequence: quantiz. error

% ----------Circular Cross-correlation of input signal(y1) and Quantiz. err. sequence (qy1) ---------- %
C_Y_EqY = ifft(fft(Y.*conj(fft(qY))));

% ----------Plotting---------- %
figure
subplot(3,1,1)
plot(t, Y,'x')
hold on;

plot(t,qY,'o')
title('Sampled and quantized signal')
xlabel('Time (t)')
ylabel('Amplitude')
legend('Original sampled signal','Quantized signal');
xlim([0 t2])
grid

subplot(3,1,2)
plot(t,EqY,'o')
title('Quantization error amplitude')
xlabel('Time (t)')
ylabel('EqY(t)')
axis([0 t2 min(EqY) max(EqY)])
grid

subplot(3,1,3)
plot(t(2:end),C_Y_EqY(2:end),'o')
title('Circular Cross-correlation of input signal(y1) and Quantiz. err. sequence (qy1) ')
xlabel('Time (t)')
ylabel('C_Y_EqY(t)')
grid