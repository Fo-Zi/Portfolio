% SCRIPT - Lock-in algorithm processing %

% ----------Configurable simulation parameters---------- % 
ALPHA = single(0.99);
ALPHAd = 0.99;
%CTE = 4096/3.3;
RUIDO = 0;  % Boolean that incorporates noise into the source signal
Noise_lvl = 0.5*10^-3; % 0,5mV 

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


% --------- Sampling interval ---------- %
f1 = 50*10^3 ;  % Signal freq of 50kHz
fs = 1*10^6 ; % Sampling freq of 1MHz
t1 = 0 ;
Np = 1 ;
t2 = Np/f1 ;  % Sampling Np periods of y1
Ts = 1/fs ;
t = [t1:Ts:t2];
% ----------Zbio---------- % 
Ad=19;
Rti = 1000;

L = length(t);             % Length of signal
partition_dif = (-Vref)+LSB/2:LSB/2:(Vref);     % Under this intervals, the signal is quantized
codebook_dif = -Vref:LSB/2:Vref;            % rounding down (floor)
partition = 0+LSB/2:LSB/2:Vref;     % Under this intervals, the signal is quantized
codebook = 0:LSB/2:Vref;            % rounding down (floor)

DeltaZbio = 10;
Zbio = 1:DeltaZbio:1000;

DeltaRdac = 20;
Rdac = 1:DeltaRdac:1000;
Rdac_optimo = zeros(1,length(Zbio));

EqUdif_rel = zeros(2,length(Rdac));
EqI_rel = zeros(1,length(Rdac));
% ----------Señal del generador---------- %

Vcc1 = 1.65;  
A1 = 0.5;   % Amplitude
if RUIDO
    y1 = @(t) Vcc1 + A1*sin(2*pi*f1*t) + rand(1,length(t))*(Noise_lvl);    % Sinusoidal signal example
else
    y1 = @(t) Vcc1 + A1*sin(2*pi*f1*t);
end

for i = 1:length(Zbio)
    for j = 1:length(Rdac)
    
    
        % ----------Sampled signals---------- %
        Udif = (((y1(t)-Vcc1)*Zbio(i))/(Rdac(1,j)+Zbio(i)));
        I = ((Udif/Zbio(i))*Rti)+Vcc1;

        % ----------Quantized signals---------- %
        [ind,qUdif] = quantiz(2.*Ad.*Udif,partition_dif,codebook_dif);  % Obtention of quantized signal (qY)
        [ind,qI] = quantiz(I,partition,codebook);  % Obtention of quantized signal (qY)

        % ----------Quantization error sequence---------- %
        EqUdif = 2*Ad.*Udif - qUdif;  % Discrete sequence: quantiz. error
        EqI = I - qI;  % Discrete sequence: quantiz. error

        U_max = Ad*A1*Zbio(i)/(Rdac(1,j)+Zbio(i));

        EqUdif_rel(1,j) = max(abs(EqUdif))/U_max;
        EqI_rel(1,j) = max(abs(EqI))/((U_max/(Ad*Zbio(i))*Rti));
        EqUdif_rel(2,j)= Rdac(j);
    end
    Sum_err_rel = abs(EqUdif_rel(1))+abs(EqI_rel);
    [EZbio_optimo,index] = min(Sum_err_rel);
    Rdac_optimo(1,j) = EqUdif_rel(2,index);
end

% -----------------------------FIG1------------------------------- %
figure(1)
plot(Zbio,Rdac_optimo,'o')
title('Zbio optimo para diferentes Rdac:')
xlabel('Rdac')
ylabel('Zbio optimo')
grid