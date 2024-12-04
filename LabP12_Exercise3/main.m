%% Frequency Response of FIR Filters: Lab P-12: 3 Lab Exercise

%% 3.1a)
% We will cascade these filters by convolution, which will be performed by
% multiplication of their transfer functions.
%% 
% First we'll find the transfer function of the general filter
%%
% Y(z) = X(z) - 2cos(wn)z^-1X(z) + z^-2X(z)
%%
% H(z) = 1 - 2cos(wn)z^-1 + z^-2
%%
% Now we'll introduce the nulling frequencies 0.44pi and 0.7pi
%%
% H1(z) = 1 - 2cos(0.44pi)z^-1 + z^-2
%%
% H2(z) = 1 - 2cos(0.7pi)z^-1 + z^-2
%%
% Performing the convolution
%%
% (1 - 2cos(0.44pi)z^-1 + z^-2)(1 - 2cos(0.44pi)z^-1 + z^-2)
%%
% Yields the fourth order filter
%%
% 1 + (-2cos(0.7pi) - 2cos(0.44pi)))z^-1 + (2 + 4cos(0.44pi)cos(0.7pi))z^-2
% + (-2cos(0.44pi) - 2cos(0.7pi))z^-3 + z^-4
%%
% Resulting in the following coefficients

b = [1 -2*cos(0.7*pi)-2*cos(0.44*pi) 2+4*cos(0.44*pi)*cos(0.7*pi) -2*cos(0.44*pi)-2*cos(0.7*pi) 1]

%% 3.1b)
% Generate input signal

n = [0:149];
x = 5*cos(0.3*pi*n) + 22*cos(0.44*pi*n-pi/3) + 22*cos(0.7*pi*n-pi/4);

%% 3.1c)
% Pass input through filter

y = conv(b,x);

%% 3.1d)
% Plot output signal

plot(0:39, y(1:40))
title('Output')
ylabel('y[n]')
xlabel('n')

%%
% Determine output signal by hand for n >= 5
%%
% Taking the inverse z-transform of the transfer function determined in
% part 3.1a gives the function
%%
% y[n] = x[n] + (-2cos(0.7pi) - 2cos(0.44pi))x[n-1] + (2 +
% 4cos(0.44pi)cos(0.7pi))x[n-2] + (-2cos(0.44pi) - 2cos(0.7pi))x[n-3] +
% x[n-4]
%%
% Passing the input over 5 <= n <= 40 through this function

y_hand = zeros(1,36);
for i = 1:36
  y_hand(i) = x(i+5) + (-2*cos(0.7*pi) - 2*cos(0.44*pi))*x(i+5-1) + (2 + 4*cos(0.44*pi)*cos(0.7*pi))*x(i+5-2) + (-2*cos(0.44*pi) - 2*cos(0.7*pi))*x(i+5-3) + x(i+5-4);
end

%% 3.1e)
% Plot convolved output overlayed with hand calculated output

plot(0:39, y(1:40))
hold on
stem(0:40, [zeros(1,5) y_hand])
hold off
title('Output Comparison')
ylabel('y[n]')
xlabel('n')
legend('convolved', 'hand')

%% 3.1f)
% Our input signal is defined for n >= 0 and our filter uses past input
% values back to x[n-4]. The start-up points at the beginning of the output
% are the points where those past values of x[n] are undefined by the input 
% function and assummed to be 0. The sinusoidal output seen beginning at 
% n = 5 is when the system can be properly "filled" with past x values. 
% Having 4 start-up values is consistent with cascading two 2nd order 
% filters into a 4th order filter.

clear

%% 3.2a)
% Generate bandpass filter with w = 0.44pi

L = 10;
wc = 0.44*pi;
n = [0:L];
filt = 2/L*cos(wc*n);

%%
% Measure gain at frequencies of interest using DTFT

gain1 = abs(sum(filt.*exp(-1*j*0.3*pi*n)))
gain2 = abs(sum(filt.*exp(-1*j*0.44*pi*n)))
gain3 = abs(sum(filt.*exp(-1*j*0.7*pi*n)))

%%
% As expected, the center frequency remains near its original amplitude and
% frequencies far enough above and below the center frequency have been
% attenuated significantly.

%% 3.2b)
% Plot frequency response of the filter when L = 10, 20, 40

for L = [10 20 40]
  n = [0:L];
  filt = 2/L*cos(wc*n);
  ww = -pi:pi/10000:pi;   %The number of samples here has to be quite large to find the passband limits with using a reasonable rounding
  H_mag = abs(freqz(filt,1,ww)); %Frequency response of filter
  ww = 0:pi/10000:pi;      
  H_mag = H_mag(10001:end);  %Looking at positive side of frequency response
  plot(ww, H_mag)
  xlim([0 pi])
  xticks([0:pi/4:pi])
  xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
  xlabel('Frequency (Rad)')
  ylabel('Amplitude')
  title(['L = ' num2str(L)])
  hold on
  yline(max(H_mag)*0.707)
  yline(max(H_mag)*0.25)
  legend('Frequency Response', 'Passband', 'Stopband')
  hold off
  snapnow
  
  % Find passband width

  passband_limits = find(round(H_mag,2)==round(max(H_mag)*0.707,2));
  passband_width = ww(max(passband_limits)) - ww(min(passband_limits))

end

%%
% Doubling the parameter L from 10, 20, 40 has halved the passband width
% from about 0.5, 0.26, 0.135. These values are not exact because with a 
% discrete time signal a sample may not have the exact value of the 
% threshold and we have to pick the next closest sample to be the limits of
% the passband. This verifies the property stated in the lab
% instructions, that the passband is inversely proportional to L.

%% 3.2c)
% The L = 10 filter passes frequencies at 0.44pi +/- about 0.25. As seen in
% part a), the magnitude of the frequency response at 0.44pi was near its
% full amplitude while the magnitudes at 0.3pi and 0.7pi were attenuated
% significantly.

%% 3.2d)
% Tune L to attenuate |w| <= 0.3pi and 0.7pi <= |w| <= pi by at least 90%

for L = 10:50
  n = [0:L];
  filt = 2/L*cos(wc*n);
  gain1 = abs(sum(filt.*exp(-1*j*0.3*pi*n)));
  gain2 = abs(sum(filt.*exp(-1*j*0.44*pi*n)));
  gain3 = abs(sum(filt.*exp(-1*j*0.7*pi*n)));
  if (gain1 <= 0.1) && (gain3 <= 0.1)
    break
  end
end

L
gain1
gain2
gain3
ww = -pi:pi/10000:pi;
H_mag = abs(freqz(filt,1,ww));
H_mag = H_mag(10001:end); 
passband_limits = find(round(H_mag,2)==round(max(H_mag)*0.707,2));
passband_width = ww(max(passband_limits)) - ww(min(passband_limits))


%% 3.2e)
% Pass input signal from 3.1b through filter constructed in 3.2d

n = [0:99];
x = 5*cos(0.3*pi*n) + 22*cos(0.44*pi*n-pi/3) + 22*cos(0.7*pi*n-pi/4);
y = conv(filt,x);

%% 
% Plot input, output, and isolated passband frequency sinusoid for
% comparison

subplot(3,1,1)
plot(n,x)
title('Input sum of 3 sinusoids')
xlabel('n')
ylabel('Amplitude')
subplot(3,1,2)
plot(n,y(1:100))
title('Output from filter')
xlabel('n')
ylabel('Amplitude')
subplot(3,1,3)
plot(n, 22*cos(0.44*pi*n-pi/3))
title('Isolated passband frequency sinusoid component')
xlabel('n')
ylabel('Amplitude')
snapnow

%%
% It can be seen that the filter output is identical to the isolated
% passband frequency sinusoid component after the start-up points. This is
% more apparent when comparing the frequency spectrums of the filter input 
% and output.

f = 0:pi/50:pi;
X = fft(x);
Y = fft(y(1:100));
figure
subplot(2,1,1)
plot(f, abs(X(1:51)))
title('Input')
xlim([0 pi])
xticks([0:pi/4:pi])
xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
xlabel('Frequency (Rad)')
ylabel('Amplitude')
subplot(2,1,2)
plot(f, abs(Y(1:51)))
title('Output')
xlim([0 pi])
xticks([0:pi/4:pi])
xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
xlabel('Frequency (Rad)')
ylabel('Amplitude')
  

%% 3.2f)
% Plotting frequency response of filter output again

Y = fft(y(1:100));
figure
plot(0:pi/50:pi, abs(Y(1:51)))
title('Frequency Response of Filter Output')
xlim([0 pi])
xticks([0:pi/4:pi])
xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'})
xlabel('Frequency (Rad)')
ylabel('Amplitude')
  

%%
% The amplitude of H(e^jw) corresponds to the relative size of a sinusoid
% at that frequency. It can be seen in the output from the filter where the
% signal is present mostly at 0.44pi. For some sinusoid composed of 
% components of the formx[n] = A*cos(wn) and its DFT X[k], the magnitude 
% of X[k] corresponds to the relative amplitude of x[n] and will have peaks
% at each w proportional to A.
