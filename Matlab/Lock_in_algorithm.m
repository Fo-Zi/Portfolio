% SCRIPT - Lock-in algorithm processing %

% ----------Zbio---------- % 
Zbio = 50;

% ----------Config ADC de tensión---------- % 
Nbits = 12;
Vref = 3.3;
LSB = Vref/(2^Nbits);

% ----------Config ADC de corriente---------- %
Nbit_I = 12;
Uref_I = 3.3;

LSBi = Uref_I/(2^Nbit_I);
Eui = LSBi/2;

R = 1000;   % R del amplif de trans-imp

% ----------Señal del generador---------- %
f1 = 50*10^3 ;  % Signal freq of 50kHz
Vcc1 = 1.65;  
A1 = 0.5;   % Amplitude

RUIDO = 1;
if RUIDO
    y1 = @(t) Vcc1 + A1*sin(2*pi*f1*t) + rand(1,length(t))*(A1/100);    % Sinusoidal signal example
else
    y1 = @(t) Vcc1 + A1*sin(2*pi*f1*t);
end

% ----------Sampling interval---------- %
fs = 1*10^6 ; % Sampling freq of 1MHz
t1 = 0 ;
Np = 50 ;
t2 = Np/f1 ;  % Sampling Np periods of y1
Ts = 1/fs ;
t = [t1:Ts:t2];

% ----------Sampled signals---------- %
Ad=19;
Udif = (((y1(t)-Vcc1)*Zbio)/(1000+Zbio));
I = ((Udif/Zbio)*1000)+Vcc1;
L = length(t);             % Length of signal

% ----------Quantized signals---------- %
partition_dif = (-Vref)+LSB/2:LSB/2:(Vref);     % Under this intervals, the signal is quantized
codebook_dif = -Vref:LSB/2:Vref;            % rounding down (floor)
partition = 0+LSB/2:LSB/2:Vref;     % Under this intervals, the signal is quantized
codebook = 0:LSB/2:Vref;            % rounding down (floor)
[ind,qUdif] = quantiz(2.*Ad.*Udif,partition_dif,codebook_dif);  % Obtention of quantized signal (qY)
[ind,qI] = quantiz(I,partition,codebook);  % Obtention of quantized signal (qY)

% ----------Quantization error sequence---------- %
EqUdif = 2*Ad.*Udif - qUdif;  % Discrete sequence: quantiz. error
EqI = I - qI;  % Discrete sequence: quantiz. error

% ----------Single-Sided Amplitude Spectrum of Quantization errors---------- %
EqUdif_f = fft(EqUdif);
P2_dif = abs(EqUdif_f/L);
P1_dif = P2_dif(1:L/2+1);
P1_dif(1:end-1) = 2*P1_dif(1:end-1);

EqI_f = fft(EqI);
P2_I = abs(EqI_f/L);
P1_I = P2_I(1:L/2+1);
P1_I(1:end-1) = 2*P1_I(1:end-1);

f = fs*(0:(L/2))/L;

% ----------Lock-in demodulation---------- %
c = cos(2*pi*f1*t) ;  
s = sin(2*pi*f1*t) ;

esc = 1;    %cte escalamiento
if esc~=1
    qUdif_X = esc*qUdif.*s;
    qUdif_Y = esc*qUdif.*c;

    qI_X = esc*qI.*s;
    qI_Y = esc*qI.*c;
else
    qUdif_X = qUdif.*s;
    qUdif_Y = qUdif.*c;

    qI_X = qI.*s;
    qI_Y = qI.*c;
end
% ----------Single-Sided Amplitude Spectrum of Lock-in signals---------- %
qUdif_X_f = fft(qUdif_X);
P2_dif_X = abs(qUdif_X_f/L);
P1_dif_X = P2_dif_X(1:L/2+1);
P1_dif_X(1:end-1) = 2*P1_dif_X(1:end-1);

qUdif_Y_f = fft(qUdif_Y);
P2_dif_Y = abs(qUdif_Y_f/L);
P1_dif_Y = P2_dif_Y(1:L/2+1);
P1_dif_Y(1:end-1) = 2*P1_dif_Y(1:end-1);

qI_X_f = fft(qI_X);
P2_I_X = abs(qI_X_f/L);
P1_I_X = P2_I_X(1:L/2+1);
P1_I_X(1:end-1) = 2*P1_I_X(1:end-1);

qI_Y_f = fft(qI_Y);
P2_I_Y = abs(qI_Y_f/L);
P1_I_Y = P2_I_Y(1:L/2+1);
P1_I_Y(1:end-1) = 2*P1_I_Y(1:end-1);

% ---------- N-th order IIR filter -> N cascaded single pole IIR ---------- %
%fs = 1*10^6;
ALPHA = single(0.9999);
N=3;
a = [1];
for i = 1:N
    aux = [1 -ALPHA];
    a = conv(a,aux);
end

h1 = freqz((1-ALPHA)^N,a,f,fs);

% ---------- Comparing discrete difference equation of IIR filter: float vs double ---------- %

ALPHAd = 0.999999999999;
CTE = 4096/3.3;
%CTE = 1;

%FLOAT implementation:%
acc1 = single(zeros(3,length(qUdif_X)));
acc2 = single(zeros(3,length(qUdif_X)));
acc3 = single(zeros(3,length(qUdif_X)));
acc4 = single(zeros(3,length(qUdif_X)));
ac1_1 = single(0);
ac2_1 = single(0);
ac1_2 = single(0);
ac2_2 = single(0);
ac1_3 = single(0);
ac2_3 = single(0);
ac3_1 = single(0);
ac4_1 = single(0);
ac3_2 = single(0);
ac4_2 = single(0);
ac3_3 = single(0);
ac4_3 = single(0);
for i = 1:length(qUdif_X)
    ac1_1 = qUdif_X(i)*(CTE)*(1-ALPHA)+ac1_1*ALPHA;
    acc1(1,i) = ac1_1;
    ac1_2 = ac1_1*(1-ALPHA)+ac1_2*ALPHA;
    acc1(2,i) = ac1_2;
    ac1_3 = ac1_2*(1-ALPHA)+ac1_3*ALPHA;
    acc1(3,i) = ac1_3;
    
    ac2_1 = qI_X(i)*(CTE)*(1-ALPHA)+ac2_1*ALPHA;
    acc2(1,i) = ac2_1;
    ac2_2 = ac2_1*(1-ALPHA)+ac2_2*ALPHA;
    acc2(2,i) = ac2_2;
    ac2_3 = ac2_2*(1-ALPHA)+ac2_3*ALPHA;
    acc2(3,i) = ac2_3;
    
    ac3_1 = (qUdif_Y(i))*(CTE)*(1-ALPHA)+ac3_1*ALPHA;
    acc3(1,i) = ac3_1;
    ac3_2 = ac3_1*(1-ALPHA)+ac3_2*ALPHA;
    acc3(2,i) = ac1_2;
    ac3_3 = ac3_2*(1-ALPHA)+ac3_3*ALPHA;
    acc3(3,i) = ac3_3;
    
    ac4_1 = (qI_Y(i))*(CTE)*(1-ALPHA)+ac4_1*ALPHA;
    acc4(1,i) = ac4_1;
    ac4_2 = ac4_1*(1-ALPHA)+ac4_2*ALPHA;
    acc4(2,i) = ac4_2;
    ac4_3 = ac2_2*(1-ALPHA)+ac4_3*ALPHA;
    acc4(3,i) = ac4_3;
end

X_Us = ac1_3/(CTE*2*esc);
Y_Us = ac3_3/(CTE*2*esc);
X_Is = ac2_3/(CTE*esc);
Y_Is = ac4_3/(CTE*esc);

MOD_zbio_lockin_s = (sqrt(X_Us^2+Y_Us^2)/sqrt(X_Is^2+Y_Is^2)) ;
MOD_zbio_lockin_s2 = (X_Us/X_Is) ;

%DOUBLE implementation:%

acc1d = zeros(3,length(qUdif_X));
acc2d = zeros(3,length(qUdif_X));
acc3d = zeros(3,length(qUdif_X));
acc4d = zeros(3,length(qUdif_X));
ac1_1d = 0;
ac2_1d = 0;
ac1_2d = 0;
ac2_2d = 0;
ac1_3d = 0;
ac2_3d = 0;
ac3_1d = 0;
ac4_1d = 0;
ac3_2d = 0;
ac4_2d = 0;
ac3_3d = 0;
ac4_3d = 0;
for i = 1:length(qUdif_X)
    ac1_1d = (qUdif_X(i)*(CTE))*(1-ALPHAd)+ac1_1d*ALPHAd;
    acc1d(1,i) = ac1_1d;
    ac1_2d = ac1_1d*(1-ALPHAd)+ac1_2d*ALPHAd;
    acc1d(2,i) = ac1_2d;
    ac1_3d = ac1_2d*(1-ALPHAd)+ac1_3d*ALPHAd;
    acc1d(3,i) = ac1_3d;
    
    ac2_1d = (qI_X(i))*(CTE)*(1-ALPHAd)+ac2_1d*ALPHAd;
    acc2d(1,i) = ac2_1d;
    ac2_2d = ac2_1d*(1-ALPHAd)+ac2_2d*ALPHAd;
    acc2d(2,i) = ac2_2d;
    ac2_3d = ac2_2d*(1-ALPHAd)+ac2_3d*ALPHAd;
    acc2d(3,i) = ac2_3d;
    
    ac3_1d = (qUdif_Y(i))*(CTE)*(1-ALPHAd)+ac3_1d*ALPHAd;
    acc3d(1,i) = ac3_1d;
    ac3_2d = ac3_1d*(1-ALPHAd)+ac3_2d*ALPHAd;
    acc3d(2,i) = ac1_2d;
    ac3_3d = ac3_2d*(1-ALPHAd)+ac3_3d*ALPHAd;
    acc3d(3,i) = ac3_3d;
    
    ac4_1d = (qI_Y(i))*(CTE)*(1-ALPHAd)+ac4_1d*ALPHAd;
    acc4d(1,i) = ac4_1d;
    ac4_2d = ac4_1d*(1-ALPHAd)+ac4_2d*ALPHAd;
    acc4d(2,i) = ac4_2d;
    ac4_3d = ac2_2d*(1-ALPHAd)+ac4_3d*ALPHAd;
    acc4d(3,i) = ac4_3d;
end

X_Ud = ac1_3d/(CTE*2*esc);
Y_Ud = ac3_3d/(CTE*2*esc);
X_Id = ac2_3d/(CTE*esc);
Y_Id = ac4_3d/(CTE*esc);

MOD_zbio_lockin_d = (sqrt(X_Ud^2+Y_Ud^2)/sqrt(X_Id^2+Y_Id^2)) ;
MOD_zbio_lockin_d2 = (X_Ud/X_Id) ;

% -----------------------------Plotting------------------------------- %

% -----------------------------FIG1------------------------------- %
figure(1)
subplot(2,1,1)
plot(t, 2*Ad.*Udif,'x')
hold on;
plot(t,qUdif,'o')
title('Sampled and quantized differential voltage signal')
xlabel('Time (t)')
ylabel('Amplitude')
legend('Original sampled signal','Quantized signal');
xlim([0 2*(1/f1)])
grid

subplot(2,1,2)
plot(t, I,'x')
hold on;
plot(t,qI,'o')
title('Sampled and quantized current signal')
xlabel('Time (t)')
ylabel('Amplitude')
legend('Original sampled signal','Quantized signal');
xlim([0 2*(1/f1)])
grid

% -----------------------------FIG2------------------------------- %
figure(2)
subplot(2,1,1)
plot(f,20*log(P1_dif)) 
title('Single-Sided Amplitude Spectrum of Dif.Voltage Quantiz. Error')
xlabel('f (Hz)')
ylabel('P1_dif(f)[dB]')
grid

subplot(2,1,2)
plot(f,20*log(P1_I)) 
title('Single-Sided Amplitude Spectrum of Current Quantiz. Error')
xlabel('f (Hz)')
ylabel('P1_I(f)[dB]')
grid

% -----------------------------FIG3------------------------------- %
figure(3)
subplot(4,1,1)
plot(f,20*log(P1_dif_X)) 
title('Spectrum of Lock-in: qUdif_X')
xlabel('f (Hz)')
ylabel('qUdif_X(f)[dB]')
grid

subplot(4,1,2)
plot(f,20*log(P1_dif_Y)) 
title('Spectrum of Lock-in: qUdif_Y')
xlabel('f (Hz)')
ylabel('qUdif_Y(f)[dB]')
grid

subplot(4,1,3)
plot(f,20*log(P1_I_X)) 
title('Spectrum of Lock-in: qI_X')
xlabel('f (Hz)')
ylabel('qI_X(f)[dB]')
grid

subplot(4,1,4)
plot(f,20*log(P1_I_Y)) 
title('Spectrum of Lock-in: qI_Y')
xlabel('f (Hz)')
ylabel('qI_Y(f)[dB]')
grid

% -----------------------------FIG4------------------------------- %
figure(4)
subplot(4,1,1)
plot(f,20*log(h1.*P1_dif_X)) 
title('Spectrum of filtered signal qUdif_X')
xlabel('f (Hz)')
ylabel('P1_dif_X(f)[dB]')
grid

subplot(4,1,2)
plot(f,20*log(h1.*P1_dif_Y)) 
title('Spectrum of filtered signal: qUdif_Y')
xlabel('f (Hz)')
ylabel('P1_dif_Y(f)[dB]')
grid

subplot(4,1,3)
plot(f,20*log(h1.*P1_I_X)) 
title('Spectrum of filtered signal: qI_X')
xlabel('f (Hz)')
ylabel('P1_I_X(f)[dB]')
grid

subplot(4,1,4)
plot(f,20*log(h1.*P1_I_Y)) 
title('Spectrum of filtered signal: qI_Y')
xlabel('f (Hz)')
ylabel('P1_I_Y(f)[dB]')
grid
