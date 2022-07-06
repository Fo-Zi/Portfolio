% SCRIPT - IIR filtering analysis %

fs = 1*10^6;
%z = tf('z',ts);
ALPHA = single(0.9999);
%Hi = (1-ALPHA)/(1-ALPHA*(z^-1));

b = 1- ALPHA;
a1 = [1 -ALPHA];
a2 = [1 -ALPHA];
a3 = [1 -ALPHA]; 
a = conv(a3,conv(a1,a2));

c = ALPHA;
d1 = [1 -(1-ALPHA)];
d2 = [1 -(1-ALPHA)];
d3 = [1 -(1-ALPHA)]; 
d = conv(a3,conv(a1,a2));

n=1000;
[h1,w1] = freqz(b,a,n,fs);
[h2,w2] = freqz(c,d,n,fs);

figure(1)
subplot(2,1,1)
plot(w1,20*log10(abs(h1)))
hold on
grid
ax = gca;
ax.YLim = [-100 40];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')

subplot(2,1,2)
plot(w2,20*log10(abs(h2)))
grid
ax = gca;
ax.YLim = [-100 40];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')