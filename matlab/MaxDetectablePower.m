clear 
load('PowerReference.mat')

% t = mean(Power_ref_tf)*1e12; 
% Power_ref_amp = mean(Power_ref_xf); 
t = t*1e12; 
ts = t(2)-t(1);                        
fs = 1/(2*ts);                       
L = length(Power_ref_amp);                
fre = linspace(0,fs,L/2+1);

% Fast Fouier Transform           
Power_ref_AMP = fft(Power_ref_amp, L);
Power_ref_AMP = fftshift(abs(Power_ref_AMP));               
Power_ref_AMP = 2*Power_ref_AMP(length(Power_ref_AMP)/2:end);
Power_ref_AMP_dB = 20*log10(abs(Power_ref_AMP));
Power_ref_AMP_dB = Power_ref_AMP_dB - mean(Power_ref_AMP_dB(fre>3));
[Power_ref_pks, Power_ref_locs] = findpeaks(Power_ref_AMP_dB(fre<2),fre(fre<2),'MinPeakDistance',0.0507473); 
% [Power_ref_pks, Power_ref_locs] = findpeaks(Power_ref_AMP_dB,fre,'minpeakheight',20,'MinPeakDistance',0.050788);

Power_ref_pks = Power_ref_pks(2:end);
Power_ref_locs = Power_ref_locs(2:end);
figure
subplot(2,1,1)
plot(t, Power_ref_amp)
title('Power Reference-Time Domain')
xlabel('Time(ps)')
ylabel('Amplitude(dB)')

subplot(2,1,2)
hold on
plot(fre, Power_ref_AMP_dB)
plot(Power_ref_locs, Power_ref_pks,"x")
title('Power Reference-Frequency Domain')
grid on
hold off
xlabel('Frequency(THz)')
ylabel('Magnitude(dB)') 


