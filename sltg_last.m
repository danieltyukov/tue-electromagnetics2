%% fspl calc
% Constants
% f = 10e9; % 10 GHz
% c = 3e8; % Speed of light in m/s
% d = 225e9; % Distance from Mars to Earth in meters
% fspl_value = fspl(d, f);

%% Noise Power Calculation
% k = 1.38e-23; % Boltzmann's constant
% B = 10e3; % Bandwidth in Hz
% T = 290; % Temperature in Kelvin
% N = k * B * T;

%% Link Budget
% % Received gain and required SNR
% G_r = 60; % in dBi
% SNR = 10; % in dB
% 
% % Calculate required transmit power (Pt)
% Pt = N * fspl_value / (10^(G_r/10) * 10^(SNR/10));
