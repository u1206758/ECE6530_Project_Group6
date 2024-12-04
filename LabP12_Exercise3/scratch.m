%% Frequency Response of FIR Filters: Lab P-12: 3 Lab Exercise

% Generate bandpass filter with w = 0.44pi

L = 10;
wc = pi/2;
n = [0:L];
filt = 2/L*cos(wc*n);
w=-pi:pi/100:pi;
H=freqz(filt,1,201);

plot(w,abs(H), 'LineWidth',2)
title('\omega=\pi/2,    L=10')
xlim([-pi pi])
xticks([-pi:pi/4:pi])
xticklabels({'-\pi', '-\3pi/4', '-\pi/2', '-\pi/4', '0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
xlabel('Frequency (Rad)')
ylabel('Amplitude')

figure
L = 50;
wc = pi/2;
n = [0:L];
filt = 2/L*cos(wc*n);
w=-pi:pi/100:pi;
H=freqz(filt,1,201);

plot(w,abs(H), 'LineWidth', 2)
title('\omega=\pi/2,    L=50')
xlim([-pi pi])
xticks([-pi:pi/4:pi])
xticklabels({'-\pi', '-\3pi/4', '-\pi/2', '-\pi/4', '0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
xlabel('Frequency (Rad)')
ylabel('Amplitude')

figure
b = [1 -2*cos(pi/2) 1];
H=freqz(b,1,201);
plot(w,abs(H), 'LineWidth', 2)
title('\omega=\pi/2')
xlim([-pi pi])
xticks([-pi:pi/4:pi])
xticklabels({'-\pi', '-\3pi/4', '-\pi/2', '-\pi/4', '0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
xlabel('Frequency (Rad)')
ylabel('Amplitude')

