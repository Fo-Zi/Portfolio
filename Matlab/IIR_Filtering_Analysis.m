% SCRIPT - IIR filtering analysis %

fs = 1*10^6;
ALPHA = single(0.7);

% 3rd order IIR filter -> 3 IIR single pole cascaded %
a1 = [1 -ALPHA];
a2 = [1 -ALPHA];
a3 = [1 -ALPHA]; 
a = conv(a3,conv(a1,a2));
b = 1- ALPHA;

% Complementary 3rd order IIR filter -> 3 IIR single pole cascaded %
d1 = [1 -(1-ALPHA)];
d2 = [1 -(1-ALPHA)];
d3 = [1 -(1-ALPHA)]; 
d = conv(a3,conv(a1,a2));
c = ALPHA;

% Complementary 1st order IIR filter %
e = [1 -(1-ALPHA)];
f = ALPHA;

n=1000;
[h1,f1] = freqz(b,a,n,fs);
[h2,f2] = freqz(c,d,n,fs);
[h3,f3] = freqz(f,e,n,fs);

[c1 ind1] = min(abs(20*log10(abs(h1))+3));
[c2 ind2] = min(abs(20*log10(abs(h2))+3)); 
[c3 ind3] = min(abs(20*log10(abs(h3))+3));

figure(1)
subplot(2,1,1)
plot(f1,20*log10(abs(h1)))
hold on
plot(f2,20*log10(abs(h2)))
title('Frequency response 3rd order IIR filter')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
legend('3rd order filter','3rd order complementary filter');
grid

subplot(2,1,2)
plot(f1,angle(h1))
hold on
plot(f2,angle(h2))
xlabel('Frequency [Hz]')
ylabel('Phase [deg]')
legend('3rd order filter','3rd order complementary filter');
grid

%{
figure(2)
subplot(2,1,1)
plot(f2,20*log10(abs(h2)))
title('Frequency response complementary 3rd order IIR filter')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
grid

subplot(2,1,2)
plot(f2,angle(h2))
xlabel('Frequency [Hz]')
ylabel('Phase [deg]')
grid
%}

figure(3)
subplot(2,1,1)
plot(f3,20*log10(abs(h3)))
title('Frequency response complementary 1st order IIR filter')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
grid

subplot(2,1,2)
plot(f3,angle(h3))
xlabel('Frequency [Hz]')
ylabel('Phase [deg]')
grid