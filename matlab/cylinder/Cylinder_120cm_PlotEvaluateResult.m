
load('Cylinder@120cm.mat')

t = mean(tf_ctk)*1e12;  % s->ps
amp = mean(xf_ctk); 
ts = t(2)-t(1);
fs = 1/(2*ts);  % THz
L = length(amp);
fre = linspace(0,fs,L/2+1);     % THz
noisemask = fre>3 & fre<4;


AMP = fft(amp, L);
AMP = fftshift(abs(AMP));               
AMP = 2*AMP(length(AMP)/2:end);      
AMP_db = 20*log10(abs(AMP));
NoiseLevel_AMP = mean(AMP_db(noisemask));


% -------------------------120cm------------------------------
amp_120cm = mean(xf_120cm);
amp_120cm = amp_120cm - amp;


AMP_120cm = fft(amp_120cm, L);
AMP_120cm = fftshift(abs(AMP_120cm));               
AMP_120cm = 2*AMP_120cm(length(AMP_120cm)/2:end);
AMP_120cm_db = 20*log10(abs(AMP_120cm));
NoiseLevel_120cm = mean(AMP_120cm_db(noisemask));
AMP_120cm_DR = AMP_120cm_db - NoiseLevel_120cm;
% [pks_120cm, locs_120cm]=findpeaks(AMP_120cm_db);  % ,'minpeakheight',25

figure
subplot(211)
plot(t, amp)
hold on
plot(t, amp_120cm)
% xlim([0 1.6]);
grid on
xlabel('Time[ps]')
ylabel('Amplitude')
legend('Cross-talk','Cylinder Reflection @ 120cm distance')

subplot(212)
plot(fre, AMP_db)
hold on
plot(fre, AMP_120cm_DR)
xlim([0 1.6]);
grid on
xlabel('Frequency[THz]')
ylabel('Norm. Magn.[dB]')
legend('Cross-talk','Cylinder Reflection @ 120cm distance')


figure
plot(fre, AMP_120cm_DR)
% set(gcf,'units','centimeter','outerposition',[100 100 120 100])

load('PowerReference_PeaksNEW.mat')

distance = 1.2;
[RMax_1m,RPower_1m] = Cylinder_Cal_distance(Power_ref_locs, Power_ref_pks, distance, AMP_120cm_DR);   % THz
xlim([0 1.6]);
grid on
xlabel('Frequency[THz]')
ylabel('Norm. Magn.[dB]')
legend('Cylinder Reflection @ 120cm distance','Theoretical Maximum @ 120cm distance')

