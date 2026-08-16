
function [Rmax,Pr] = Cylinder_Cal_distance(f,Pmax, r, Pmeas)

% Opening angle
theta1 = 5;
theta2 = 5;


Pmin = 1;
Pmax = 10.^(Pmax/10); % frequency

% Conversation to wavelength
lam = 3*10^8./(f.*1e12);    % f's unit is Hz

% RCS(radar cross section of cylinder)
% h = 0.4;              % height:40cm
h = tan(deg2rad(5))*r*2;
d = 0.025;            % diameter:2.5cm
sig = (pi*d*h^2)./lam;

% Directivity
G = 32400 / (theta1 * theta2);

% Received Power
Pr = (Pmax*G.^2.*lam.^2.*sig)./((4*pi).^3*r.^4); % w
PrdB = 10*log10(Pr);  % dB
% PrdB = 10*log10(Pr./max(Pr));

%figure
hold on

plot(f, PrdB-max(PrdB)+max(Pmeas),'x')  % normalized power
% xlabel('Frequency[THz]')
% ylabel('Nrom.Magn.[dB]')
% legend('Theoretical Maximum Distance')

% Maximum detection range
Rmax =((Pmax*G.^2.*sig.*lam.^2)/((4*pi).^3*Pmin)).^(1/4);
end


