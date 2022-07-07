% SCRIPT - IIR filtering analysis %
% v1.0

% ---------- Reference constants ---------- %
fs = 1*10^6;
ALPHA = single(0.1);

% ---------- 1st order IIR filter ---------- %
a = [1 -(1-ALPHA)];

% ---------- 2nd order IIR filter -> 2 cascaded single pole IIR ---------- %
b1 = [1 -(1-ALPHA)];
b2 = [1 -(1-ALPHA)];
b = conv(b1,b2);

% ---------- 3rd order IIR filter -> 3 cascaded single pole IIR ---------- %
c1 = [1 -(1-ALPHA)];
c2 = [1 -(1-ALPHA)];
c3 = [1 -(1-ALPHA)]; 
c = conv(c3,conv(c1,c2));

% ---------- N-th order IIR filter -> N cascaded single pole IIR ---------- %
N=5;
d = [1];
for i = 1:N
    aux = [1 -(1-ALPHA)];
    d = conv(d,aux);
end

% ---------- Freq. response of the filters ---------- %
n=1000;
[h1,f] = freqz(ALPHA,a,n,fs);
[h2,f] = freqz(ALPHA,b,n,fs);
[h3,f] = freqz(ALPHA,c,n,fs);
[h4,f] = freqz(ALPHA,d,n,fs);

% ---------- Cutoff frequencies ---------- %
%{
[c1 ind1] = min(abs(20*log10(abs(h1))+3));
[c2 ind2] = min(abs(20*log10(abs(h2))+3)); 
[c3 ind3] = min(abs(20*log10(abs(h3))+3));
%}


% ---------- Plotting ---------- %
figure(1)

subplot(2,1,1)
plot(f,20*log10(abs(h1)))
hold on
plot(f,20*log10(abs(h2)))
hold on
plot(f,20*log10(abs(h3)))
hold on
plot(f,20*log10(abs(h4)))

title('Frequency response - IIR filters')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
legend('1st order filter','2nd order filter','3rd order filter','N-th order filter');
grid

subplot(2,1,2)
plot(f,angle(h1))
hold on
plot(f,angle(h2))
hold on
plot(f,angle(h3))
hold on
plot(f,angle(h4))

xlabel('Frequency [Hz]')
ylabel('Phase [deg]')
legend('1st order filter','2nd order filter','3rd order filter','N-th order filter');
grid