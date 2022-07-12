% SCRIPT - Lock-in algorithm processing %

% ----------Configurable simulation parameters---------- % 
ALPHA = single(0.99);
ALPHAd = 0.99;

CTE = 4096/3.3;
%CTE = 1;

RUIDO = 1;
Nr= 8;  %Nro bits de ruido (LSB)

esc = 1;    %cte escalamiento

deg_Zbio = 0;
sim_phase = deg_Zbio*pi/180;

% ----------Zbio---------- % 
Zbio = 200;

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

if RUIDO
    y1 = @(t) Vcc1 + A1*sin(2*pi*f1*t) + rand(1,length(t))*(Nr*LSB);    % Sinusoidal signal example
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

% ----------Lock-in demodulation---------- %

c_s = single(cos(2*pi*f1*t + sim_phase)) ;  
s_s = single(sin(2*pi*f1*t)) ;

c_d = single(cos(2*pi*f1*t + sim_phase)) ;  
s_d = single(sin(2*pi*f1*t)) ;

if esc~=1
    qUdif_Xs = esc*qUdif.*s_s;
    qUdif_Ys = esc*qUdif.*c_s;

    qI_Xs = esc*qI.*s_s;
    qI_Ys = esc*qI.*c_s;
    
    qUdif_Xd = esc*qUdif.*s_d;
    qUdif_Yd = esc*qUdif.*c_d;

    qI_Xd = esc*qI.*s_d;
    qI_Yd = esc*qI.*c_d;
else
    qUdif_Xs = qUdif.*s_s;
    qUdif_Ys = qUdif.*c_s;

    qI_Xs = qI.*s_s;
    qI_Ys = qI.*c_s;
    
    qUdif_Xd = qUdif.*s_d;
    qUdif_Yd = qUdif.*c_d;

    qI_Xd = qI.*s_d;
    qI_Yd = qI.*c_d;
end

% ---------- Comparing discrete difference equation of IIR filter: float vs double ---------- %

%FLOAT implementation:%
acc1 = single(zeros(3,length(qUdif_Xs))); acc2 = single(zeros(3,length(qUdif_Xs)));
acc3 = single(zeros(3,length(qUdif_Xs))); acc4 = single(zeros(3,length(qUdif_Xs)));
ac1_1 = single(0); ac2_1 = single(0); ac3_1 = single(0);
ac1_2 = single(0); ac2_2 = single(0); ac3_2 = single(0);
ac1_3 = single(0); ac2_3 = single(0); ac3_3 = single(0);
ac4_1 = single(0); ac4_2 = single(0); ac4_3 = single(0);
for i = 1:length(qUdif_Xs)
    ac1_1 = qUdif_Xs(i)*(CTE)*(1-ALPHA)+ac1_1*ALPHA;
    acc1(1,i) = ac1_1;
    ac1_2 = ac1_1*(1-ALPHA)+ac1_2*ALPHA;
    acc1(2,i) = ac1_2;
    ac1_3 = ac1_2*(1-ALPHA)+ac1_3*ALPHA;
    acc1(3,i) = ac1_3;
    
    ac2_1 = qI_Xs(i)*(CTE)*(1-ALPHA)+ac2_1*ALPHA;
    acc2(1,i) = ac2_1;
    ac2_2 = ac2_1*(1-ALPHA)+ac2_2*ALPHA;
    acc2(2,i) = ac2_2;
    ac2_3 = ac2_2*(1-ALPHA)+ac2_3*ALPHA;
    acc2(3,i) = ac2_3;
    
    ac3_1 = (qUdif_Ys(i))*(CTE)*(1-ALPHA)+ac3_1*ALPHA;
    acc3(1,i) = ac3_1;
    ac3_2 = ac3_1*(1-ALPHA)+ac3_2*ALPHA;
    acc3(2,i) = ac3_2;
    ac3_3 = ac3_2*(1-ALPHA)+ac3_3*ALPHA;
    acc3(3,i) = ac3_3;
    
    ac4_1 = (qI_Ys(i))*(CTE)*(1-ALPHA)+ac4_1*ALPHA;
    acc4(1,i) = ac4_1;
    ac4_2 = ac4_1*(1-ALPHA)+ac4_2*ALPHA;
    acc4(2,i) = ac4_2;
    ac4_3 = ac4_2*(1-ALPHA)+ac4_3*ALPHA;
    acc4(3,i) = ac4_3;
end

X_Us = ac1_3/(CTE*2*esc*Ad);
Y_Us = ac3_3/(CTE*2*esc*Ad);
X_Is = ac2_3/(CTE*esc*1000);
Y_Is = ac4_3/(CTE*esc*1000);

MOD_zbio_lockin_s = (sqrt(X_Us^2+Y_Us^2)/sqrt(X_Is^2+Y_Is^2)) ;

PH_zbio_lockin_s = atand(Y_Us/X_Us) - atand(Y_Is/X_Is);

%DOUBLE implementation:%
acc1d = zeros(3,length(qUdif_Xd)); acc2d = zeros(3,length(qUdif_Xd));
acc3d = zeros(3,length(qUdif_Xd)); acc4d = zeros(3,length(qUdif_Xd));
ac1_1d = 0; ac2_1d = 0; ac3_1d = 0; ac4_1d = 0;
ac1_2d = 0; ac2_2d = 0; ac3_2d = 0; ac4_2d = 0;
ac1_3d = 0; ac2_3d = 0; ac3_3d = 0; ac4_3d = 0;
for i = 1:length(qUdif_Xs)
    ac1_1d = (qUdif_Xd(i)*(CTE))*(1-ALPHAd)+ac1_1d*ALPHAd;
    acc1d(1,i) = ac1_1d;
    ac1_2d = ac1_1d*(1-ALPHAd)+ac1_2d*ALPHAd;
    acc1d(2,i) = ac1_2d;
    ac1_3d = ac1_2d*(1-ALPHAd)+ac1_3d*ALPHAd;
    acc1d(3,i) = ac1_3d;
    
    ac2_1d = (qI_Xd(i))*(CTE)*(1-ALPHAd)+ac2_1d*ALPHAd;
    acc2d(1,i) = ac2_1d;
    ac2_2d = ac2_1d*(1-ALPHAd)+ac2_2d*ALPHAd;
    acc2d(2,i) = ac2_2d;
    ac2_3d = ac2_2d*(1-ALPHAd)+ac2_3d*ALPHAd;
    acc2d(3,i) = ac2_3d;
    
    ac3_1d = (qUdif_Yd(i))*(CTE)*(1-ALPHAd)+ac3_1d*ALPHAd;
    acc3d(1,i) = ac3_1d;
    ac3_2d = ac3_1d*(1-ALPHAd)+ac3_2d*ALPHAd;
    acc3d(2,i) = ac3_2d;
    ac3_3d = ac3_2d*(1-ALPHAd)+ac3_3d*ALPHAd;
    acc3d(3,i) = ac3_3d;
    
    ac4_1d = (qI_Yd(i))*(CTE)*(1-ALPHAd)+ac4_1d*ALPHAd;
    acc4d(1,i) = ac4_1d;
    ac4_2d = ac4_1d*(1-ALPHAd)+ac4_2d*ALPHAd;
    acc4d(2,i) = ac4_2d;
    ac4_3d = ac4_2d*(1-ALPHAd)+ac4_3d*ALPHAd;
    acc4d(3,i) = ac4_3d;
end

X_Ud = ac1_3d/(CTE*2*esc*Ad);
Y_Ud = ac3_3d/(CTE*2*esc*Ad);
X_Id = ac2_3d/(CTE*esc*1000);
Y_Id = ac4_3d/(CTE*esc*1000);

MOD_zbio_lockin_d = (sqrt(X_Ud^2+Y_Ud^2)/sqrt(X_Id^2+Y_Id^2)) ;

PH_zbio_lockin_d = atand(Y_Ud/X_Ud) - atand(Y_Id/X_Id);

% -----------------------------Plotting------------------------------- %

