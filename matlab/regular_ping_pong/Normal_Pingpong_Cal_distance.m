
function [Rmax,Pr] = Normal_Pingpong_Cal_distance(f,Pmax, r, Pmeas)

% Opening angle
theta1 = 5;
theta2 = 5;


Pmin = 1;
Pmax = 10.^(Pmax/10); % frequency

% Conversation to wavelength
lam = 3*10^8./(f.*1e12);    % f's unit is Hz

% Radar Cross Section of Sphere
d = 0.04;            % diameter:4cm
sig_Sphere = pi*(d/2)^2;

% Directivity
G = 32400 / (theta1 * theta2);

% Received Power
Pr = (Pmax*G.^2.*lam.^2.*sig_Sphere)./((4*pi).^3*r.^4); % w
PrdB_Sphere = 10*log10(Pr);  % dB
% PrdB = 10*log10(Pr./max(Pr));

%figure
hold on
plot(f, PrdB_Sphere-max(PrdB_Sphere)+max(Pmeas),'x')
% xlabel('Frequency[THz]')
% ylabel('Nrom.Magn.[dB]')
% legend('Theoretical Maximum Distance')

% Maximum detection range
Rmax =((Pmax*G.^2.*sig_Sphere.*lam.^2)/((4*pi).^3*Pmin)).^(1/4);
end


