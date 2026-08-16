
load('Normal_Pingpong_@120cm.mat')

t = mean(tf_ref120)*1e12;  % s->ps
amp_ref120 = mean(xf_ref120); 
ts = t(2)-t(1);
fs = 1/(2*ts);  % THz
L = length(amp_ref120);
fre = linspace(0,fs,L/2+1);     % THz
noisemask = fre>3 & fre<4;


AMP_ref120 = fft(amp_ref120, L);
AMP_ref120 = fftshift(abs(AMP_ref120));               
AMP_ref120 = 2*AMP_ref120(length(AMP_ref120)/2:end);      
AMP_db_ref120 = 20*log10(abs(AMP_ref120));
NoiseLevel_AMP_ref120 = mean(AMP_db_ref120(noisemask));
AMP_DR_ref120 = AMP_db_ref120 - NoiseLevel_AMP_ref120;

% -------------------------120cm------------------------------
amp_120cm = mean(xf_120cm);
amp_120cm = amp_120cm - amp_ref120;


AMP_120cm = fft(amp_120cm, L);
AMP_120cm = fftshift(abs(AMP_120cm));               
AMP_120cm = 2*AMP_120cm(length(AMP_120cm)/2:end);
AMP_120cm_db = 20*log10(abs(AMP_120cm));
NoiseLevel_120cm = mean(AMP_120cm_db(noisemask));
AMP_120cm_DR_Sphere = AMP_120cm_db - NoiseLevel_120cm;
% [pks_100cm, locs_100cm]=findpeaks(AMP_100cm_db);  % ,'minpeakheight',25

figure
subplot(211)
plot(t, amp_ref120)
hold on
plot(t, amp_120cm)
% xlim([0 1.6]);
grid on
xlabel('Time[ps]')
ylabel('Amplitude')
legend('Cross-talk','Regular Ping-pong ball Reflection @ 120cm distance')

subplot(212)
plot(fre, AMP_DR_ref120)
hold on
plot(fre, AMP_120cm_DR_Sphere)
xlim([0 1.6]);
grid on
xlabel('Frequency[THz]')
ylabel('Norm. Magn.[dB]')
legend('Cross-talk','Regular Ping-pong ball Reflection @ 120cm distance')


figure
plot(fre,AMP_DR_ref120)
hold on 
plot(fre, AMP_120cm_DR_Sphere)
grid on
xlabel('Frequency[THz]')
ylabel('Norm. Magn.[dB]')
legend('Regular Pingpong @ 120cm','Reference @ 120cm')

figure
plot(fre, AMP_120cm_DR_Sphere)

load('PowerReference_PeaksNEW.mat')

distance = 1.2;
[RMax_Sphere_1m,RPower_Sphere_1m] = Normal_Pingpong_Cal_distance(Power_ref_locs, Power_ref_pks, distance, AMP_120cm_DR_Sphere);   % THz
xlim([0 1.6]);
grid on
xlabel('Frequency[THz]')
ylabel('Magn.[dB]')
legend('Regular Pingpong Reflection @ 120cm distance','Theoretical Maximum @ 120cm distance')

