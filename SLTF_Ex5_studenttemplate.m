%% Example code for calculating the characteristic impedance of the TM_0 mode in a PPWG,
%% and to compare it with a parallel-plate transmission line (with finite width).
% 
% Ramiro Serra, Kevin van Hastenberg - June 2023

close all; clear all;

% Constants
mu_0 = 4 * pi * 1e-7; % Permeability of free space in H/m
epsilon_0 = 8.854187817e-12; % Permittivity of free space in F/m
c = 3e8; % Speed of light in m/s

% Signal - Define all the parameters of the signal, such as frequency,
% speed, etc.
f = 3e9; % Frequency in Hz
lambda = c / f; % Wavelength in meters

% PPTL parameters - Define the parameters of the PPTL, such as TL_Length,
% Separation, vector for the widths, etc.
TL_length = 0.80; % Length of the transmission line in meters
a = 0.23; % Separation between plates in meters
e_r = 1; % Relative permittivity (air-filled, so e_r = 1)
width = linspace(0.1, 1, 100); % Vector of widths from 0.1 to 1 meters

% Create PPTL object in MatLab (the RF toolbox must be installed!)
PPTL = rfckt.parallelplate; % Warning! the default parameters do not coincide with the parametes of the exercise!
set(PPTL,'LineLength',TL_length,'Separation',a,'EpsilonR',e_r);

Z_PPTL = zeros(1,length(width)); % The assumption is that 'width' is a vector containing several widths of the PPTL

for ii=1:length(width)
    set(PPTL,'Width',width(ii)); % This is an example on how to set a specific parameter in the PPTL, in this case, the width
    analyze(PPTL,f);
    Z_PPTL(ii)= getz0(PPTL); % Characteristic impedance of PPTL
end

% PPWG TM_0
Z_PPWG_TM_0 = zeros(1,length(width));
for ii=1:length(width)
    Z_PPWG_TM_0(ii) = (a / width(ii)) * sqrt(mu_0 / epsilon_0); % Characteristic impedance of PPWG TM_0 mode
end

figure;
plot(width,Z_PPTL)
hold all
plot(width,Z_PPWG_TM_0)
xlabel('Width  [m]')
ylabel('|Z|  [\Omega]')
legend('PPTL','PPWG')
title('Characteristic Impedance vs Width')
grid on

% Investigate the role of the frequency in the wave impedances
frequencies = linspace(1e9, 10e9, 100); % Frequencies from 1 GHz to 10 GHz
Z_PPTL_freq = zeros(1,length(frequencies));
Z_PPWG_TM_0_freq = zeros(1,length(frequencies));

for ii=1:length(frequencies)
    set(PPTL,'Width',a); % Set width to separation distance
    analyze(PPTL,frequencies(ii));
    Z_PPTL_freq(ii) = getz0(PPTL);
    Z_PPWG_TM_0_freq(ii) = (a / a) * sqrt(mu_0 / epsilon_0);
end

figure;
plot(frequencies,Z_PPTL_freq)
hold all
plot(frequencies,Z_PPWG_TM_0_freq)
xlabel('Frequency  [Hz]')
ylabel('|Z|  [\Omega]')
legend('PPTL','PPWG')
title('Characteristic Impedance vs Frequency')
grid on

% Investigate the role of the transmission line length in the wave impedances
lengths = linspace(0.1, 2, 100); % Lengths from 0.1 to 2 meters
Z_PPTL_length = zeros(1,length(lengths));
Z_PPWG_TM_0_length = zeros(1,length(lengths));

for ii=1:length(lengths)
    set(PPTL,'LineLength',lengths(ii)); % Set length
    analyze(PPTL,f);
    Z_PPTL_length(ii) = getz0(PPTL);
    Z_PPWG_TM_0_length(ii) = (a / a) * sqrt(mu_0 / epsilon_0);
end

figure;
plot(lengths,Z_PPTL_length)
hold all
plot(lengths,Z_PPWG_TM_0_length)
xlabel('Length  [m]')
ylabel('|Z|  [\Omega]')
legend('PPTL','PPWG')
title('Characteristic Impedance vs Length')
grid on

% Condition where TEM mode in a parallel-plate waveguide has the same impedance
% as the parallel-plate transmission line
condition_met = find(abs(Z_PPTL - Z_PPWG_TM_0) < 1e-6, 1); % Find the index where impedances are almost equal

if ~isempty(condition_met)
    disp(['Condition met at width: ', num2str(width(condition_met)), ' meters']);
    disp(['Wave impedance at this condition: ', num2str(Z_PPTL(condition_met)), ' Ohms']);
else
    disp('Condition where TEM mode in PPWG has the same impedance as PPTL not met within the given width range.');
end
