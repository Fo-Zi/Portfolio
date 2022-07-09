% SCRIPT - IIR filtering analysis %
% v1.0

%BRIEFING%
% This script analyzes the frequency response of "Exponential Moving Average"(EMA) IIR filters.  %
% With that purpose, the approach is to work with its corresponding Z transform expressions, and %
% to analyze the N-th order implementation using cascaded 1st order EMA's, as it's one of the    %
% most common implementations in embedded systems, bc it presents an efficient implementation,   %
% in terms of memory usage, execution performance and frequency response.                        %


% ---------- Reference constants ---------- %
fs = 1*10^6;            % Sampling frequency
ALPHA = single(0.99);   % Filter parameter

% The obtention of cascaded transforms is obtained by polynomial expressions and multiplications %
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
N1=3;
d = [1];
for i = 1:N1
    aux = [1 -(1-ALPHA)];
    d = conv(d,aux);
end

% ---------- N-th order "complementary" IIR filter -> N cascaded single pole IIR ---------- %
N2=3;
e = [1];
for i = 1:N2
    aux2 = [1 -ALPHA];
    e = conv(e,aux2);
end

% ---------- Freq. response of the filters ---------- %
n=1000;
[h1,f] = freqz(ALPHA,a,n,fs);
[h2,f] = freqz(ALPHA^2,b,n,fs);
[h3,f] = freqz(ALPHA^3,c,n,fs);
[h4,f] = freqz(ALPHA^N,d,n,fs);
[h5,f] = freqz((1-ALPHA)^N,e,n,fs);

% ---------- Cutoff frequencies ---------- %
% If you able this section you can obtain the -3dB frequencies %
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
hold on
plot(f,20*log10(abs(h5)))

title('Frequency response - IIR filters')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
legend('1st order filter','2nd order filter','3rd order filter','N-th order filter','N-th order complementary filter');
grid

subplot(2,1,2)
plot(f,angle(h1))
hold on
plot(f,angle(h2))
hold on
plot(f,angle(h3))
hold on
plot(f,angle(h4))
hold on
plot(f,angle(h5))

xlabel('Frequency [Hz]')
ylabel('Phase [deg]')
legend('1st order filter','2nd order filter','3rd order filter','N-th order filter','N-th order complementary filter');
grid
